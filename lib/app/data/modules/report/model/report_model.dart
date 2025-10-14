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
  NonEmployeeSnapshot? nonEmployeeSnapshot;
  BusinessSnapshot? businessSnapshot;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Am? lo;
  Am? slo;
  Am? am;
  List<ReportPhoto>? reportPhoto;
  ReviewCustomer? reviewCustomer;
  Evaluation? evaluation;

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
    this.evaluation,
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
    nonEmployeeSnapshot: json["non_employee_snapshot"] == null
        ? null
        : NonEmployeeSnapshot.fromJson(json["non_employee_snapshot"]),
    businessSnapshot: json["business_snapshot"] == null ? null : BusinessSnapshot.fromJson(json["business_snapshot"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
    lo: json["lo"] == null ? null : Am.fromJson(json["lo"]),
    slo: json["slo"] == null ? null : Am.fromJson(json["slo"]),
    am: json["am"] == null ? null : Am.fromJson(json["am"]),
    reportPhoto: json["report_photo"] == null
        ? []
        : List<ReportPhoto>.from(json["report_photo"]!.map((x) => ReportPhoto.fromJson(x))),
    reviewCustomer: json["review_customer"] == null ? null : ReviewCustomer.fromJson(json["review_customer"]),
    evaluation: json["evaluation"] == null ? null : Evaluation.fromJson(json["evaluation"]),
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
    "non_employee_snapshot": nonEmployeeSnapshot?.toJson(),
    "business_snapshot": businessSnapshot?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
    "lo": lo?.toJson(),
    "slo": slo?.toJson(),
    "am": am?.toJson(),
    "report_photo": reportPhoto == null ? [] : List<dynamic>.from(reportPhoto!.map((x) => x.toJson())),
    "review_customer": reviewCustomer?.toJson(),
    "evaluation": evaluation?.toJson(),
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

class BusinessSnapshot {
  String? id;
  int? revenue;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? businessType;
  int? employeeCount;

  BusinessSnapshot({this.id, this.revenue, this.createdAt, this.updatedAt, this.businessType, this.employeeCount});

  factory BusinessSnapshot.fromJson(Map<String, dynamic> json) => BusinessSnapshot(
    id: json["id"],
    revenue: json["revenue"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    businessType: json["business_type"],
    employeeCount: json["employee_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "revenue": revenue,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "business_type": businessType,
    "employee_count": employeeCount,
  };
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
  String? businessId;
  String? employeeId;
  String? phoneNumber;
  DateTime? dateOfBirth;
  String? nonEmployeeId;

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
  int? salary;
  String? position;
  DateTime? createdAt;
  String? occupation;
  DateTime? updatedAt;
  String? companyName;
  String? companyPhone;
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

class Evaluation {
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
  ReviewEvaluation? reviewEvaluation;

  Evaluation({
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
    this.reviewEvaluation,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
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
    reviewEvaluation: json["review_evaluation"] == null ? null : ReviewEvaluation.fromJson(json["review_evaluation"]),
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
    "review_evaluation": reviewEvaluation?.toJson(),
  };
}

class ReviewEvaluation {
  String? id;
  String? evaluationId;
  bool? reviewCharacter;
  bool? reviewCapacity;
  bool? reviewCondition;
  bool? reviewCapital;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  ReviewEvaluation({
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

  factory ReviewEvaluation.fromJson(Map<String, dynamic> json) => ReviewEvaluation(
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

class NonEmployeeSnapshot {
  String? id;
  int? salary;
  DateTime? createdAt;
  String? occupation;
  DateTime? updatedAt;
  String? salaryFrequency;

  NonEmployeeSnapshot({this.id, this.salary, this.createdAt, this.occupation, this.updatedAt, this.salaryFrequency});

  factory NonEmployeeSnapshot.fromJson(Map<String, dynamic> json) => NonEmployeeSnapshot(
    id: json["id"],
    salary: json["salary"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    occupation: json["occupation"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    salaryFrequency: json["salary_frequency"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "salary": salary,
    "created_at": createdAt?.toIso8601String(),
    "occupation": occupation,
    "updated_at": updatedAt?.toIso8601String(),
    "salary_frequency": salaryFrequency,
  };
}

class ReportPhoto {
  String? id;
  String? reportId;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  ReportPhoto({this.id, this.reportId, this.url, this.createdAt, this.updatedAt, this.deletedAt});

  factory ReportPhoto.fromJson(Map<String, dynamic> json) => ReportPhoto(
    id: json["id"],
    reportId: json["report_id"],
    url: json["url"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "report_id": reportId,
    "url": url,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
  };
}

class ReviewCustomer {
  String? id;
  String? reportId;
  bool? reviewIdentity;
  bool? reviewDomicile;
  bool? reviewWork;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  ReviewCustomer({
    this.id,
    this.reportId,
    this.reviewIdentity,
    this.reviewDomicile,
    this.reviewWork,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ReviewCustomer.fromJson(Map<String, dynamic> json) => ReviewCustomer(
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
