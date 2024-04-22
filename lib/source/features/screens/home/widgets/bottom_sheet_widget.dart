import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kerala_wings/data/api_services.dart';
import 'package:kerala_wings/data/models/end_trip_model.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';
import 'package:kerala_wings/utils/toastUtil.dart';

import '../../../../../data/models/start_trip_model.dart';
import '../../../../../utils/constants.dart';
import '../home_screen.dart';

class BottomSheetWidget extends StatefulWidget {
  final customerNumber;
  final customerName;
  final bookingId;
  final vehNo;
  final vehType;
  final vehicle;
  final time;
  final driverIdAssign;
  final date;
  final bookingType;
  final pickupLocation;
  final destination;
  final driverStatus;


   BottomSheetWidget({Key? key, this.customerNumber, this.vehNo, this.vehType, this.vehicle, this.time, this.driverIdAssign, this.date, this.bookingType, this.pickupLocation, this.destination, this.customerName, this.bookingId, this.driverStatus}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}



class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final isRideStart = RxBool(GetStorage().read('isRideStart') ?? false);
  bool startRide = false;
  TextEditingController _textFieldController = TextEditingController();
  Future<StartTripModel?>? startTripModel;
  Future<EndTripModel?>? endTripModel;

  Future<StartTripModel?>? startTrip() async {
    startTripModel =
        NetworkHelper().startDriverTripApi(context: context, bookingId: widget.bookingId, tripStartBy: "");

    // Wait for the result of startDriverTripApi
    await startTripModel;

    // After the trip starts, set isRideStart.value to true
    isRideStart.value = true;
    GetStorage().write('isRideStart', true); // Store the value

    print("val==>${isRideStart.value}");

    Navigator.pop(context);

    return startTripModel;
  }

  Future<void> endTrip(amount) async {
    // Call the endTripApi function with the provided reason
    endTripModel = NetworkHelper().endTripApi(
      context: context,
      bookingId:  widget.bookingId,
      tripStartBy: "revi",
      amount: amount
    );


    isRideStart.value = false;
    GetStorage().write('isRideStart', false);
    //Navigator.of(context).pop();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomeScreen(
      driverId:  driverId,
    )), (route) => false);

  }


  @override
  Widget build(BuildContext context) {
    widget.driverStatus =="Live"?isRideStart.value =true:isRideStart.value =false;
    print( isRideStart.value);
    print( widget.bookingType);
    var width = MediaQuery.of(context).size.width;
    return Obx(() => isRideStart.value ==true
        ? Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8,),
          const Text(
            "Are You Sure",
            style: TextStyle(
              color: cFont,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "you want to end the trip",
            style: TextStyle(
              color: cRed.withOpacity(.5),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 45,
                  width: width * .38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: cRed.withOpacity(.5),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: cRed,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Enter The Charge"),
                          content: TextField(
                            controller: _textFieldController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Rs.",
                            ),
                          ),
                          actions: [
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  _textFieldController.text.isNotEmpty
                                      ? endTrip(_textFieldController.text)
                                      : ToastUtil.show("Enter amount to end the ride!!");
                                },
                                child: Text(
                                  "End Ride",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: cRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: cRed,
                    ),
                    child: const Center(
                      child: Text(
                        "End Ride",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

              ),
            ],
          ),
        ],
      ),
    )
        : Container(
      decoration: const BoxDecoration(
        color: cPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            minVerticalPadding: 0,
            title: Text(
              widget.pickupLocation.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              "${widget.pickupLocation.toString()} to ${widget.destination.toString()}",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 10,
              ),
            ),
            trailing: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                iCar,
                color: cPrimaryColor,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            width: width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.customerName.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: cDarkBlue,
                      ),
                    ),
                    Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: cPrimaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            widget.vehicle!.toString(),
                            style: TextStyle(
                                color:
                                widget.vehType.toString()=="Manual"?
                                Colors.blue: widget.vehType.toString()=="Automatic"?
                                Colors.red:Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 12
                            ),
                          ),
                          const SizedBox(width: 5,),
                          VerticalDivider(
                            indent: 2,
                            endIndent: 2,
                            thickness: 1,
                            color: Colors.grey.shade500,
                            width: 2,
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            widget.vehNo.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: cPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            widget.date.toString(),
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 5,),
                          VerticalDivider(
                            indent: 2,
                            endIndent: 2,
                            thickness: 1,
                            color: Colors.grey.shade500,
                            width: 2,
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            widget.time.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DottedLine(
                    dashColor: Colors.grey.withOpacity(.5),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 45,
                        width: width * .38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: cRed.withOpacity(.5),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: cRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          startTrip();
                        },
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: cPrimaryColor,
                          ),
                          child: const Center(
                            child: Text(
                              "Start Ride",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
