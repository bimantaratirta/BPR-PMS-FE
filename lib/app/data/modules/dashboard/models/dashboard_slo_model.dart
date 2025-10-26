// To parse this JSON data, do
//
//     final dashboardSloModel = dashboardSloModelFromJson(jsonString);

import 'dart:convert';

DashboardSloModel dashboardSloModelFromJson(String str) => DashboardSloModel.fromJson(json.decode(str));

String dashboardSloModelToJson(DashboardSloModel data) => json.encode(data.toJson());

class DashboardSloModel {
  List<LoReport>? loReports;
  TotalBy? totalByWeek;
  TotalBy? totalByMonth;

  DashboardSloModel({this.loReports, this.totalByWeek, this.totalByMonth});

  factory DashboardSloModel.fromJson(Map<String, dynamic> json) => DashboardSloModel(
    loReports: json["loReports"] == null ? [] : List<LoReport>.from(json["loReports"]!.map((x) => LoReport.fromJson(x))),
    totalByWeek: json["totalByWeek"] == null ? null : TotalBy.fromJson(json["totalByWeek"]),
    totalByMonth: json["totalByMonth"] == null ? null : TotalBy.fromJson(json["totalByMonth"]),
  );

  Map<String, dynamic> toJson() => {
    "loReports": loReports == null ? [] : List<dynamic>.from(loReports!.map((x) => x.toJson())),
    "totalByWeek": totalByWeek?.toJson(),
    "totalByMonth": totalByMonth?.toJson(),
  };
}

class LoReport {
  String? loName;
  int? currentPeriodReportsWeek;
  int? previousPeriodReportsWeek;
  double? percentageChangeWeek;
  int? currentPeriodReportsMonth;
  int? previousPeriodReportsMonth;
  double? percentageChangeMonth;

  LoReport({
    this.loName,
    this.currentPeriodReportsWeek,
    this.previousPeriodReportsWeek,
    this.percentageChangeWeek,
    this.currentPeriodReportsMonth,
    this.previousPeriodReportsMonth,
    this.percentageChangeMonth,
  });

  factory LoReport.fromJson(Map<String, dynamic> json) => LoReport(
    loName: json["loName"],
    currentPeriodReportsWeek: json["currentPeriodReportsWeek"],
    previousPeriodReportsWeek: json["previousPeriodReportsWeek"],
    percentageChangeWeek: json["percentageChangeWeek"]?.toDouble(),
    currentPeriodReportsMonth: json["currentPeriodReportsMonth"],
    previousPeriodReportsMonth: json["previousPeriodReportsMonth"],
    percentageChangeMonth: json["percentageChangeMonth"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "loName": loName,
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
