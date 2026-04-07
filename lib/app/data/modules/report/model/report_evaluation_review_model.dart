// To parse this JSON data, do
//
//     final reportEvaluationReviewModel = reportEvaluationReviewModelFromJson(jsonString);

import 'dart:convert';

ReportEvaluationReviewModel reportEvaluationReviewModelFromJson(String str) =>
    ReportEvaluationReviewModel.fromJson(json.decode(str));

String reportEvaluationReviewModelToJson(ReportEvaluationReviewModel data) => json.encode(data.toJson());

class ReportEvaluationReviewModel {
  String? id;
  String? evaluationId;
  bool? reviewCharacter;
  bool? reviewCapacity;
  bool? reviewCondition;
  bool? reviewCapital;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  ReportEvaluationReviewModel({
    this.id,
    this.evaluationId,
    this.reviewCharacter,
    this.reviewCapacity,
    this.reviewCondition,
    this.reviewCapital,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ReportEvaluationReviewModel.fromJson(Map<String, dynamic> json) => ReportEvaluationReviewModel(
    id: json["id"],
    evaluationId: json["evaluation_id"],
    reviewCharacter: json["review_character"],
    reviewCapacity: json["review_capacity"],
    reviewCondition: json["review_condition"],
    reviewCapital: json["review_capital"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "evaluation_id": evaluationId,
    "review_character": reviewCharacter,
    "review_capacity": reviewCapacity,
    "review_condition": reviewCondition,
    "review_capital": reviewCapital,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
  };
}
