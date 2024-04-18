class LeaveHistoryModel {
  String? status;
  String? msg;
  List<Data>? data;

  LeaveHistoryModel({this.status, this.msg, this.data});

  LeaveHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? driverId;
  String? fromDateTime;
  String? toDateTime;
  String? days;
  Null? description;
  String? deviceType;
  String? leaveStatus;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.driverId,
        this.fromDateTime,
        this.toDateTime,
        this.days,
        this.description,
        this.deviceType,
        this.leaveStatus,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driver_id'];
    fromDateTime = json['from_date_time'];
    toDateTime = json['to_date_time'];
    days = json['days'];
    description = json['description'];
    deviceType = json['device_type'];
    leaveStatus = json['leave_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driver_id'] = this.driverId;
    data['from_date_time'] = this.fromDateTime;
    data['to_date_time'] = this.toDateTime;
    data['days'] = this.days;
    data['description'] = this.description;
    data['device_type'] = this.deviceType;
    data['leave_status'] = this.leaveStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
