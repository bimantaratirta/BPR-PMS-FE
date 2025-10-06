// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  String? id;
  String? name;
  String? ktpNumber;
  DateTime? dateOfBirth;
  String? address;
  String? rtRw;
  String? village;
  String? phoneNumber;
  String? employeeId;
  String? nonEmployeeId;
  String? businessId;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Employee? employee;
  NonEmployee? nonEmployee;
  Business? business;
  String? workType;

  CustomerModel({
    this.id,
    this.name,
    this.ktpNumber,
    this.dateOfBirth,
    this.address,
    this.rtRw,
    this.village,
    this.phoneNumber,
    this.employeeId,
    this.nonEmployeeId,
    this.businessId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.employee,
    this.nonEmployee,
    this.business,
    this.workType,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    id: json["id"],
    name: json["name"],
    ktpNumber: json["ktp_number"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    address: json["address"],
    rtRw: json["rt_rw"],
    village: json["village"],
    phoneNumber: json["phone_number"],
    employeeId: json["employee_id"],
    nonEmployeeId: json["non_employee_id"],
    businessId: json["business_id"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
    employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
    nonEmployee: json["non_employee"] == null ? null : NonEmployee.fromJson(json["non_employee"]),
    business: json["business"] == null ? null : Business.fromJson(json["business"]),
    workType: json["work_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "ktp_number": ktpNumber,
    "date_of_birth": dateOfBirth?.toIso8601String(),
    "address": address,
    "rt_rw": rtRw,
    "village": village,
    "phone_number": phoneNumber,
    "employee_id": employeeId,
    "non_employee_id": nonEmployeeId,
    "business_id": businessId,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
    "employee": employee?.toJson(),
    "non_employee": nonEmployee?.toJson(),
    "business": business?.toJson(),
    "work_type": workType,
  };
}

class Business {
  String? id;
  String? businessType;
  int? employeeCount;
  int? revenue;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Business({this.id, this.businessType, this.employeeCount, this.revenue, this.createdAt, this.updatedAt, this.deletedAt});

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["id"],
    businessType: json["business_type"],
    employeeCount: json["employee_count"],
    revenue: json["revenue"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_type": businessType,
    "employee_count": employeeCount,
    "revenue": revenue,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
  };
}

class Employee {
  String? id;
  String? companyName;
  String? companyAddress;
  String? companyPhone;
  String? position;
  String? work;
  int? salary;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Employee({
    this.id,
    this.companyName,
    this.companyAddress,
    this.companyPhone,
    this.position,
    this.work,
    this.salary,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    companyName: json["company_name"],
    companyAddress: json["company_address"],
    companyPhone: json["company_phone"],
    position: json["position"],
    work: json["work"],
    salary: json["salary"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_name": companyName,
    "company_address": companyAddress,
    "company_phone": companyPhone,
    "position": position,
    "work": work,
    "salary": salary,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
  };
}

class NonEmployee {
  String? id;
  String? salaryFrequency;
  String? work;
  int? salary;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  NonEmployee({this.id, this.salaryFrequency, this.work, this.salary, this.createdAt, this.updatedAt, this.deletedAt});

  factory NonEmployee.fromJson(Map<String, dynamic> json) => NonEmployee(
    id: json["id"],
    salaryFrequency: json["salary_frequency"],
    work: json["work"],
    salary: json["salary"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "salary_frequency": salaryFrequency,
    "work": work,
    "salary": salary,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
  };
}
