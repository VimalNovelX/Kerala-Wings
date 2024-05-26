import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kerala_wings/data/firebase_api.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../utils/constants.dart';
import '../../home/home_screen.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  NotificationServices notificationServices = NotificationServices();


  TextEditingController _phoneNumberController = TextEditingController();

  fetchData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    driverId =prefs.getString('driverId');
    driverName =prefs.getString('driverName');
    driverCode =prefs.getString('driverCode');
    driverType =prefs.getString('driverType');
    driverStatus =prefs.getString('driverStatus');
    driverProfile =prefs.getString('driverProfile');
    driverGrade =prefs.getString('driverGrade');
    driverRating =prefs.getString('driverRating');


    print("userId==>$driverId");
    print("userId==>$driverName");
    print("userId==>$driverCode");
    print("userId==>$driverStatus");
    print("userId==>$driverType");
    print("userId==>$driverProfile");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    notificationServices.requestNotificationPermissions();
    notificationServices.foregroundMessage();
    notificationServices.isRefreshToken();
    notificationServices.firebaseInit(context);
    notificationServices.getDeviceToken().then((value){
      print(value);
    });
  }

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
                driverId!=null?
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomeScreen(
                  driverId:  driverId,
                )), (route) => false):

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




