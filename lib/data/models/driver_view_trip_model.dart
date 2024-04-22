class DriverViewTripDetailsModel {
  String? status;
  String? msg;
  List<Data>? data;

  DriverViewTripDetailsModel({this.status, this.msg, this.data});

  DriverViewTripDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? bookingId;
  String? date;
  String? time;
  String? endDate;
  String? customerName;
  String? customerNumber;
  String? address;
  Null? remark;
  String? vehicle;
  String? vehNo;
  String? vehType;
  String? bookingType;
  String? tripType;
  String? pickupLocation;
  String? destination;
  String? status;
  int? driverIdAssign;

  Data(
      {this.bookingId,
        this.date,
        this.time,
        this.endDate,
        this.customerName,
        this.customerNumber,
        this.address,
        this.remark,
        this.vehicle,
        this.vehNo,
        this.vehType,
        this.bookingType,
        this.tripType,
        this.pickupLocation,
        this.destination,
        this.status,
        this.driverIdAssign});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    date = json['date'];
    time = json['time'];
    endDate = json['end_date'];
    customerName = json['customer_name'];
    customerNumber = json['customer_number'];
    address = json['address'];
    remark = json['remark'];
    vehicle = json['vehicle'];
    vehNo = json['veh_no'];
    vehType = json['veh_type'];
    bookingType = json['booking_type'];
    tripType = json['trip_type'];
    pickupLocation = json['pickup_location'];
    destination = json['destination'];
    status = json['status'];
    driverIdAssign = json['driver_id_assign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['end_date'] = this.endDate;
    data['customer_name'] = this.customerName;
    data['customer_number'] = this.customerNumber;
    data['address'] = this.address;
    data['remark'] = this.remark;
    data['vehicle'] = this.vehicle;
    data['veh_no'] = this.vehNo;
    data['veh_type'] = this.vehType;
    data['booking_type'] = this.bookingType;
    data['trip_type'] = this.tripType;
    data['pickup_location'] = this.pickupLocation;
    data['destination'] = this.destination;
    data['status'] = this.status;
    data['driver_id_assign'] = this.driverIdAssign;
    return data;
  }
}
