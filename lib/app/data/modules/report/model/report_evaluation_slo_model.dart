// To parse this JSON data, do
//
//     final reportEvaluationSloModel = reportEvaluationSloModelFromJson(jsonString);

import 'dart:convert';

ReportEvaluationSloModel reportEvaluationSloModelFromJson(String str) => ReportEvaluationSloModel.fromJson(json.decode(str));

String reportEvaluationSloModelToJson(ReportEvaluationSloModel data) => json.encode(data.toJson());

class ReportEvaluationSloModel {
  String? id;
  String? reportId;
  String? character;
  String? statusCharacter;
  String? capacity;
  String? statusCapacity;
  String? condition;
  String? statusCondition;
  String? capital;
  String? statusCapital;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  ReportEvaluationSloModel({
    this.id,
    this.reportId,
    this.character,
    this.statusCharacter,
    this.capacity,
    this.statusCapacity,
    this.condition,
    this.statusCondition,
    this.capital,
    this.statusCapital,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ReportEvaluationSloModel.fromJson(Map<String, dynamic> json) => ReportEvaluationSloModel(
    id: json["id"],
    reportId: json["report_id"],
    character: json["character"],
    statusCharacter: json["status_character"],
    capacity: json["capacity"],
    statusCapacity: json["status_capacity"],
    condition: json["condition"],
    statusCondition: json["status_condition"],
    capital: json["capital"],
    statusCapital: json["status_capital"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "report_id": reportId,
    "character": character,
    "status_character": statusCharacter,
    "capacity": capacity,
    "status_capacity": statusCapacity,
    "condition": condition,
    "status_condition": statusCondition,
    "capital": capital,
    "status_capital": statusCapital,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
  };
}
