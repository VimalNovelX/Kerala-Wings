import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:kerala_wings/source/features/screens/profile/profile_setup_screen.dart';
import 'package:kerala_wings/source/features/screens/startup_screens/login/login_screen.dart';
import 'package:kerala_wings/source/features/screens/startup_screens/splash/splash_screen.dart';
import 'package:kerala_wings/source/features/screens/verification/verification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const InAppNotification(
      child: GetMaterialApp(
        title: 'Kerala Wings',
        debugShowCheckedModeBanner: false,
        home: LoginScreen()
        // VerificationScreen()
      ),
    );
  }
}
