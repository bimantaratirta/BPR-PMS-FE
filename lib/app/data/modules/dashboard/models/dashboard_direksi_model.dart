// To parse this JSON data, do
//
//     final dashboardDireksiModel = dashboardDireksiModelFromJson(jsonString);

import 'dart:convert';

DashboardDireksiModel dashboardDireksiModelFromJson(String str) => DashboardDireksiModel.fromJson(json.decode(str));

String dashboardDireksiModelToJson(DashboardDireksiModel data) => json.encode(data.toJson());

class DashboardDireksiModel {
  List<AmReport>? amReports;
  TotalBy? totalByWeek;
  TotalBy? totalByMonth;

  DashboardDireksiModel({this.amReports, this.totalByWeek, this.totalByMonth});

  factory DashboardDireksiModel.fromJson(Map<String, dynamic> json) => DashboardDireksiModel(
    amReports: json["amReports"] == null ? [] : List<AmReport>.from(json["amReports"]!.map((x) => AmReport.fromJson(x))),
    totalByWeek: json["totalByWeek"] == null ? null : TotalBy.fromJson(json["totalByWeek"]),
    totalByMonth: json["totalByMonth"] == null ? null : TotalBy.fromJson(json["totalByMonth"]),
  );

  Map<String, dynamic> toJson() => {
    "amReports": amReports == null ? [] : List<dynamic>.from(amReports!.map((x) => x.toJson())),
    "totalByWeek": totalByWeek?.toJson(),
    "totalByMonth": totalByMonth?.toJson(),
  };
}

class AmReport {
  String? region;
  int? currentPeriodReportsWeek;
  int? previousPeriodReportsWeek;
  double? percentageChangeWeek;
  int? currentPeriodReportsMonth;
  int? previousPeriodReportsMonth;
  double? percentageChangeMonth;

  AmReport({
    this.region,
    this.currentPeriodReportsWeek,
    this.previousPeriodReportsWeek,
    this.percentageChangeWeek,
    this.currentPeriodReportsMonth,
    this.previousPeriodReportsMonth,
    this.percentageChangeMonth,
  });

  factory AmReport.fromJson(Map<String, dynamic> json) => AmReport(
    region: json["region"],
    currentPeriodReportsWeek: json["currentPeriodReportsWeek"],
    previousPeriodReportsWeek: json["previousPeriodReportsWeek"],
    percentageChangeWeek: json["percentageChangeWeek"]?.toDouble(),
    currentPeriodReportsMonth: json["currentPeriodReportsMonth"],
    previousPeriodReportsMonth: json["previousPeriodReportsMonth"],
    percentageChangeMonth: json["percentageChangeMonth"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "region": region,
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
