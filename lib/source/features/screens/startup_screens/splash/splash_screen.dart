import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,

            decoration: const BoxDecoration(
                gradient:LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.3,
                    // 0.4,
                    0.7,
                    0.6,
                    0.8,

                  ],
                  //tileMode: TileMode.repeated,
                  colors: [
                    Color(0xFF1282B9), // Lighter blue
                    // Lighter blue
                    ///Color(0xFF59B4E0), // Intermediate blue
                    Color(0xFF070F13), // Intermediate blue
                    Color(0xFF070F13),
                    Colors.black,


                  ],
                )



            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Center(child: Image.asset('assets/png/splash.png')),
                Center(child: Image.asset('assets/png/logow.png')),
                Image.asset('assets/png/logo.png'),
                SizedBox(height: 30,),
                Center(
                  child: SizedBox(
                    height: size.height*0.05,
                    width: size.width*0.5,
                    child: ElevatedButton(onPressed: (){},
                        child: RichText(text: TextSpan(text: "Get ",style: TextStyle(color: Colors.black),
                            children: [TextSpan(text:"Started Now" ,style: TextStyle(color: Color(0xFF5E1A14)))]),)),
                  ),
                ),
                SizedBox(height: 30,),

              ],
            ),
          )
      ),
    );
  }
}
