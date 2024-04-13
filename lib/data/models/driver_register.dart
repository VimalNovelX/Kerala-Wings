class DriverRegisterModel {
  String? status;
  String? msg;
  var data;

  DriverRegisterModel({this.status, this.msg, this.data});

  DriverRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }
}
