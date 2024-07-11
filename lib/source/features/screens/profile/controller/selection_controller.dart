import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kerala_wings/data/api_services.dart';
import 'package:kerala_wings/data/models/driver_register.dart';


class SelectProfileController extends GetxController {

  final List<String> districts = ['Trivandrum', 'Kollam', 'Pathanamthitta', 'Alappuzha','Kottayam','Idukki','Eranakulam','Thissur','Palakkadu','Malappuram','Kozhikode','Kannur','Kasarragod'];
  final List<String> bloodGroup = ['A +ve','B +ve','AB +ve','O +ve','A -ve','B -ve','AB -ve','O -ve',];

  final selectedValue = ''.obs;
  String? selectedDistrict;
  String? selectBloodGroup;
  final RxInt selectedRadio = (-1).obs;
  RxBool isFinished = false.obs;


  void onChanged(String? value) {
    selectedDistrict = value;
  }

  void onChange(String? value) {
    selectBloodGroup = value;
  }




  RxString selectMethod = "cd".obs;
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


  void pickImages(RxList<File> imagesList) async {
    List<XFile>? images = await ImagePicker().pickMultiImage(
      // imageQuality: 2,



    );
    if (images != null) {
      imagesList.clear();
      for (int i = 0; i < images.length && i < 2; i++) {
        imagesList.add(File(images[i].path));
      }
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


 void registerDriver(context,
     {qusDetails, phone, district, bloodGrp, driverType, salaryType}) async {
   try {

     NetworkHelper().driverRegistrationApi(
         context: context,
         name: nameController.text,
         phone:phone ,
         driverType: driverType,
         address: addressController.text,
         licence: licenceController.text,
         dob: dobController.text,
         licenceExp: licenceDateController.text,
         sType: salaryType,
         district: district,
         adhaar: adharController.text,
         hPhone: homeMobController.text,
         location: locController.text,
         bGroup:bloodGrp,
         father: fNameController.text,
         photoName: imageFile.value != null ? imageFile.value!.path.split("/").last : "",
         photos: imageFile.value != null ? imageFile.value!.path : "",
         licenceBackName: backFile.value != null ? backFile.value!.path.split("/").last : "",
         licenceBack: backFile.value != null ? backFile.value!.path : "",
         licenceFrontName: frontFile.value != null ? frontFile.value!.path.split("/").last : "",
         licenceFront: frontFile.value != null ? frontFile.value!.path : "",
         qus: qusDetails
     );
     print("selected Blood-----------$selectBloodGroup");
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
