// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'dart:convert';

ReportModel reportModelFromJson(String str) => ReportModel.fromJson(json.decode(str));

String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  String? id;
  String? status;
  String? process;
  String? customerId;
  String? loId;
  String? sloId;
  String? amId;
  CustomerSnapshot? customerSnapshot;
  EmployeeSnapshot? employeeSnapshot;
  dynamic nonEmployeeSnapshot;
  dynamic businessSnapshot;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Am? lo;
  Am? slo;
  Am? am;
  List<ReportPhoto>? reportPhoto;
  dynamic reviewCustomer;

  ReportModel({
    this.id,
    this.status,
    this.process,
    this.customerId,
    this.loId,
    this.sloId,
    this.amId,
    this.customerSnapshot,
    this.employeeSnapshot,
    this.nonEmployeeSnapshot,
    this.businessSnapshot,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.lo,
    this.slo,
    this.am,
    this.reportPhoto,
    this.reviewCustomer,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    id: json["id"],
    status: json["status"],
    process: json["process"],
    customerId: json["customer_id"],
    loId: json["lo_id"],
    sloId: json["slo_id"],
    amId: json["am_id"],
    customerSnapshot: json["customer_snapshot"] == null ? null : CustomerSnapshot.fromJson(json["customer_snapshot"]),
    employeeSnapshot: json["employee_snapshot"] == null ? null : EmployeeSnapshot.fromJson(json["employee_snapshot"]),
    nonEmployeeSnapshot: json["non_employee_snapshot"],
    businessSnapshot: json["business_snapshot"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    lo: json["lo"] == null ? null : Am.fromJson(json["lo"]),
    slo: json["slo"] == null ? null : Am.fromJson(json["slo"]),
    am: json["am"] == null ? null : Am.fromJson(json["am"]),
    reportPhoto: json["report_photo"] == null
        ? []
        : List<ReportPhoto>.from(json["report_photo"]!.map((x) => ReportPhoto.fromJson(x))),
    reviewCustomer: json["review_customer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "process": process,
    "customer_id": customerId,
    "lo_id": loId,
    "slo_id": sloId,
    "am_id": amId,
    "customer_snapshot": customerSnapshot?.toJson(),
    "employee_snapshot": employeeSnapshot?.toJson(),
    "non_employee_snapshot": nonEmployeeSnapshot,
    "business_snapshot": businessSnapshot,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "lo": lo?.toJson(),
    "slo": slo?.toJson(),
    "am": am?.toJson(),
    "report_photo": reportPhoto == null ? [] : List<dynamic>.from(reportPhoto!.map((x) => x.toJson())),
    "review_customer": reviewCustomer,
  };
}

class Am {
  String? id;
  String? name;
  String? username;

  Am({this.id, this.name, this.username});

  factory Am.fromJson(Map<String, dynamic> json) => Am(id: json["id"], name: json["name"], username: json["username"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "username": username};
}

class CustomerSnapshot {
  String? id;
  String? name;
  String? rtRw;
  String? address;
  String? village;
  String? workType;
  DateTime? createdAt;
  String? createdBy;
  String? ktpNumber;
  DateTime? updatedAt;
  dynamic businessId;
  String? employeeId;
  String? phoneNumber;
  DateTime? dateOfBirth;
  dynamic nonEmployeeId;

  CustomerSnapshot({
    this.id,
    this.name,
    this.rtRw,
    this.address,
    this.village,
    this.workType,
    this.createdAt,
    this.createdBy,
    this.ktpNumber,
    this.updatedAt,
    this.businessId,
    this.employeeId,
    this.phoneNumber,
    this.dateOfBirth,
    this.nonEmployeeId,
  });

  factory CustomerSnapshot.fromJson(Map<String, dynamic> json) => CustomerSnapshot(
    id: json["id"],
    name: json["name"],
    rtRw: json["rt_rw"],
    address: json["address"],
    village: json["village"],
    workType: json["work_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    ktpNumber: json["ktp_number"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    businessId: json["business_id"],
    employeeId: json["employee_id"],
    phoneNumber: json["phone_number"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    nonEmployeeId: json["non_employee_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "rt_rw": rtRw,
    "address": address,
    "village": village,
    "work_type": workType,
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "ktp_number": ktpNumber,
    "updated_at": updatedAt?.toIso8601String(),
    "business_id": businessId,
    "employee_id": employeeId,
    "phone_number": phoneNumber,
    "date_of_birth": dateOfBirth?.toIso8601String(),
    "non_employee_id": nonEmployeeId,
  };
}

class EmployeeSnapshot {
  String? id;
  dynamic salary;
  dynamic position;
  DateTime? createdAt;
  dynamic occupation;
  DateTime? updatedAt;
  dynamic companyName;
  dynamic companyPhone;
  String? companyAddress;

  EmployeeSnapshot({
    this.id,
    this.salary,
    this.position,
    this.createdAt,
    this.occupation,
    this.updatedAt,
    this.companyName,
    this.companyPhone,
    this.companyAddress,
  });

  factory EmployeeSnapshot.fromJson(Map<String, dynamic> json) => EmployeeSnapshot(
    id: json["id"],
    salary: json["salary"],
    position: json["position"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    occupation: json["occupation"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    companyName: json["company_name"],
    companyPhone: json["company_phone"],
    companyAddress: json["company_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "salary": salary,
    "position": position,
    "created_at": createdAt?.toIso8601String(),
    "occupation": occupation,
    "updated_at": updatedAt?.toIso8601String(),
    "company_name": companyName,
    "company_phone": companyPhone,
    "company_address": companyAddress,
  };
}

class ReportPhoto {
  String? id;
  String? reportId;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  ReportPhoto({this.id, this.reportId, this.url, this.createdAt, this.updatedAt, this.deletedAt});

  factory ReportPhoto.fromJson(Map<String, dynamic> json) => ReportPhoto(
    id: json["id"],
    reportId: json["report_id"],
    url: json["url"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "report_id": reportId,
    "url": url,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
