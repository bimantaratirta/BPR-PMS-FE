// To parse this JSON data, do
//
//     final employeeLocationModel = employeeLocationModelFromJson(jsonString);

import 'dart:convert';

EmployeeLocationModel employeeLocationModelFromJson(String str) => EmployeeLocationModel.fromJson(json.decode(str));

String employeeLocationModelToJson(EmployeeLocationModel data) => json.encode(data.toJson());

class EmployeeLocationModel {
  String? id;
  String? userId;
  double? latitude;
  double? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  User? user;

  EmployeeLocationModel({
    this.id,
    this.userId,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
  });

  factory EmployeeLocationModel.fromJson(Map<String, dynamic> json) => EmployeeLocationModel(
    id: json["id"],
    userId: json["user_id"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "user": user?.toJson(),
  };
}

class User {
  String? id;
  String? name;

  User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) => User(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
