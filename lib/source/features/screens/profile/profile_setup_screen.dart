import 'dart:io';
import 'package:action_slider/action_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kerala_wings/source/common_widgets/back_button.dart';
import 'package:kerala_wings/source/common_widgets/custom_dropdown.dart';
import 'package:kerala_wings/source/common_widgets/textfield.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';
import 'package:kerala_wings/source/features/screens/question_section/question_answering_screeen.dart';
import 'package:kerala_wings/utils/snack_bar.dart';
import 'package:kerala_wings/utils/toastUtil.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'controller/selection_controller.dart';

class ProfileSetupScreen extends StatelessWidget {
  ProfileSetupScreen({Key? key}) : super(key: key);

  final SelectProfileController controller = Get.put(SelectProfileController());
  final List<String> districts = ['Trivandrum', 'Kollam', 'Kannur', 'Kochi'];
  final List<String> _bloodGroup = ['A +ve','B +ve','AB +ve','O +ve','A -ve','B -ve','AB -ve','O -ve',];

  final selectedValue = ''.obs;
  String? selectedDistrict;
  String? selectBloodGroup;
  final RxInt selectedRadio = (-1).obs;
  final _controller = ActionSliderController();
  RxBool isFinished = false.obs;

  final GlobalKey<SlideActionState> _key = GlobalKey();

  void onChanged(String? value) {
    selectedDistrict = value;
  }

