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
  String? customerName;
  String? customerNumber;
  String? vehicle;
  String? vehNo;
  String? vehType;
  String? tripType;
  String? pickupLocation;
  String? destination;
  String? bookingType;
  int? driverIdAssign;

  Data(
      {this.bookingId,
        this.date,
        this.time,
        this.customerName,
        this.customerNumber,
        this.vehicle,
        this.vehNo,
        this.vehType,
        this.tripType,
        this.pickupLocation,
        this.destination,
        this.bookingType,
        this.driverIdAssign});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    date = json['date'];
    time = json['time'];
    customerName = json['customer_name'];
    customerNumber = json['customer_number'];
    vehicle = json['vehicle'];
    vehNo = json['veh_no'];
    vehType = json['veh_type'];
    tripType = json['trip_type'];
    pickupLocation = json['pickup_location'];
    destination = json['destination'];
    bookingType = json['booking_type'];
    driverIdAssign = json['driver_id_assign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['customer_name'] = this.customerName;
    data['customer_number'] = this.customerNumber;
    data['vehicle'] = this.vehicle;
    data['veh_no'] = this.vehNo;
    data['veh_type'] = this.vehType;
    data['trip_type'] = this.tripType;
    data['pickup_location'] = this.pickupLocation;
    data['destination'] = this.destination;
    data['booking_type'] = this.bookingType;
    data['driver_id_assign'] = this.driverIdAssign;
    return data;
  }
}
