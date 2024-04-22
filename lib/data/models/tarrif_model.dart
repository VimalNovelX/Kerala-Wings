class DriverTariffModel {
  String? status;
  String? msg;
  Data? data;

  DriverTariffModel({this.status, this.msg, this.data});

  DriverTariffModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? tarif1;
  String? tarif2;
  String? tarif3;

  Data({this.tarif1, this.tarif2, this.tarif3});

  Data.fromJson(Map<String, dynamic> json) {
    tarif1 = json['tarif1'];
    tarif2 = json['tarif2'];
    tarif3 = json['tarif3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tarif1'] = this.tarif1;
    data['tarif2'] = this.tarif2;
    data['tarif3'] = this.tarif3;
    return data;
  }
}
