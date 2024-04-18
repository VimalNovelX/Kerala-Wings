import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kerala_wings/data/api_services.dart';
import 'package:kerala_wings/source/common_widgets/back_button.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';
import 'package:kerala_wings/source/features/screens/home/home_screen.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../data/models/questions_model.dart';
import '../../../../utils/snack_bar.dart';
import '../profile/controller/selection_controller.dart';

class QuestionAnsweringScreen extends StatefulWidget {
  final String? phone;
  QuestionAnsweringScreen({Key? key, this.phone}) : super(key: key);

  @override
  State<QuestionAnsweringScreen> createState() =>
      _QuestionAnsweringScreenState();
}

class _QuestionAnsweringScreenState extends State<QuestionAnsweringScreen> {

  final SelectProfileController controller = Get.put(SelectProfileController());

  List<String?>? answers =[];

  final GlobalKey<SlideActionState> _key = GlobalKey();
  Future<QuestionsModel?>? questionModel;
  Map<int, String> transformedResponses = {};


  @override
  void initState() {
    super.initState();

    questionModel = NetworkHelper().getQuestions(context: context);

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: questionModel,
        builder: (context,AsyncSnapshot<QuestionsModel?> snapshot){
          if(snapshot.hasData){
                        // Assuming the question numbers start from 2 and go up to 9
                        for (int i = 0; i < snapshot.data!.data!.length; i++) {
                          int questionNumber = i + 1;
                          transformedResponses[questionNumber] = answers!.length > i ? answers![i] ?? "" : "";
                          // transformedResponses[questionNumber] = answers![i].toString();
                        }


                        // answers = List.filled(snapshot.data!.data!.length, null);
            return Scaffold(
                appBar: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomBackButton(
                      onTap: (){
                        Get.back();
                      },
                    ),
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
                child:
                             ListView.builder(
                              padding: EdgeInsets.all(15),
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (answers!.length <= index) {
                                  // If not, add null values to the answers list until it has enough elements
                                  while (answers!.length <= index) {
                                    answers!.add(null);
                                  }
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 15,),

                                    buildRichText(
                                      snapshot.data!.data![index].qus.toString(),
                                      "",
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
                                              answers![index] = 'Yes';
                                            });
                                            print(answers);                           },
                                          child: Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor: Colors.grey.shade400,
                                                  ),
                                                  answers![index] == 'Yes'?     Positioned(
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
                                                    color: answers![index] == 'Yes'
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
                                              answers![index] = 'No';
                                            });
                                            print(answers);
                                          },
                                          child: Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor: Colors.grey.shade400,
                                                  ),
                                                  answers![index] == 'No'?     Positioned(
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
                                                    color: answers![index] == 'No'
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

                          if (answers!.contains(null)) {
                             GetXSnackBar.show("Note", "Please answer all questions", true);
                          } else {
                             controller.registerDriver(context, transformedResponses, widget.phone);
                          }

                          // print("--------------$transformedResponses");
                          //
                          //
                          // controller.registerDriver(context, transformedResponses,widget.phone);





                          // controller.registerDriver(phone: controller.homeMobController.text,
                          //     profile: "",
                          // salaryType: "",
                          //   qus: "",
                          //   licenceNo: controller.licenceController.text,
                          //   licenceExp: controller.licenceDateController.text,
                          //   hPhone: controller.homeMobController.text,
                          //   frontLicence: ""/*controller.drivingLicenceImages[0]*/,
                          //   father: controller.fNameController.text,
                          //   driverType: "",
                          //   dob: controller.dobController.text,
                          //   //districts: selectedDistrict,
                          //   districts: transformedResponses,
                          //   //bloodGroup: selectBloodGroup,
                          //   backLicence: /*controller.drivingLicenceImages[1]*/"",
                          //   adhaarNo: controller.adharController.text,
                          //   address: controller.addressController.text,
                          //   activeLocation: controller.locController.text,
                          //   context: context,
                          //
                          //   fName: controller.fNameController.text,
                          // );

                        },
                        reversed: true,
                      )
                  ),
                ),


            );
          } else if(snapshot.connectionState == ConnectionState.waiting){
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else {
            return Scaffold(
              body: Center(
                child: Text("Server Error"),
              ),
            );
          }
        }
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