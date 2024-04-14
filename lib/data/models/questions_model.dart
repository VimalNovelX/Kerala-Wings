class QuestionsModel {
  String? status;
  String? msg;
  List<Data>? data;

  QuestionsModel({this.status, this.msg, this.data});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
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
  String? driverType;
  String? short;
  String? qus;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.driverType,
        this.short,
        this.qus,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverType = json['driver_type'];
    short = json['short'];
    qus = json['qus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driver_type'] = this.driverType;
    data['short'] = this.short;
    data['qus'] = this.qus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}