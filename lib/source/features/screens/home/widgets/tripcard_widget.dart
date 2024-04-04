import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';
import 'package:kerala_wings/source/features/screens/home/widgets/bottom_sheet_widget.dart';

class TripCardWidget extends StatelessWidget {
  const TripCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        Get.bottomSheet(
          BottomSheetWidget()
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width*.6,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5
                      ),
                      decoration: const BoxDecoration(
                        color: cPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                        )
                      ),
                      child: const IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(
                                "15 Dec 22",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12
                              ),
                            ),
                           SizedBox(width: 5,),
                           VerticalDivider(
                             indent: 2,
                             endIndent: 2,
                             thickness: 1,
                             color: Colors.white,
                             width: 2,

                           ),
                            SizedBox(width: 5,),


                            Text(
                              "10.20 am",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0,top: 8,bottom: 2),
                      child: Text(
                          "P Mathew Varghese",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(
                              "Maruti Swift",
                              style: TextStyle(
                                  color:Colors.grey.shade400,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                              ),
                            ),
                            const SizedBox(width: 5,),
                            VerticalDivider(
                              indent: 2,
                              endIndent: 2,
                              thickness: 1,
                              color:Colors.grey.shade400,
                              width: 2,

                            ),
                            const SizedBox(width: 5,),


                            RichText(
                                text: const TextSpan(
                                  text: "KL 22 3456",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: cPrimaryColor,
                                    fontWeight: FontWeight.w500
                                  ),
                                  children: [
                                    TextSpan(
                                      text: " ( manual )",
                                      style: TextStyle(
                                        color: cGreen,
                                        fontSize: 12,

                                      )
                                    )
                                  ]
                                )
                            ),

                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        top: 8,
                        bottom: 10
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 3
                      ),
                      decoration: BoxDecoration(
                        color: cDarkBlue.withOpacity(.1),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Text(
                          "Point to Point",
                          style: TextStyle(
                            color: cDarkBlue.withOpacity(.8),
                            fontWeight: FontWeight.w500,
                            fontSize: 10
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: SizedBox(
                        width: width*.6,
                          child: DottedLine(
                            dashColor: Colors.grey.shade300,
                          )
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                    top: 10
                  ),
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(12),

                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0,0)
                      )
                    ],
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                  child: SvgPicture.asset(iPhone),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,vertical: 10),
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(3),

                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: cGrey.withOpacity(.5),
                                    spreadRadius: 5,
                                    blurRadius: 2,
                                    offset: const Offset(0,0)
                                )
                              ],
                              color: Colors.white,
                              shape: BoxShape.circle
                          ),
                          child: CircleAvatar(
                            backgroundColor: cPrimaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(iCar),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: LayoutBuilder(
                              builder: (BuildContext context,BoxConstraints constraints){
                                print("the width iss ${constraints.constrainWidth()}");
                                return Flex(direction: Axis.vertical,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate((constraints.constrainHeight()/4).floor(), (index) =>  SizedBox(
                                      height: 2,width: 2,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade400,

                                        ),
                                      ))),
                                );
                              }
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 2
                          ),
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.grey
                              )
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: LayoutBuilder(
                              builder: (BuildContext context,BoxConstraints constraints){
                                print("the width iss ${constraints.constrainWidth()}");
                                return Flex(direction: Axis.vertical,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate((constraints.constrainHeight()/4).floor(), (index) =>  SizedBox(
                                      height: 2,width: 2,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade400,

                                        ),
                                      ))),
                                );
                              }
                          ),
                        ),
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: cGreen.withOpacity(.8),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset(iLocation),
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(width: 5,),
                  SizedBox(
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRichText(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 3
                          ),
                          decoration: BoxDecoration(
                              color: cDarkBlue.withOpacity(.1),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text(
                              "Point to Point",
                              style: TextStyle(
                                  color: cDarkBlue.withOpacity(.8),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10
                              ),
                            ),
                          ),
                        ),
                        buildRichText(),



                      ],
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3
                      ),
                      decoration: BoxDecoration(
                          color: cPrimaryColor,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: const Center(
                        child: Text(
                          "Assigned",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 10
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  RichText buildRichText() {
    return RichText(text:
                        const TextSpan(
                          text: "Poojapura\n",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: cDarkBlue
                          ),
                          children: [
                            TextSpan(
                              text:  "poojaoura po trivandrum tvm 12",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey
                              ),
                            )
                          ]
                        )
                    );
  }
}
