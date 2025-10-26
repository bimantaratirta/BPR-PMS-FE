// To parse this JSON data, do
//
//     final regionModel = regionModelFromJson(jsonString);

import 'dart:convert';

RegionModel regionModelFromJson(String str) => RegionModel.fromJson(json.decode(str));

String regionModelToJson(RegionModel data) => json.encode(data.toJson());

class RegionModel {
  String? id;
  String? region;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  List<Branch>? branches;
  int? branchCount;

  RegionModel({this.id, this.region, this.createdAt, this.updatedAt, this.deletedAt, this.branches, this.branchCount});

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
    id: json["id"],
    region: json["region"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
    branches: json["branches"] == null ? [] : List<Branch>.from(json["branches"]!.map((x) => Branch.fromJson(x))),
    branchCount: json["branchCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "region": region,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
    "branches": branches == null ? [] : List<dynamic>.from(branches!.map((x) => x.toJson())),
    "branchCount": branchCount,
  };
}

class Branch {
  String? id;
  String? branch;
  String? regionId;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Branch({this.id, this.branch, this.regionId, this.address, this.createdAt, this.updatedAt, this.deletedAt});

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    branch: json["branch"],
    regionId: json["region_id"],
    address: json["address"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branch": branch,
    "region_id": regionId,
    "address": address,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
  };
}
