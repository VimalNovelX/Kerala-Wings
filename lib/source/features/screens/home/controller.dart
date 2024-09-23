import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kerala_wings/data/api_services.dart';
import 'package:kerala_wings/data/models/driver_view_trip_model.dart';
import 'package:kerala_wings/source/features/screens/home/trip_details_screen.dart';
import 'package:kerala_wings/utils/constants.dart';
import 'package:kerala_wings/utils/toastUtil.dart';

class MainPageController extends GetxController{
  var data = [].obs; // Ensure to use the correct type for the list
  final TextEditingController textFieldController = TextEditingController();




  Future<void> endTrip(String? amount, String? bookingId,String? type) async {
    try {
      // Check if bookingId or amount is null
      if (amount == null || amount.isEmpty) {
        ToastUtil.show("Amount is required to end the ride.");
        return;
      }
      if (bookingId == null || bookingId.isEmpty) {
        ToastUtil.show("Booking ID is required to end the ride.");
        return;
      }


      print("Booking ID: $bookingId, Amount: $amount");


      await NetworkHelper().endTripApi(
        bookingId: bookingId,
        amount: amount,
        context: Get.context,
        tripStartBy: "Vinayan"
      );


      ToastUtil.show("Ride ended successfully!");
      textFieldController.clear();

      Future.delayed(Duration(milliseconds: 200), () {
        if (Get.isBottomSheetOpen!) {
          Get.back();
        }
      });


      await fetchTrips(type);
      Future.delayed(Duration(milliseconds: 200), () {
        if (Get.isBottomSheetOpen!) {
          Get.back();
        }
      });
    } catch (e) {

      ToastUtil.show("Failed to end the ride. Please try again.");
      debugPrint("Error------------------------$e");
    }
  }

  Future<void> startTrip(String? bookingId,String? name,String type) async {
    try {

      if (bookingId == null || bookingId.isEmpty) {
        ToastUtil.show("Booking ID is required to start the ride.");
        return;
      }


      await NetworkHelper().startDriverTripApi(
          context: Get.context,
        bookingId: bookingId,
        tripStartBy: name
      );


      ToastUtil.show("Ride started successfully!");

      Future.delayed(Duration(milliseconds: 200), () {
        if (Get.isBottomSheetOpen!) {
          Get.back();
        }
      });


      await fetchTrips(type);
      Future.delayed(Duration(milliseconds: 200), () {
        if (Get.isBottomSheetOpen!) {
          Get.back();
        }
      });
    } catch (e) {

      ToastUtil.show("Failed to end the ride. Please try again.");
      debugPrint("Error------------------------$e");
    }
  }


  RxBool isLoading = false.obs;
  final isRideStart = RxBool(GetStorage().read('isRideStart') ?? false);

  var trips = [].obs;

  Future<void> fetchTrips(type) async {
    try {
      isLoading(true);
      DriverViewTripDetailsModel? response = await NetworkHelper().driverViewTripDetailsApi(
        context: Get.context!,
        driver_id: driverId,
        type: type,
      );
      if (response != null && response.data != null) {
        trips.value = response.data!;
      } else {
        trips.clear(); // Clear the list if response or data is null
      }
    } catch (e) {
      print("Error fetching data: $e");
      trips.clear();
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchTrips("");
  }
}