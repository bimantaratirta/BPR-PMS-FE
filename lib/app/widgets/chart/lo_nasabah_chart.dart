import 'dart:math';

import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartData {
  final String label; // Misalnya: 'Sen', 'Sel', 'Rab'
  final double value; // Nilai numerik
  final int x; // Index (0, 1, 2, ...)

  ChartData(this.x, this.label, this.value);
}

class LoNasabahChart extends StatefulWidget {
  LoNasabahChart({super.key});

  final Color barBackgroundColor = Colors.white.withOpacity(0.3);
  final Color barColor = Colors.white;
  final Color touchedBarColor = Colors.green;

  @override
  State<StatefulWidget> createState() => LoNasabahChartState();
}

class LoNasabahChartState extends State<LoNasabahChart> {
  final Duration animDuration = const Duration(milliseconds: 250);
  final RxInt touchedIndex = (-1).obs;

  final List<ChartData> data = [
    ChartData(0, 'Sen', 5.0),
    ChartData(1, 'Sel', 6.5),
    ChartData(2, 'Rab', 5.0),
    ChartData(3, 'Kam', 7.5),
    ChartData(4, 'Jum', 9.0),
    ChartData(5, 'Sab', 11.5),
    ChartData(6, 'Min', 6.5),
  ];

  // Hitung nilai Y maksimum untuk menentukan batas atas grafik
  double get maxY {
    double maxValue = data.map((d) => d.value).reduce(max);
    // Kita tambahkan buffer 20% agar bar tidak menempel di batas atas
    return (maxValue * 1.2).ceilToDouble();
  }

  // Hitung interval untuk label sumbu Y (agar lebih rapi, misal kelipatan 5, 10, atau 20)
  double get yAxisInterval {
    // Menentukan interval yang bagus berdasarkan maxY
    if (maxY <= 10) return 2.0;
    if (maxY <= 25) return 5.0;
    if (maxY <= 50) return 10.0;
    return (maxY / 5).ceilToDouble(); // Ambil 5 garis utama
  }

  // BarChartGroupData yang dibuat secara dinamis dari list data
  List<BarChartGroupData> get barGroups => data.map((item) {
    bool isTouched = item.x == touchedIndex.value;
    return makeGroupData(item.x, item.value, barColor: SecondaryColor.neutral400, isTouched: isTouched);
  }).toList();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceBetween,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => Colors.black,
                        tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                        tooltipMargin: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          String weekDay = data[group.x].label;
                          return BarTooltipItem(
                            '$weekDay\n',
                            Get.textTheme.labelLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: ((rod.toY - (groupIndex == touchedIndex.value ? 1 : 0)).toStringAsFixed(1)).toString(),
                                style: Get.textTheme.labelLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                            ],
                          );
                        },
                      ),
                      touchCallback: (FlTouchEvent event, barTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              barTouchResponse == null ||
                              barTouchResponse.spot == null) {
                            touchedIndex.value = -1;
                            return;
                          }
                          touchedIndex.value = barTouchResponse.spot!.touchedBarGroupIndex;
                        });
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true, getTitlesWidget: bottomTitles, reservedSize: 38),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30, // Tambah reservedSize agar label yang lebih panjang muat
                          interval: yAxisInterval, // Menggunakan interval yang dihitung
                          getTitlesWidget: leftTitles, // Menggunakan fungsi leftTitles yang dinamis
                        ),
                      ),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(
                      show: true,
                      // Garis Horizontal mengikuti interval yang dihitung
                      checkToShowHorizontalLine: (value) => value % yAxisInterval == 0,
                      getDrawingHorizontalLine: (value) =>
                          FlLine(color: SecondaryColor.neutral400, strokeWidth: 1, dashArray: [5, 5]),
                      drawVerticalLine: false,
                      drawHorizontalLine: true,
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(color: SecondaryColor.neutral400, width: 2),
                        left: BorderSide(color: Colors.transparent),
                        right: BorderSide(color: Colors.transparent),
                        top: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    barGroups: barGroups,
                  ),
                  duration: animDuration,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 28,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          // Tambahkan 1 ke y HANYA saat disentuh untuk visual effect
          toY: isTouched ? y + 1 : y,
          color: isTouched ? MainColor.blueNormal : barColor,
          width: width,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          backDrawRodData: BackgroundBarChartRodData(show: false),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  // --- 2. LEFT TITLES DINAMIS ---
  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14);

    // Pastikan label hanya ditampilkan pada interval yang ditentukan
    if (value % yAxisInterval != 0) {
      return Container();
    }

    // Format label (misal: 10.0, 20.0, dsb.)
    // Anda bisa menambahkan format 'K' di sini jika nilai Anda dalam ribuan.
    // Misalnya, jika nilai 10.0 sebenarnya adalah 10.000, ubah seperti di bawah.
    String text = value.toStringAsFixed(0); // Contoh: "10", "20"

    // Contoh untuk menambahkan format "K" jika nilainya besar
    if (value >= 1000) {
      text = '${(value / 1000).toStringAsFixed(1)}K';
    } else if (value > 0) {
      text = '${value.toStringAsFixed(0)}';
    }

    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: Text(text, style: style),
    );
  }

  // --- 3. BOTTOM TITLES DINAMIS ---
  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = data.map((d) => d.label).toList();

    // Pastikan index value ada dalam batas array data
    if (value.toInt() < 0 || value.toInt() >= titles.length) {
      return Container();
    }

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
    );

    return SideTitleWidget(
      meta: meta,
      space: 16, //margin top
      child: text,
    );
  }
}
