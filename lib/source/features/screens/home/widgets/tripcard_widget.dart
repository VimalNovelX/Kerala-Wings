import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';
import 'package:kerala_wings/source/features/screens/home/widgets/bottom_sheet_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TripCardWidget extends StatefulWidget {
  final String? customerName;
  final String? tripType;
  final String? trippType;
  final String? customerNumber;
  final String? bookingType;
  final String? date;
  final String? destination;
  final int? driverIdAssign;
  final String? pickupLocation;
  final String? time;
  final String? vehicle;
  final String?vehNo;
  final String? vehType;
  final String? bookingId;
  const TripCardWidget({Key? key, this.customerName, this.customerNumber, this.bookingType, this.date, this.destination, this.driverIdAssign, this.pickupLocation, this.time, this.vehicle, this.vehNo, this.vehType, this.bookingId, this.tripType, this.trippType,  }) : super(key: key);

  @override
  State<TripCardWidget> createState() => _TripCardWidgetState();
}

class _TripCardWidgetState extends State<TripCardWidget> {

  Future<void> _launchUrl(phoneNumber) async {
    String _url = 'tel:$phoneNumber';
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }
  void _makePhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        Get.bottomSheet(
          BottomSheetWidget(
              bookingId:widget.bookingId,
              customerName: widget.customerName,
              vehNo:  widget.vehNo,
              vehType:  widget.vehType,vehicle:widget.vehicle,
              time:  widget.time,driverIdAssign:widget.driverIdAssign,
              date:  widget.date,
              bookingType: widget.bookingType,
              pickupLocation:    widget.pickupLocation,destination:widget.destination)
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
                      child:  IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(
                                widget.date!.toString(),
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
                              widget.time!.toString(),
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
                     Padding(
                      padding: EdgeInsets.only(left: 15.0,top: 8,bottom: 2),
                      child: Text(
                          widget.customerName!.toString(),
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
                        widget.vehicle!.toString(),
                              style: TextStyle(
                                  color:
                                  widget.vehType.toString()=="Manual"?
                                  Colors.blue: widget.vehType.toString()=="Automatic"?
                                  Colors.red:Colors.green,
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
                                text:  TextSpan(
                                  text: widget.vehNo!.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: cPrimaryColor,
                                    fontWeight: FontWeight.w500
                                  ),
                                  children: [
                                    TextSpan(
                                      text: " ( ${widget.vehType!.toString()} )",
                                      style: TextStyle(
                                        color: widget.vehType.toString()=="Manual"?
                                        Colors.blue: widget.vehType.toString()=="Automatic"?
                                        Colors.red:Colors.green,
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
                         widget.trippType.toString()=="Drop"? "Drop":"Point to Point",
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
                InkWell(
                  onTap: (){
                    //_makePhoneCall(widget.customerNumber!);
                    _launchUrl(widget.customerNumber);

                  },
                  child: Container(
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
                  ),
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
                        buildRichText(text1: widget.pickupLocation!.toString(),text2: widget.destination!.toString(),),
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
              buildRichText(text1: widget.destination!.toString(),text2: widget.destination!.toString(),),




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
                          color:widget.bookingType.toString()=="Live"?Colors.green: cPrimaryColor,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child:  Center(
                        child: Text(
                          widget.bookingType.toString(),
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

  RichText buildRichText({text1,text2}) {
    return RichText(text:
                         TextSpan(
                          text: "$text1\n",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: cDarkBlue
                          ),
                          children: [
                            TextSpan(
                              text:  "$text2",
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
