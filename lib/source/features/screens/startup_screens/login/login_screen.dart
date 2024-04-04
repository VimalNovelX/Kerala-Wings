import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kerala_wings/source/common_widgets/textfield.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';
import 'package:kerala_wings/source/features/screens/profile/profile_setup_screen.dart';
import 'package:kerala_wings/utils/toastUtil.dart';

import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [cPrimaryColor, Colors.black],
          ),
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: height*.03,),


            SizedBox(
                height: height*.3,
                width: width*.9,
                child: Image.asset("assets/images/image 12.png")),
            SizedBox(height: 10,),
            SizedBox(
              height: height*.08,
                width: width*.9,

                child: Image.asset(
                    "assets/images/image 15.png",
                )),
            SizedBox(
              height: height*.07,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: width*.8,
                  height: height*.38,
                  child: Align(
                    alignment: Alignment.centerRight,
                      child: Image.asset("assets/images/image 23.png"))),
            ),
            InkWell(
              onTap: (){
                Get.bottomSheet(
                  OtpBottomSheet(phoneNumberController: _phoneNumberController)
                );
              },
              child: Container(
                height: height*.08,
                width: width*.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35)
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                       text: "Get ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
                      children: [
                        TextSpan(
                          text: "Started Now",
                          style: TextStyle(
                            color: cDarkRed,
                              fontWeight: FontWeight.w500

                          )
                        )
                      ]
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}

class OtpBottomSheet extends StatefulWidget {
  const OtpBottomSheet({
    super.key,
    required TextEditingController phoneNumberController,
  }) : _phoneNumberController = phoneNumberController;

  final TextEditingController _phoneNumberController;

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  bool _otpActive =false;
  @override
  Widget build(BuildContext context, ) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _otpActive?Text(
            "Otp",
            style: TextStyle(
                color: cFont,
                fontWeight: FontWeight.w600,
                fontSize: 16
            ),
          ):  Text(
            "Phone Number",
            style: TextStyle(
              color: cFont,
              fontWeight: FontWeight.w600,
              fontSize: 16
            ),
          ),
          SizedBox(height: 10,),
          _otpActive?
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child:  Wrap(
                alignment: WrapAlignment.center,
                spacing: 4,
                direction: Axis.horizontal,
                runSpacing: 10,
                children: [
                  _otpTextField(context, true),
                  _otpTextField(context, false),
                  _otpTextField(context, false),
                  _otpTextField(context, false),

                ],
              ),
            ),
          ):

          CustomTextField(
            keyboardType: TextInputType.number,
            controller: widget._phoneNumberController,
            validator: (value) {

              if (value == null || value.isEmpty) {
                return "Enter your phone number";
              } else if (value.length != 10) {
                return "Enter valid number";
              }
              {
                return null;
              }
            },
            suffix: SizedBox(
              height: 50,
              width: 40,
              child: Center(
                child: Text(
                  "+91",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
           hitText: '0000000000', obscureText: false,
            isExpand: false,
            readOnly: false,
          ),
          SizedBox(height: 10,),

       _otpActive?
       ActionSlider.standard(
         toggleColor: Colors.white,
         backgroundColor:  cPrimaryColor,

         action: (controller) async {
           controller.loading();
           await Future.delayed(const Duration(seconds: 3));
           widget._phoneNumberController.text.isNotEmpty? controller.success():controller.reset();


           widget._phoneNumberController.text.isNotEmpty?  Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>ProfileSetupScreen())):
           ToastUtil.show("Please enter phone number!!!");
         },
         icon: SvgPicture.asset(iLoading),
         direction: TextDirection.rtl,
         child: const Text(
           'Confirm OTP',

           style: TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.w500,
               fontSize: 15),
           textAlign: TextAlign.start,
         ),
       ):


       ActionSlider.standard(
            toggleColor: Colors.white,
            backgroundColor:  cPrimaryColor,

            action: (controller) async {
              controller.loading();
              await Future.delayed(const Duration(seconds: 3));
              widget._phoneNumberController.text.isNotEmpty? controller.success():controller.reset();


              //widget._phoneNumberController.text.isNotEmpty?  Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>OtpScreen())):

              //widget._phoneNumberController.text.isNotEmpty?
              setState(() {
                widget._phoneNumberController.text.isNotEmpty? _otpActive =true : ToastUtil.show("Please enter phone number!!!");

                controller.reset();
              });



            },
            icon: SvgPicture.asset(iLoading),
            direction: TextDirection.rtl,
            child: const Text(
              'Confirm',

              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
              textAlign: TextAlign.start,
            ),
          )


        ],
      ),
      // height: 100,
    );
  }
}





Widget _otpTextField(BuildContext context, bool autoFocus) {
  return  Container(
    height: MediaQuery.of(context).size.shortestSide * 0.13,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      shape: BoxShape.rectangle,
    ),
    child: AspectRatio(
      aspectRatio: 1,
      child: TextField(
        autofocus: autoFocus,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(),
        maxLines: 1,
        onChanged: (value) {
          if(value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    ),
  );
}