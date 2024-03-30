import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kerala_wings/source/features/screens/startup_screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kerala Wings',
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}
