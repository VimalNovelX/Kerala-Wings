import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SafeArea(child: Column(

        mainAxisAlignment: MainAxisAlignment.center,


        children: [


        Lottie.asset("assets/json/processing.json",height: 250),
        SizedBox(height:15),

        Center(child: Text("Registration under process get back in sometime!!!")),

      ],),),

    );
  }
}
