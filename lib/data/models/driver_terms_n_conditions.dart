class DriverTermsNConditionModel {
  String? status;
  String? msg;
  Data? data;

  DriverTermsNConditionModel({this.status, this.msg, this.data});

  DriverTermsNConditionModel.fromJson(Map<String, dynamic> json) {
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
  List<English>? english;
  List<Malayalam>? malayalam;

  Data({this.english, this.malayalam});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['english'] != null) {
      english = <English>[];
      json['english'].forEach((v) {
        english!.add(new English.fromJson(v));
      });
    }
    if (json['malayalam'] != null) {
      malayalam = <Malayalam>[];
      json['malayalam'].forEach((v) {
        malayalam!.add(new Malayalam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.english != null) {
      data['english'] = this.english!.map((v) => v.toJson()).toList();
    }
    if (this.malayalam != null) {
      data['malayalam'] = this.malayalam!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class English {
  String? termsAndCondition;

  English({this.termsAndCondition});

  English.fromJson(Map<String, dynamic> json) {
    termsAndCondition = json['terms_and_condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['terms_and_condition'] = this.termsAndCondition;
    return data;
  }
}

class Malayalam {
  String? termsAndCondition;

  Malayalam({this.termsAndCondition});

  Malayalam.fromJson(Map<String, dynamic> json) {
    termsAndCondition = json['terms_and_condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['terms_and_condition'] = this.termsAndCondition;
    return data;
  }
}
