// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

BranchModel branchModelFromJson(String str) => BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel data) => json.encode(data.toJson());

class BranchModel {
  String? id;
  String? branch;
  String? regionId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  BranchModel({this.id, this.branch, this.regionId, this.createdAt, this.updatedAt, this.deletedAt});

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    id: json["id"],
    branch: json["branch"],
    regionId: json["region_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branch": branch,
    "region_id": regionId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
