import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';

class BottomSheetWidget extends StatelessWidget {
   BottomSheetWidget({Key? key}) : super(key: key);


  RxBool isRideStart = false.obs;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Obx(() => isRideStart.value?Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8,),
          const Text(
            "Are You Sure",
            style: TextStyle(
              color: cFont,
              fontSize: 18,
              fontWeight: FontWeight.w600

            ),
          ),
          Text(
            "you want to end the trip",
            style: TextStyle(
              color: cRed.withOpacity(.5),
              fontSize: 18

            ),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              InkWell(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  height: 45,
                  width: width*.38,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          25
                      ),
                      border: Border.all(
                          color: cRed.withOpacity(.5)
                      )
                  ),
                  child: const Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: cRed
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: InkWell(
                  onTap: (){
                    isRideStart.value = true;

                  },
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            25
                        ),
                        color: cRed

                    ),
                    child: const Center(
                      child: Text(
                        "End Ride",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )

        ],
      ),

    ) : Container(
      // height: 150,
      decoration: const BoxDecoration(
          color: cPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            minVerticalPadding: 0,
            title: const Text(
              "Poojapura",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            subtitle: const Text(
              "ppojapura to trivandrum 12",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 10,
              ),
            ),
            trailing: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                iCar,
                color: cPrimaryColor,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            width: width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "P Mathew Varghese",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        color: cDarkBlue
                      ),
                    ),
                    Text(
                      "Today",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        color: cPrimaryColor
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            "Maruti Swift",
                            style: TextStyle(
                                color:Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                                fontSize: 12
                            ),
                          ),
                          const SizedBox(width: 5,),
                          VerticalDivider(
                            indent: 2,
                            endIndent: 2,
                            thickness: 1,
                            color:Colors.grey.shade500,
                            width: 2,

                          ),
                          const SizedBox(width: 5,),
                          const Text(
                            "KL 22 3456",
                            style: TextStyle(
                                fontSize: 10,
                                color: cPrimaryColor,
                                fontWeight: FontWeight.w500
                            ),
                          )



                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            "15 Dec 22",
                            style: TextStyle(
                                color:Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                                fontSize: 10
                            ),
                          ),
                          const SizedBox(width: 5,),
                          VerticalDivider(
                            indent: 2,
                            endIndent: 2,
                            thickness: 1,
                            color:Colors.grey.shade500,
                            width: 2,

                          ),
                          const SizedBox(width: 5,),
                          const Text(
                            "10:20 am",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500
                            ),
                          )



                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7,),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10),
                  child: DottedLine(
                    dashColor: Colors.grey.withOpacity(.5),

                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height: 45,
                        width: width*.38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            25
                          ),
                          border: Border.all(
                            color: cRed.withOpacity(.5)
                          )
                        ),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: cRed
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          isRideStart.value = true;

                        },
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              25
                            ),
                            color: cPrimaryColor

                          ),
                          child: const Center(
                            child: Text(
                              "Start Ride",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

        ],
      ),)
    );

  }
}