  void onChange(String? value) {
    selectBloodGroup = value;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomBackButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => RichText(
                            text: TextSpan(
                                text: "Set up Your\n",
                                style: const TextStyle(
                                    color: cFont,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: "Profile",
                                      style: TextStyle(
                                          color:
                                              controller.selectMethod.value ==
                                                      "Driver"
                                                  ? cPrimaryColor
                                                  : cYellow))
                                ]),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        controller.pickImage();
                      },
                      child: Obx(() => controller.imageFile.value != null
                          ? CircleAvatar(
                        radius: 55,
                        backgroundImage: FileImage(
                          controller.imageFile.value??File(""),

                        ),
                      )
                          :  CircleAvatar(
                        radius: 55,
                        backgroundColor: cGrey,
                        // backgroundImage: NetworkImage(data!.data!.img??""),
                        child: Center(
                          child: SvgPicture.asset(iProfile),
                        ),
                      ),),
                    ),
                  ],
                ),
                buildSizedBox(),
                Text(
                  "Create Your profile to drive for Kerala Wings",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                ),
                buildSizedBox(),
                buildDottedLine(),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      selectionRow(
                          color: cPrimaryColor,
                          title: "Driver",
                          index: "Driver",
                          isSalary: false,
                          textClr: cPrimaryColor),
                      const SizedBox(
                        width: 25,
                      ),
                      selectionRow(
                          color: cYellow,
                          title: "Cab",
                          index: "Cab",
                          isSalary: false,
                          textClr: cYellow),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                buildDottedLine(),
                Expanded(
                  child: Form(
                    key: controller.formKey,
                    onChanged: () {
                      controller.areFilled.value =
                          controller.formKey.currentState?.validate() ?? false;
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          hitText: "Name",
                          obscureText: false,
                          readOnly: false,
                          isExpand: false,
                          controller: controller.nameController,
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return "please enter full name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        buildSizedBox(),
                        CustomTextField(
                          hitText: "Active Location",
                          obscureText: false,
                          readOnly: false,
                          isExpand: false,
                          controller: controller.locController,
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return "please enter your location";
                            } else {
                              return null;
                            }
                          },
                        ),
                        buildSizedBox(),
                        SizedBox(
                          height: 100,
                          child: CustomTextField(
                            hitText: "Address",
                            obscureText: false,
                            readOnly: false,
                            isExpand: true,
                            controller: controller.addressController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter full address";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        buildSizedBox(),
                        CustomTextField(
                          onTap: (){
                            controller.selectDate(context);
                          },
                            controller: controller.dobController,
                            hitText: "DD/MM/YYYY",
                            obscureText: false,
                            readOnly: true,
                            isExpand: false,
                            validator: (name) {
                              if (name == null || name.isEmpty) {
                                return "please select your date of birth";
                              } else {
                                return null;
                              }
                            },
                            suffix: Icon(
                              Icons.calendar_today,
                              color: Colors.grey.shade400,
                            ),
                            preffix: Obx(
                              () => Container(
                                margin: const EdgeInsets.only(
                                    top: 7, bottom: 7, right: 15),

                                width: 70,
                                decoration: BoxDecoration(
                                    color:
                                        controller.selectMethod.value == "Driver"
                                            ? cPrimaryColor.withOpacity(.2)
                                            : cYellow.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    "DOB",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: controller.selectMethod.value ==
                                                "Driver"
                                            ? cPrimaryColor
                                            : cYellow,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            )),
                        buildSizedBox(),
                        SizedBox(
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: width * .6,
                                child: CustomTextField(
                                  hitText: "Aadhaar Number",
                                  controller: controller.adharController,
                                  obscureText: false,
                                  readOnly: false,
                                  isExpand: false,
                                  keyboardType: TextInputType.number,
                                  validator: (name) {
                                    if (name == null || name.isEmpty) {
                                      return "please enter your adhaar";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: width * .26,
                                // child: CustomTextField(
                                //   hitText: "Eg Ab+",
                                //   obscureText: false,
                                //   readOnly: false,
                                //   isExpand: false,
                                //   validator: (name) {
                                //     if (name == null || name.isEmpty) {
                                //       return "please enter your Blood group";
                                //     } else {
                                //       return null;
                                //     }
                                //   },
                                // ),
                                child: Obx(
                                      () => CustomDropDown(
                                    textClr: controller.selectMethod.value == "Driver"
                                        ? cPrimaryColor
                                        : cYellow,
                                    hintText: "Eg:A+ve",
                                    onChanged: onChange,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select your location';
                                      } else {
                                        return null;
                                      }
                                    },
                                    value: selectBloodGroup,
                                    items: _bloodGroup.map((String gender) {
                                      return DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(gender),
                                      );
                                    }).toList(),
                                    color: controller.selectMethod.value == "Driver"
                                        ? cPrimaryColor.withOpacity(.3)
                                        : cYellow.withOpacity(.3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          hitText: "Active Location",
                          obscureText: false,
                          readOnly: false,
                          isExpand: false,
                          controller: controller.locController,
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return "please enter your location";
                            } else {
                              return null;
                            }
                          },
                        ),
                        buildSizedBox(),

                        CustomTextField(
                          controller: controller.homeMobController,
                          hitText: "Home Mobile Number",
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          readOnly: false,
                          isExpand: false,
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return "please enter mobile number";
                            } else {
                              return null;
                            }
                          },


                        ),
                        buildSizedBox(),


                        buildDottedLine(),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          height: 50,
                          width: width,
                          decoration: BoxDecoration(
                              color: cGrey.withOpacity(.5),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * .5,
                                child: TextFormField(
                                  controller: controller.licenceController,
                                  decoration: const InputDecoration(
                                    hintText: "Licence Number",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Obx(() {
                                final images =
                                    controller.drivingLicenceImages.value;
                                if (images.isNotEmpty) {
                                  return SizedBox(
                                    width: width * .35,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      itemCount:
                                          controller.drivingLicenceImages.length,
                                      itemBuilder: (context, index) {
                                        final image = controller
                                            .drivingLicenceImages[index];
                                        final imageName =
                                            image.path.split('/').last;
                                        return Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(right: 8),
                                              width: width * .15,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.red,
                                                image: DecorationImage(
                                                    image: FileImage(controller
                                                            .drivingLicenceImages[
                                                        index]),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            Positioned(
                                                top: -3,
                                                right: 0,
                                                child: InkWell(
                                                  onTap: (){
                                                    controller.removeImage(controller.drivingLicenceImages, index);
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor: controller
                                                                .selectMethod
                                                                .value ==
                                                            "Driver"
                                                        ? cPrimaryColor
                                                            .withOpacity(.8)
                                                        : cYellow.withOpacity(.8),
                                                    radius: 7,
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 10,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        );
                                      },
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        controller.pickImages(
                                            controller.drivingLicenceImages);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            controller.selectMethod.value ==
                                                    "Driver"
                                                ? cPrimaryColor.withOpacity(.3)
                                                : cYellow.withOpacity(.3),
                                        child: Center(
                                          child: SvgPicture.asset(iArrowUp),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              })
                            ],
                          ),
                        ),
                        buildSizedBox(),
                        CustomTextField(
                          onTap: (){
                            controller.selectExpDate(context);
                          },
                          controller: controller.licenceDateController,
                          hitText: "DD/MM/YYYY",
                          obscureText: false,
                          readOnly: true,
                          isExpand: false,
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return "licence expire date";
                            } else {
                              return null;
                            }
                          },
                          suffix: Icon(
                            Icons.calendar_today,
                            color: Colors.grey.shade400,
                          ),
                          preffix: Obx(() => Container(
                                margin: const EdgeInsets.only(
                                    top: 7, bottom: 7, right: 15),
                                width: 100,
                                decoration: BoxDecoration(
                                    color:
                                        controller.selectMethod.value == "Driver"
                                            ? cPrimaryColor.withOpacity(.2)
                                            : cYellow.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: buildRichText(
                                        "LICENCE", "EXP", 12, Colors.white)),
                              )),
                        ),
                        buildSizedBox(),
                        Obx(
                          () => CustomDropDown(
                            textClr: controller.selectMethod.value == "Driver"
                                ? cPrimaryColor
                                : cYellow,
                            hintText: "",
                            onChanged: onChanged,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your location';
                              } else {
                                return null;
                              }
                            },
                            value: selectedDistrict,
                            items: districts.map((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            color: controller.selectMethod.value == "Driver"
                                ? cPrimaryColor.withOpacity(.3)
                                : cYellow.withOpacity(.3),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => controller.selectMethod.value == "Driver"
                              ? Center(
                                  child: buildRichText("Salary", " Type", 25,
                                      Colors.grey.shade400))
                              : const SizedBox(),
                        ),
                        Obx(() => controller.selectMethod.value == "Driver"
                            ? buildSizedBox()
                            : const SizedBox()),
                        Obx(() => controller.selectMethod.value == "Driver"
                            ? buildDottedLine()
                            : const SizedBox()),
                        Obx(() => controller.selectMethod.value == "Driver"
                            ? buildSizedBox()
                            : const SizedBox()),
                        Obx(() => controller.selectMethod.value == "Driver"
                            ? Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  selectionRow(
                                      color: cPrimaryColor,
                                      title: "Daily",
                                      index: "Daily",
                                      isSalary: true,
                                      textClr: cPrimaryColor),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  selectionRow(
                                    color: cPrimaryColor,
                                    title: "Monthly",
                                    index: "Monthly",
                                    isSalary: true,
                                    textClr: cPrimaryColor,
                                  ),
                                ],
                              )
                            : const SizedBox()),
                        buildSizedBox(),
                        buildDottedLine(),
                        buildSizedBox(),
                        Row(
                          children: [
                            Obx(
                              () => Transform.scale(
                                scale: 1.4,
                                child: Radio(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  fillColor: MaterialStateProperty.all(
                                      controller.selectMethod.value == "Driver"
                                          ? cPrimaryColor
                                          : cYellow),
                                  value: 0,
                                  groupValue: selectedRadio.value,
                                  onChanged: (val) {
                                    selectedRadio.value = val!;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Text(
                                    "Terms and Condition",
                                    style: TextStyle(
                                        color: controller.selectMethod.value ==
                                                "Driver"
                                            ? cPrimaryColor
                                            : cYellow,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Text(
                                  "click to view",
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 10,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.grey,
                                      color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10.0,right: 15,left: 15),
          child: Obx(
            () =>  SizedBox(height: 55,
              child: SlideAction(
                borderRadius: 50,
                text: "Next",
                sliderButtonIconPadding: 12,
                sliderButtonIcon: SvgPicture.asset(iLoading),
                height: 55,
                outerColor: controller.selectMethod.value == "Driver" ? cPrimaryColor : cYellow,
                textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  fontWeight: FontWeight.w500
                ),
                key: _key,
                onSubmit: controller.areFilled.value ? () {

                  Get.to(QuestionAnsweringScreen());


               //    print( "nameController=>${controller.nameController.text}\n"
               //        "homeMobController=>${controller.homeMobController.text}\n"
               //        "licenceController=>${controller.licenceController.text}\n"
               //        "licenceDateController=>${controller.licenceDateController.text}\n"
               //       "fNameController=>${controller.fNameController.text}\n"
               //        "dobController=>${controller.dobController.text}\n"
               //        "adharController=>${controller.adharController.text}\n"
               //       "addressController=>${ controller.addressController.text}\n"
               //        "locController=>${controller.locController.text}\n"
               //        "selectBloodGroup=>$selectBloodGroup\n selectedDistrict=>$selectedDistrict");
               //
               //
               //
               //
               //
               //
               //  if(
               //  controller.nameController.text.isNotEmpty&&
               //  controller.homeMobController.text.isNotEmpty&&controller.licenceController.text.isNotEmpty&&
               //      controller.licenceDateController.text.isNotEmpty&&
               //      controller.dobController.text.isNotEmpty&&controller.adharController.text.isNotEmpty&&
               //      controller.addressController.text.isNotEmpty&&controller.locController.text.isNotEmpty&&
               //
               //      selectBloodGroup!=null && selectedDistrict!=null
               //
               //
               //
               //  )  {
               // return   Future.delayed(
               //        const Duration(seconds: 1),
               //            () {
               //          Get.to( QuestionAnsweringScreen());
               //        }
               //    );
               //  }else{
               //    selectBloodGroup==null ? ToastUtil.show("Please select Blood Group"):
               //  selectedDistrict==null?ToastUtil.show("Please select district"):ToastUtil.show("Please fill all required fields")
               //    ;
               //
               //     return null;
               //  }

                } : (){
                  GetXSnackBar.show("Note", "Complete your details", true);
                },
                reversed: true,
              )
            ),
          ),
        )
    );
  }

  RichText buildRichText(String text1, String text2, double size, color) {
    return RichText(
      text: TextSpan(
          text: text1,
          style: TextStyle(
              color: controller.selectMethod.value == "Driver"
                  ? cPrimaryColor
                  : cYellow,
              fontWeight: FontWeight.w600,
              fontSize: size),
          children: [
            TextSpan(
              text: text2,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w600, fontSize: size),
            )
          ]),
    );
  }

  SizedBox buildSizedBox() => const SizedBox(
        height: 10,
      );

  DottedLine buildDottedLine() {
    return DottedLine(dashColor: Colors.grey.shade400);
  }

  InkWell selectionRow({index, title, color, textClr, isSalary}) {
    return InkWell(
      onTap: () {
        isSalary
            ? controller.selectSalary(index)
            : controller.selectMethod(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey.shade300,
              child: isSalary
                  ? CircleAvatar(
                      radius: 8,
                      backgroundColor: controller.selectSalary.value == index
                          ? color
                          : Colors.transparent,
                    )
                  : CircleAvatar(
                      radius: 8,
                      backgroundColor: controller.selectMethod.value == index
                          ? color
                          : Colors.transparent,
                    ),
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16, color: textClr, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
