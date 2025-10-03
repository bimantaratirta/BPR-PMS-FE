import 'dart:convert';

ApiResponseModel<T> apiResponseModelFromJson<T>(String str, T Function(Map<String, dynamic>) fromJsonT) =>
    ApiResponseModel.fromJson(json.decode(str), fromJsonT);

String apiResponseModelToJson<T>(ApiResponseModel<T> data, Map<String, dynamic> Function(T) toJsonT) =>
    json.encode(data.toJson(toJsonT));

class ApiResponseModel<T> {
  int? code;
  String? status;
  String? message;
  dynamic pagination;
  T? data;
  dynamic errors;
  dynamic error;

  ApiResponseModel({this.code, this.status, this.message, this.pagination, this.data, this.errors, this.error});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    final rawData = json["data"];

    T? parsedData;
    if (rawData != null && rawData is Map<String, dynamic>) {
      parsedData = fromJsonT(rawData);
    } else {
      parsedData = null;
    }

    return ApiResponseModel<T>(
      code: json["code"],
      status: json["status"],
      message: json["message"],
      pagination: json["pagination"],
      data: parsedData,
      errors: json["errors"],
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    final serializedData = data != null ? toJsonT(data!) : null;

    return {
      "code": code,
      "status": status,
      "message": message,
      "pagination": pagination,
      "data": serializedData,
      "errors": errors,
      "error": error,
    };
  }
}
