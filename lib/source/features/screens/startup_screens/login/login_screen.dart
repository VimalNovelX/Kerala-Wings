import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kerala_wings/data/api_services.dart';
import 'package:kerala_wings/data/models/otp_model.dart';
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




