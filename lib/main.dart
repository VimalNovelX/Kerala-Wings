import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:kerala_wings/provider/current_index_provider.dart';
import 'package:kerala_wings/source/features/screens/home/home_screen.dart';
import 'package:kerala_wings/source/features/screens/profile/profile_setup_screen.dart';
import 'package:kerala_wings/source/features/screens/question_section/question_answering_screeen.dart';
import 'package:kerala_wings/source/features/screens/startup_screens/login/login_screen.dart';
import 'package:kerala_wings/source/features/screens/startup_screens/splash/splash_screen.dart';
import 'package:kerala_wings/source/features/screens/verification/verification_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  InAppNotification(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) =>CurrentIndexProvider() ),
        ],
        child: GetMaterialApp(
          title: 'Kerala Wings',
          debugShowCheckedModeBanner: false,
          home:
          //QuestionAnsweringScreen()
             LoginScreen()
          // VerificationScreen()
        ),
      ),
    );
  }
}
