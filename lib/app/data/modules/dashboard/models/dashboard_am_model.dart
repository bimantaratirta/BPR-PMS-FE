// To parse this JSON data, do
//
//     final dashboardAmModel = dashboardAmModelFromJson(jsonString);

import 'dart:convert';

DashboardAmModel dashboardAmModelFromJson(String str) => DashboardAmModel.fromJson(json.decode(str));

String dashboardAmModelToJson(DashboardAmModel data) => json.encode(data.toJson());

class DashboardAmModel {
  List<SloReport>? sloReports;
  TotalBy? totalByWeek;
  TotalBy? totalByMonth;

  DashboardAmModel({this.sloReports, this.totalByWeek, this.totalByMonth});

  factory DashboardAmModel.fromJson(Map<String, dynamic> json) => DashboardAmModel(
    sloReports: json["sloReports"] == null
        ? []
        : List<SloReport>.from(json["sloReports"]!.map((x) => SloReport.fromJson(x))),
    totalByWeek: json["totalByWeek"] == null ? null : TotalBy.fromJson(json["totalByWeek"]),
    totalByMonth: json["totalByMonth"] == null ? null : TotalBy.fromJson(json["totalByMonth"]),
  );

  Map<String, dynamic> toJson() => {
    "sloReports": sloReports == null ? [] : List<dynamic>.from(sloReports!.map((x) => x.toJson())),
    "totalByWeek": totalByWeek?.toJson(),
    "totalByMonth": totalByMonth?.toJson(),
  };
}

class SloReport {
  String? sloName;
  int? currentPeriodReportsWeek;
  int? previousPeriodReportsWeek;
  double? percentageChangeWeek;
  int? currentPeriodReportsMonth;
  int? previousPeriodReportsMonth;
  double? percentageChangeMonth;

  SloReport({
    this.sloName,
    this.currentPeriodReportsWeek,
    this.previousPeriodReportsWeek,
    this.percentageChangeWeek,
    this.currentPeriodReportsMonth,
    this.previousPeriodReportsMonth,
    this.percentageChangeMonth,
  });

  factory SloReport.fromJson(Map<String, dynamic> json) => SloReport(
    sloName: json["sloName"],
    currentPeriodReportsWeek: json["currentPeriodReportsWeek"],
    previousPeriodReportsWeek: json["previousPeriodReportsWeek"],
    percentageChangeWeek: json["percentageChangeWeek"]?.toDouble(),
    currentPeriodReportsMonth: json["currentPeriodReportsMonth"],
    previousPeriodReportsMonth: json["previousPeriodReportsMonth"],
    percentageChangeMonth: json["percentageChangeMonth"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "sloName": sloName,
    "currentPeriodReportsWeek": currentPeriodReportsWeek,
    "previousPeriodReportsWeek": previousPeriodReportsWeek,
    "percentageChangeWeek": percentageChangeWeek,
    "currentPeriodReportsMonth": currentPeriodReportsMonth,
    "previousPeriodReportsMonth": previousPeriodReportsMonth,
    "percentageChangeMonth": percentageChangeMonth,
  };
}

class TotalBy {
  int? totalCurrentPeriod;
  int? totalPreviousPeriod;
  double? totalPercentageChange;

  TotalBy({this.totalCurrentPeriod, this.totalPreviousPeriod, this.totalPercentageChange});

  factory TotalBy.fromJson(Map<String, dynamic> json) => TotalBy(
    totalCurrentPeriod: json["totalCurrentPeriod"],
    totalPreviousPeriod: json["totalPreviousPeriod"],
    totalPercentageChange: json["totalPercentageChange"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "totalCurrentPeriod": totalCurrentPeriod,
    "totalPreviousPeriod": totalPreviousPeriod,
    "totalPercentageChange": totalPercentageChange,
  };
}
