import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kerala_wings/data/api_services.dart';

import '../../../../../data/models/driver_register.dart';

class SelectProfileController extends GetxController {
  RxString selectMethod = "Driver".obs;
  RxString selectSalary = "Daily".obs;
  late List<String> stringList;
  RxBool isLoading =false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController bloodGController = TextEditingController();
  TextEditingController licenceController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController homeMobController = TextEditingController();
  TextEditingController licenceDateController = TextEditingController();
  RxList<File> drivingLicenceImages = <File>[].obs;
  Rx<File?> frontFile = Rx<File?>(null);
  Rx<File?> backFile = Rx<File?>(null);
  Rx<File?> imageFile = Rx<File?>(null);
  final formKey = GlobalKey<FormState>();
  RxBool areFilled = false.obs;


  @override
  void onInit() {
    super.onInit();
    ever(areFilled, (_) {
    });
  }



  void selectProfileMethod(String selected) {
    selectMethod.value = selected;
  }
  void selectProfileSalary(String selected) {
    selectSalary.value = selected;
  }

  // void pickImages(RxList<File> imagesList) async {
  //   List<XFile>? images = await ImagePicker().pickMultiImage();
  //   if (images != null) {
  //     imagesList.addAll(images.map((image) => File(image.path)));
  //   }
  // }

  // void pickImages(RxList<File> imagesList) async {
  //   List<XFile>? images = await ImagePicker().pickMultiImage();
  //   if (images != null) {
  //     // Clear the list before adding new images
  //     imagesList.clear();
  //     // Add only the first two images
  //     for (int i = 0; i < images.length && i < 2; i++) {
  //       imagesList.add(File(images[i].path));
  //       drivingLicenceImages.add(File(images[i].path)
  //       );
  //       frontFile.value = (File(images[0].path));
  //       backFile.value = (File(images[1].path));
  //     }
  //    // drivingLicenceImages = imagesList.map((file) => file.path).toList();
  //   }
  // }

  void pickImages(RxList<File> imagesList) async {
    List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images != null) {
      // Clear the list before adding new images
      imagesList.clear();
      // Add only the first two images
      for (int i = 0; i < images.length && i < 2; i++) {
        imagesList.add(File(images[i].path));
      }
      // Update frontFile and backFile if there are at least two images
      if (images.length >= 2) {
        frontFile.value = File(images[0].path);
        backFile.value = File(images[1].path);
      }
    }
  }




  void removeImage(RxList<File> imagesList, int index) {
    imagesList.removeAt(index);
  }


  Future<void> pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
        debugPrint("imgPath=>${imageFile.value}");
      } else {
        debugPrint("User canceled image picker");
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  DateTime selectedDate = DateTime.now();
  DateTime selectedExpDate = DateTime.now();


  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Update text field
    }
  }


  Future<void> selectExpDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedExpDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedExpDate) {
      selectedExpDate = picked;
      licenceDateController.text = DateFormat('yyyy-MM-dd').format(selectedExpDate); // Update text field
    }
  }


 void registerDriver(context,qusDetails,phone) async {
   try {

     NetworkHelper().driverRegistrationApi(
         context: context,
         name: nameController.text,
         phone:phone ,
         driverType: "cd",
         address: addressController.text,
         licence: licenceController.text,
         dob: dobController.text,
         licenceExp: licenceDateController.text,
         sType: "Monthly",
         district: "kollam",
         adhaar: adharController.text,
         hPhone: homeMobController.text,
         location: "cdcndsncd",
         bGroup: bloodGController.text,
         father: fNameController.text,
         photoName: imageFile.value != null ? imageFile.value!.path.split("/").last : "",
         photos: imageFile.value != null ? imageFile.value!.path : "",
         licenceBackName: backFile.value != null ? backFile.value!.path.split("/").last : "",
         licenceBack: backFile.value != null ? backFile.value!.path : "",
         licenceFrontName: frontFile.value != null ? frontFile.value!.path.split("/").last : "",
         licenceFront: frontFile.value != null ? frontFile.value!.path : "",
         qus: qusDetails
     );
   } catch (e){
     print("Error-------$e");
   }
  }



Future<DriverRegisterModel?>? driverRegisterModel;

  //
  // Future<DriverRegisterModel?>? registerDriver({context,activeLocation,address,adhaarNo,backLicence,bloodGroup,districts,dob,driverType,fName,father,frontLicence,hPhone,
  // licenceExp,licenceNo,phone,profile,qus,salaryType}){
  //
  //   driverRegisterModel = NetworkHelper().driverRegisterApi(context: context,activeLocation:activeLocation ,address:address ,adhaarNo: adhaarNo,
  //     backLicence:backLicence ,bloodGroup:bloodGroup , districts:districts ,
  //   dob:dob ,driverType: driverType,f_name:fName ,father:father ,frontLicence: frontLicence,hPhone:hPhone ,licenceExp:licenceExp ,
  //     licenceNo:licenceNo ,phone: phone,profile: profile,qus: qus,salaryType:salaryType ,);
  //
  //   return driverRegisterModel;
  //
  // }

}
