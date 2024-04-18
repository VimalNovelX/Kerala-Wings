import 'dart:ui';
import 'dart:math' as math;
import 'package:action_slider/action_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:kerala_wings/source/features/screens/home/home_screen.dart';

import '../../../../../data/api_services.dart';
import '../../../../../data/models/otp_model.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/toastUtil.dart';
import '../../../../common_widgets/textfield.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/images.dart';
import '../../profile/profile_setup_screen.dart';

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
  var id;
  Future<OtpModel?>? otpModel;
  TextEditingController _otpController1 =TextEditingController();
  TextEditingController _otpController2 =TextEditingController();
  TextEditingController _otpController3 =TextEditingController();
  TextEditingController _otpController4 =TextEditingController();


  sendOtp(){

    otpModel = NetworkHelper().getOtp(context: context,phone:widget._phoneNumberController.text );
    return otpModel;

  }
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
         FutureBuilder(

            future: otpModel,
            builder: (context, AsyncSnapshot<OtpModel?>snapshot) {
              if(snapshot.hasData){
                var otp = snapshot.data!.data!.otp;
       id = snapshot.data!.data!.driver!.id;
                if (otp != null) {
                  InAppNotification.show(child: NotificationBody(count: otp,), context: context);
                  // Split the OTP into individual characters
                  List<String> otpDigits = otp.toString().split('');
                  _otpController1.text = otpDigits.length > 0 ? otpDigits[0] : '';
                  _otpController2.text = otpDigits.length > 1 ? otpDigits[1] : '';
                  _otpController3.text = otpDigits.length > 2 ? otpDigits[2] : '';
                  _otpController4.text = otpDigits.length > 3 ? otpDigits[3] : '';
                }




              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child:  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4,
                    direction: Axis.horizontal,
                    runSpacing: 10,
                    children: [
                      _otpTextField(context: context,autoFocus: true,controller: _otpController1),
                      _otpTextField(context: context,autoFocus: true,controller: _otpController2),
                      _otpTextField(context: context,autoFocus: true,controller: _otpController3),
                      _otpTextField(context: context,autoFocus: true,controller: _otpController4),


                    ],
                  ),
                ),
              );}
              else if( snapshot.connectionState ==ConnectionState.waiting){
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child:  Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 4,
                      direction: Axis.horizontal,
                      runSpacing: 10,
                      children: [
                        _otpTextField(context: context,autoFocus: true,controller: _otpController1),
                        _otpTextField(context: context,autoFocus: true,controller: _otpController2),
                        _otpTextField(context: context,autoFocus: true,controller: _otpController3),
                        _otpTextField(context: context,autoFocus: true,controller: _otpController4),

                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child:  Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 4,
                      direction: Axis.horizontal,
                      runSpacing: 10,
                      children: [
                        _otpTextField(context: context,autoFocus: true,controller: _otpController1),
                        _otpTextField(context: context,autoFocus: true,controller: _otpController2),
                        _otpTextField(context: context,autoFocus: true,controller: _otpController3),
                        _otpTextField(context: context,autoFocus: true,controller: _otpController4),

                      ],
                    ),
                  ),
                );
              }
            }
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

Future.delayed(Duration(seconds: 3));
print("drivercode=>$drivercode");


              drivercode!=null &&  widget._phoneNumberController.text.isNotEmpty &&widget._phoneNumberController.text.length==10?

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomeScreen(otpModel:otpModel,
              driverId:  id,
              )), (route) => false):
              widget._phoneNumberController.text.isNotEmpty && widget._phoneNumberController.text.length==10?
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>ProfileSetupScreen(phone:widget._phoneNumberController.text))):
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
              widget._phoneNumberController.text.isNotEmpty&&widget._phoneNumberController.text.length==10? controller.success():controller.reset();


              //widget._phoneNumberController.text.isNotEmpty?  Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>OtpScreen())):

              //widget._phoneNumberController.text.isNotEmpty?
              setState(() {
                widget._phoneNumberController.text.isNotEmpty&&widget._phoneNumberController.text.length==10? _otpActive =true : ToastUtil.show("Please enter phone number!!!");
                sendOtp();
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


Widget _otpTextField({required BuildContext context, required bool autoFocus,controller}) {
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
        autofocus: autoFocus,readOnly: true,
        controller: controller,
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

class NotificationBody extends StatelessWidget {
  final int count;
  final double minHeight;

  NotificationBody({
    Key? key,
    this.count = 0,
    this.minHeight = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minHeight = math.min(
      this.minHeight,
      MediaQuery.of(context).size.height,
    );
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 12,
                blurRadius: 16,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.cyanAccent.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    width: 1.4,
                    color: Colors.lightGreen.withOpacity(0.2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Your Otp for Kerala Wings is $count',
                      style: TextStyle(color: Colors.white,fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}