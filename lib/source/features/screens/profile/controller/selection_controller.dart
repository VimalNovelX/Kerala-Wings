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
  RxBool isLoading =false.obs;
  TextEditingController nameController = TextEditingController();
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

  void pickImages(RxList<File> imagesList) async {
    List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images != null) {
      // Clear the list before adding new images
      imagesList.clear();
      // Add only the first two images
      for (int i = 0; i < images.length && i < 2; i++) {
        imagesList.add(File(images[i].path));
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
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      licenceDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate); // Update text field
    }
  }

Future<DriverRegisterModel?>? driverRegisterModel;


  Future<DriverRegisterModel?>? registerDriver({context,activeLocation,address,adhaarNo,backLicence,bloodGroup,districts,dob,driverType,fName,father,frontLicence,hPhone,
  licenceExp,licenceNo,phone,profile,qus,salaryType}){

    driverRegisterModel = NetworkHelper().driverRegisterApi(context: context,activeLocation:activeLocation ,address:address ,adhaarNo: adhaarNo,
      backLicence:backLicence ,bloodGroup:bloodGroup , districts:districts ,
    dob:dob ,driverType: driverType,f_name:fName ,father:father ,frontLicence: frontLicence,hPhone:hPhone ,licenceExp:licenceExp ,
      licenceNo:licenceNo ,phone: phone,profile: profile,qus: qus,salaryType:salaryType ,);

    return driverRegisterModel;

  }

}
