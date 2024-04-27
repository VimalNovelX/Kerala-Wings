class OtpModel {
  String? status;
  String? msg;
  Data? data;

  OtpModel({this.status, this.msg, this.data});

  OtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['msg'] = msg.toString();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Driver? driver;
  int? otp; // Change the type to int

  Data({this.driver, this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    driver = json['driver'] != "" ? Driver.fromJson(json['driver']) : null;
    otp = json['otp'] as int; // Parse 'otp' as an int
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    data['otp'] = otp;
    return data;
  }
}

class Driver {
  int? id;
  String? fName;
  String? father;
  String? code;
  String? phone;
  String? driverType;
  String? address;
  String? licenceNo;
  String? adhaarNo;
  String? dob;
  String? licenceExp;
  String? salaryType;
  String? districts;
  String? hPhone;
  Null? age;
  String? activeLocation;
  String? bloodGroup;
  String? profile;
  String? frontLicence;
  String? backLicence;
  String? qus;
  int? status;
  String? deviceType;
  String? createdAt;
  String? updatedAt;
  int? star;
  String? grade;

  Driver(
      {this.id,
        this.fName,
        this.father,
        this.code,
        this.phone,
        this.driverType,
        this.address,
        this.licenceNo,
        this.adhaarNo,
        this.dob,
        this.licenceExp,
        this.salaryType,
        this.districts,
        this.hPhone,
        this.age,
        this.activeLocation,
        this.bloodGroup,
        this.profile,
        this.frontLicence,
        this.backLicence,
        this.qus,
        this.status,
        this.deviceType,
        this.createdAt,
        this.updatedAt,
        this.star,
        this.grade});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    father = json['father'];
    code = json['code'];
    phone = json['phone'];
    driverType = json['driver_type'];
    address = json['address'];
    licenceNo = json['licence_no'];
    adhaarNo = json['adhaar_no'];
    dob = json['dob'];
    licenceExp = json['licence_exp'];
    salaryType = json['salary_type'];
    districts = json['districts'];
    hPhone = json['h_phone'];
    age = json['age'];
    activeLocation = json['active_location'];
    bloodGroup = json['blood_group'];
    profile = json['profile'];
    frontLicence = json['front_licence'];
    backLicence = json['back_licence'];
    qus = json['qus'];
    status = json['status'];
    deviceType = json['device_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    star = json['star'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['father'] = this.father;
    data['code'] = this.code;
    data['phone'] = this.phone;
    data['driver_type'] = this.driverType;
    data['address'] = this.address;
    data['licence_no'] = this.licenceNo;
    data['adhaar_no'] = this.adhaarNo;
    data['dob'] = this.dob;
    data['licence_exp'] = this.licenceExp;
    data['salary_type'] = this.salaryType;
    data['districts'] = this.districts;
    data['h_phone'] = this.hPhone;
    data['age'] = this.age;
    data['active_location'] = this.activeLocation;
    data['blood_group'] = this.bloodGroup;
    data['profile'] = this.profile;
    data['front_licence'] = this.frontLicence;
    data['back_licence'] = this.backLicence;
    data['qus'] = this.qus;
    data['status'] = this.status;
    data['device_type'] = this.deviceType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['star'] = this.star;
    data['grade'] = this.grade;
    return data;
  }
}
