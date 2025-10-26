// To parse this JSON data, do
//
//     final dashboardLoModel = dashboardLoModelFromJson(jsonString);

import 'dart:convert';

DashboardLoModel dashboardLoModelFromJson(String str) => DashboardLoModel.fromJson(json.decode(str));

String dashboardLoModelToJson(DashboardLoModel data) => json.encode(data.toJson());

class DashboardLoModel {
  List<double>? customers;
  TotalBy? totalByWeek;
  TotalBy? totalByMonth;

  DashboardLoModel({this.customers, this.totalByWeek, this.totalByMonth});

  factory DashboardLoModel.fromJson(Map<String, dynamic> json) => DashboardLoModel(
    customers: json["customers"] == null ? [] : List<double>.from(json["customers"]!.map((x) => x?.toDouble())),
    totalByWeek: json["totalByWeek"] == null ? null : TotalBy.fromJson(json["totalByWeek"]),
    totalByMonth: json["totalByMonth"] == null ? null : TotalBy.fromJson(json["totalByMonth"]),
  );

  Map<String, dynamic> toJson() => {
    "customers": customers == null ? [] : List<dynamic>.from(customers!.map((x) => x)),
    "totalByWeek": totalByWeek?.toJson(),
    "totalByMonth": totalByMonth?.toJson(),
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
