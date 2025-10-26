import 'dart:math';

import 'package:bpr_pms/app/common/constant/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ChartType { weekly, monthly }

class ChartData {
  final String label; // Misalnya: 'Sen', 'Sel', 'Rab'
  final double value; // Nilai numerik
  final int x; // Index (0, 1, 2, ...)

  ChartData(this.x, this.label, this.value);
}

class LoNasabahChart extends StatefulWidget {
  final List<double> values;
  final ChartType type;

  LoNasabahChart({
    super.key,
    required this.values,
    this.type = ChartType.weekly, // Default ke 'weekly'
  });

  final Color barBackgroundColor = Colors.white.withOpacity(0.3);
  final Color barColor = Colors.white;
  final Color touchedBarColor = Colors.green;

  @override
  State<StatefulWidget> createState() => LoNasabahChartState();
}

class LoNasabahChartState extends State<LoNasabahChart> {
  final Duration animDuration = const Duration(milliseconds: 250);
  final RxInt touchedIndex = (-1).obs;

  static const List<String> _weeklyLabels = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
  static const List<String> _monthlyLabels = ['Ming 1', 'Ming 2', 'Ming 3', 'Ming 4'];

  List<ChartData> get chartDataList {
    final List<String> labels = (widget.type == ChartType.weekly) ? _weeklyLabels : _monthlyLabels;

    final List<double> values = widget.values;

    List<ChartData> generatedData = [];
    for (int i = 0; i < values.length; i++) {
      String label = (i < labels.length) ? labels[i] : 'Data ${i + 1}';
      generatedData.add(ChartData(i, label, values[i]));
    }
    return generatedData;
  }

  double get maxY {
    if (chartDataList.isEmpty) return 2.0;

    double maxValue = chartDataList.map((d) => d.value).reduce(max);

    if (maxValue == 0) return 2.0;

    return (maxValue * 1.2).ceilToDouble();
  }

  double get yAxisInterval {
    if (maxY <= 10) return 2.0;
    if (maxY <= 25) return 5.0;
    if (maxY <= 50) return 10.0;
    return (maxY / 5).ceilToDouble();
  }

  List<BarChartGroupData> get barGroups => chartDataList.map((item) {
    bool isTouched = item.x == touchedIndex.value;
    return makeGroupData(item.x, item.value, barColor: SecondaryColor.neutral400, isTouched: isTouched);
  }).toList();

  @override
  Widget build(BuildContext context) {
    if (chartDataList.isEmpty) {
      return AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: Text('Tidak ada data', style: Get.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
        ),
      );
    }

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
                    maxY: maxY,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => Colors.black,
                        tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                        tooltipMargin: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          String weekDay = chartDataList[group.x].label;
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
                          reservedSize: 30,
                          interval: yAxisInterval,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(
                      show: true,
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
    double width = 28, // Anda bisa sesuaikan ini jika bar-nya terlalu lebar/tipis
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: (y == 0 && !isTouched) ? 0.1 : (isTouched ? y + 1 : y),
          color: isTouched ? MainColor.blue5 : barColor,
          width: width,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          backDrawRodData: BackgroundBarChartRodData(show: false),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14);

    if (value == 0) {
      return Container();
    }

    if (value % yAxisInterval != 0) {
      return Container();
    }

    String text = value.toStringAsFixed(0);

    if (value >= 1000) {
      text = '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      text = '${value.toStringAsFixed(0)}';
    }

    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = chartDataList.map((d) => d.label).toList();

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
