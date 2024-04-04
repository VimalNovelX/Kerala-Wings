import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kerala_wings/source/common_widgets/back_button.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';
import 'package:kerala_wings/source/features/screens/home/home_screen.dart';
import 'package:slide_to_act/slide_to_act.dart';

class QuestionAnsweringScreen extends StatefulWidget {
  QuestionAnsweringScreen({Key? key}) : super(key: key);

  @override
  State<QuestionAnsweringScreen> createState() =>
      _QuestionAnsweringScreenState();
}

class _QuestionAnsweringScreenState extends State<QuestionAnsweringScreen> {
  List<String> questions = [
    "automatic car?",
    "premium car?",
    "Heavy Vehicle?",
  ];

  late List<String?> answers;
  final GlobalKey<SlideActionState> _key = GlobalKey();


  @override
  void initState() {
    super.initState();
    answers = List.filled(questions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomBackButton(),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin:
            const EdgeInsets.only(top: 15, bottom: 15, right: 15),
            decoration: BoxDecoration(
                color: cPrimaryColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: buildRichText(
                    "DRIVER ", "QUESTIONS", 12, Colors.white,
                  cPrimaryColor
                )),
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),

                buildRichText(
                    "Do you drive\n",
                    questions[index],
                    16,
                    cPrimaryColor,
                  Color(0xFF6B5D5D),
                ),
                SizedBox(height: 15,),

                Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: (){
                              setState(() {
                                answers[index] = 'Yes';
                              });
                        },
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey.shade400,
                                ),
                                answers[index] == 'Yes'?     Positioned(
                                  right: -3,
                                    top: -2,
                                    child:
                                Image.asset(iTick)
                                ) : SizedBox()
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Yes",
                              style: TextStyle(
                                fontSize: 16,
                                  color: answers[index] == 'Yes'
                                      ? cPrimaryColor : Colors.grey,
                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 20,),
                      InkWell(
                        onTap: (){
                              setState(() {
                                answers[index] = 'No';
                              });
                        },
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey.shade400,
                                ),
                                answers[index] == 'No'?     Positioned(
                                    right: -3,
                                    top: -2,
                                    child:
                                    Image.asset(iTick)
                                ) : SizedBox()
                              ],
                            ),

                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "No",
                              style: TextStyle(
                                fontSize: 16,
                                      color: answers[index] == 'No'
                                          ? cPrimaryColor : Colors.grey,

                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 15,),
                DottedLine(
                  dashColor: Colors.grey.shade400,
                )
              ],
            );
          },
        ),
      ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10.0,right: 15,left: 15),
          child:  SizedBox(height: 55,
                child: SlideAction(
                  borderRadius: 50,
                  text: "Request Activation",
                  sliderButtonIconPadding: 12,
                  sliderButtonIcon: SvgPicture.asset(iLoading),
                  height: 55,
                  outerColor:  cPrimaryColor,
                  textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                  ),
                  key: _key,
                  onSubmit: () {
                    Future.delayed(
                        const Duration(seconds: 1),
                            () {
                          Get.to( HomeScreen());
                        }
                    );
                    return null;
                  },
                  reversed: true,
                )
            ),
          ),


    );
  }

  RichText buildRichText(String text1, String text2, double size, color,color1) {
    return RichText(
      text: TextSpan(
          text: text1,
          style: TextStyle(
              color: color1,
              fontWeight: FontWeight.w600,
              fontSize: size),
          children: [
            TextSpan(
              text: text2,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: size),
            )
          ]),
    );
  }
}
