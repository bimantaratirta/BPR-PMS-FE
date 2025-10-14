// To parse this JSON data, do
//
//     final reportReviewCustomerModel = reportReviewCustomerModelFromJson(jsonString);

import 'dart:convert';

ReportReviewCustomerModel reportReviewCustomerModelFromJson(String str) =>
    ReportReviewCustomerModel.fromJson(json.decode(str));

String reportReviewCustomerModelToJson(ReportReviewCustomerModel data) => json.encode(data.toJson());

class ReportReviewCustomerModel {
  String? id;
  String? reportId;
  bool? reviewIdentity;
  bool? reviewDomicile;
  bool? reviewWork;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  ReportReviewCustomerModel({
    this.id,
    this.reportId,
    this.reviewIdentity,
    this.reviewDomicile,
    this.reviewWork,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ReportReviewCustomerModel.fromJson(Map<String, dynamic> json) => ReportReviewCustomerModel(
    id: json["id"],
    reportId: json["report_id"],
    reviewIdentity: json["review_identity"],
    reviewDomicile: json["review_domicile"],
    reviewWork: json["review_work"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "report_id": reportId,
    "review_identity": reviewIdentity,
    "review_domicile": reviewDomicile,
    "review_work": reviewWork,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
  };
}
