import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kerala_wings/source/common_widgets/textfield.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                  Container(
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
                        Text(
                          "Phone Number",
                          style: TextStyle(
                            color: cFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 16
                          ),
                        ),
                        SizedBox(height: 10,),
                        CustomTextField(
                          keyboardType: TextInputType.number,
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

                        ActionSlider.standard(
                          toggleColor: Colors.white,
                          backgroundColor:  cPrimaryColor,

                          action: (controller) async {
                            controller.loading();
                            await Future.delayed(const Duration(seconds: 3));
                            controller.success();
                            await Future.delayed(const Duration(seconds: 1));
                            controller.reset();
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
                  )
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
