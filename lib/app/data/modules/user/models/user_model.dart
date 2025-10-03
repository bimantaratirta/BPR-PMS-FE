// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? username;
  String? role;
  Region? region;
  Branch? branch;
  Supervisor? supervisor;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.role,
    this.region,
    this.branch,
    this.supervisor,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    role: json["role"],
    region: json["region"] == null ? null : Region.fromJson(json["region"]),
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    supervisor: json["supervisor"] == null ? null : Supervisor.fromJson(json["supervisor"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "role": role,
    "region": region?.toJson(),
    "branch": branch?.toJson(),
    "supervisor": supervisor?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Branch {
  String? id;
  String? branch;

  Branch({this.id, this.branch});

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(id: json["id"], branch: json["branch"]);

  Map<String, dynamic> toJson() => {"id": id, "branch": branch};
}

class Region {
  String? id;
  String? region;

  Region({this.id, this.region});

  factory Region.fromJson(Map<String, dynamic> json) => Region(id: json["id"], region: json["region"]);

  Map<String, dynamic> toJson() => {"id": id, "region": region};
}

class Supervisor {
  String? id;
  String? name;

  Supervisor({this.id, this.name});

  factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
