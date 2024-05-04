import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kerala_wings/data/api_services.dart';
import 'package:kerala_wings/data/models/otp_model.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';
import 'package:kerala_wings/source/features/screens/home/widgets/tripcard_widget.dart';
import 'package:kerala_wings/source/features/screens/startup_screens/login/login_screen.dart';
import 'package:kerala_wings/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/models/driver_view_trip_model.dart';
import '../../../../main.dart';
import '../../../../notification/notitifcation.dart';
import '../../../../provider/current_index_provider.dart';
import 'more_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final Future<OtpModel?>? otpModel;
  final driverId;
  final driverName;
  final driverType;
  final driverStatus;
  final driverProfile;
   HomeScreen({Key? key, this.otpModel, this.driverId, this.driverType, this.driverStatus, this.driverProfile, this.driverName, }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final MyController controller = Get.put(MyController());
   late Future<OtpModel?> otPModel;
  TabController? _tabController;

  RxInt selectedIndex = 0.obs;

   void updateSelectedIndex(int index) {
     selectedIndex.value = index;
   }

   List tabs = ["All","Assigned","Live"];

   Future<DriverViewTripDetailsModel?>? driverViewTripModel;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationAlert.initialize(flutterLocalNotificationsPlugin);
    driverViewTripModel = NetworkHelper().driverViewTripDetailsApi(context: context,driver_id: driverId,type: "");


   }
   String? tripType;


   tripDetail(type){
     driverViewTripModel = NetworkHelper().driverViewTripDetailsApi(context: context,driver_id: driverId,type: type);
return driverViewTripModel;
   }

  @override
  Widget build(BuildContext context) {
    // otPModel =widget.otpModel! ;
    var width = MediaQuery.of(context).size.width;
    return Consumer<CurrentIndexProvider>(
        builder: (context, currentIndexProvider, _) {
      return Scaffold(
        drawer: Drawer(child: Column(children: [
      SizedBox(
        height: 50,

      ),
          InkWell(
              onTap: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();


                prefs.clear();
                // Navigator.push(context,MaterialPageRoute(builder:
                //   (builder)=>SignUp()));

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>LoginScreen()),(Route<dynamic> route) => false,);


              },
              child: Text("Logout"))


        ],),),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [cPrimaryColor, Colors.black],
              ),
            ),
            child: Column(
              children: [
              // FutureBuilder(
              //     future: otPModel,
              //     builder: (context, AsyncSnapshot<OtpModel?> snapshot) {
              //       if(snapshot.hasData){
              //         return Column(children: [
              //           Container(
              //             margin: const EdgeInsets.only(
              //                 left: 15,
              //                 right: 15,
              //                 top: 15
              //             ),
              //             padding: const EdgeInsets.only(
              //                 top: 10
              //             ),
              //             decoration:  BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.only(
              //                   topRight: Radius.circular(15),
              //                   topLeft: Radius.circular(15)
              //               ),
              //             ),
              //             child: ListTile(
              //               horizontalTitleGap: 8,
              //               leading:  CircleAvatar(
              //                 radius: 25,
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(1.0),
              //                   child: ClipRRect(child:  Image.network('https://keralawingstravel.com/public/assets/images/profile/${snapshot.data!.data!.driver!.profile!.toString()}',
              //                     height: 50,
              //                     width: 50,
              //
              //                     fit: BoxFit.fitWidth,
              //                   ),
              //                   clipBehavior: Clip.hardEdge,
              //
              //                     borderRadius: BorderRadius.circular(100),
              //                   ),
              //                 )
              //
              //
              //               ),
              //               title: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       SizedBox(
              //                         width: width*.48,
              //                         child:  Text(
              //                          snapshot.data!.data!.driver!.fName!.toString(),
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.w600,
              //                               fontSize: 14,
              //                               color: cFont
              //                           ),
              //                           maxLines: 1,
              //                           overflow: TextOverflow.ellipsis,
              //
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: width*.38,
              //                         child: DottedLine(
              //                           dashColor: Colors.grey.shade300,
              //                         ),
              //                       ),
              //                       RichText(
              //                           text: TextSpan(
              //                               text: "0",
              //                               style: const TextStyle(
              //                                   fontSize: 15,
              //                                   color: cYellow,
              //                                   fontWeight: FontWeight.w600
              //                               ),
              //                               children: [
              //                                 TextSpan(
              //                                   text: " ",
              //                                   style: TextStyle(
              //                                     fontSize: 10,
              //                                     color: Colors.grey.shade400,
              //                                   ),),
              //                                 TextSpan(
              //                                   text: "Driver",
              //                                   style: TextStyle(
              //                                     fontSize: 10,
              //                                     color: Colors.grey.shade400,
              //                                   ),)
              //                               ]
              //                           )
              //                       )
              //                     ],
              //                   ),
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: [
              //                       Container(
              //                         padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
              //                         decoration: BoxDecoration(
              //                             color: const Color(0xFFEBF4EC),
              //                             borderRadius: BorderRadius.circular(15)
              //                         ),
              //                         child:  Center(
              //                           child:  snapshot.data!.data!.driver!.status==1?Text(
              //                             "ACTIVE",
              //                             style: TextStyle(
              //                                 fontSize: 12,
              //                                 color: cGreen,
              //                                 fontWeight: FontWeight.w500
              //                             ),
              //                           ):
              //                           Text(
              //                             "BLOCKED",
              //                             style: TextStyle(
              //                                 fontSize: 12,
              //                                 color: Colors.red.shade300,
              //                                 fontWeight: FontWeight.w500
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                       const SizedBox(height: 3,),
              //                       Row(
              //                         children: [
              //                           RatingStars(
              //                             valueLabelVisibility: false,
              //                             starCount: 5,
              //                             starColor: cYellow,
              //                             starSize: 10,
              //                             value: 4,
              //                             starOffColor: cFont.withOpacity(.8),
              //
              //                           ),
              //                           const SizedBox(width: 3,),
              //                           const Text(
              //                             "4.0",
              //                             style: TextStyle(
              //                                 color: cYellow,
              //                                 fontSize: 12
              //                             ),
              //                           )
              //                         ],
              //                       )
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //
              //             ),
              //
              //
              //           ),
              //           Container(
              //             margin: const EdgeInsets.only(
              //                 right: 15,
              //                 left: 15,
              //                 bottom: 10
              //             ),
              //             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
              //             decoration: BoxDecoration(
              //               borderRadius: const BorderRadius.only(
              //                   bottomLeft: Radius.circular(15),
              //                   bottomRight: Radius.circular(15)
              //               ),
              //               gradient: LinearGradient(
              //                 begin: Alignment.centerLeft,
              //                 end: Alignment.centerRight,
              //                 colors: [
              //                   const Color(0xFF183E51).withOpacity(.8),
              //                   const Color(0xFF917F7F).withOpacity(.5),
              //                   const Color(0xFF543F3F).withOpacity(.9),
              //                   Colors.black
              //
              //
              //                 ],
              //               ),
              //             ),
              //             child: buildRow("Total","Earnings"),
              //           ),
              //           Container(
              //             margin: const EdgeInsets.symmetric(
              //                 horizontal: 15
              //             ),
              //             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
              //
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(15),
              //               gradient: LinearGradient(
              //                 begin: Alignment.centerLeft,
              //                 end: Alignment.centerRight,
              //                 colors: [
              //                   const Color(0xFF183E51).withOpacity(.8),
              //                   const Color(0xFF917F7F).withOpacity(.5),
              //                   const Color(0xFF543F3F).withOpacity(.9),
              //                   Colors.black
              //
              //
              //                 ],
              //               ),
              //
              //             ),
              //             child: buildRow("Amount", "Payable"),
              //           ),
              //
              //
              //         ],);
              //       }else if(snapshot.connectionState==ConnectionState.waiting){
              //         return Center(child: CircularProgressIndicator(),);
              //       } else {
              //         return Center(child: Text("Please Try Again"),);
              //       }
              //     }
              //   ),

                Column(children: [
                  InkWell(
                    onTap: (){

                      NotificationAlert.showBigTextNotification(title: "Kerala Wings", body: 'New Trip activated', fln: flutterLocalNotificationsPlugin);

                    },

                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15
                      ),
                      padding: const EdgeInsets.only(
                          top: 10
                      ),
                      decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)
                        ),
                      ),
                      child: ListTile(
                        horizontalTitleGap: 8,
                        leading:  CircleAvatar(
                            radius: 25,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: ClipRRect(child:  Image.network('https://keralawingstravel.com/public/assets/images/profile/${driverProfile}',
                                height: 50,
                                width: 50,

                                fit: BoxFit.fitWidth,
                              ),
                                clipBehavior: Clip.hardEdge,

                                borderRadius: BorderRadius.circular(100),
                              ),
                            )


                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width*.4,
                                  child:  Text(
                                   driverName.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: cFont
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,

                                  ),
                                ),
                                SizedBox(
                                  width: width*.38,
                                  child: DottedLine(
                                    dashColor: Colors.grey.shade300,
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: driverGrade.toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: cYellow,
                                            fontWeight: FontWeight.w600
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " ",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey.shade400,
                                            ),),
                                          TextSpan(
                                            text: "Driver",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade400,
                                            ),)
                                        ]
                                    )
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFEBF4EC),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child:  Center(
                                    child: driverStatus.toString()=="1"?Text(
                                      "ACTIVE",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: cGreen,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ):
                                    Text(
                                      "BLOCKED",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.red.shade300,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3,),
                                Row(
                                  children: [
                                    RatingStars(

                                      valueLabelVisibility: false,
                                      starCount: 5,
                                      starColor: cYellow,
                                      starSize: 10,
                                      value: double.parse(driverRating.toString()),
                                      starOffColor: cFont.withOpacity(.8),

                                    ),
                                    const SizedBox(width: 3,),
                                     Text(
                                    '${driverRating}.0',
                                      style: TextStyle(
                                          color: cYellow,
                                          fontSize: 12
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10
                        ),

                      ),


                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        right: 15,
                        left: 15,
                        bottom: 10
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFF183E51).withOpacity(.8),
                          const Color(0xFF917F7F).withOpacity(.5),
                          const Color(0xFF543F3F).withOpacity(.9),
                          Colors.black


                        ],
                      ),
                    ),
                    child: buildRow("Total","Earnings"),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFF183E51).withOpacity(.8),
                          const Color(0xFF917F7F).withOpacity(.5),
                          const Color(0xFF543F3F).withOpacity(.9),
                          Colors.black


                        ],
                      ),

                    ),
                    child: buildRow("Current", "Pending"),
                  ),


                ],),

                Expanded(
                    child: DefaultTabController(
                      length: tabs.length,
                      child: Container(
                        width: width,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(
                          top: 20
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFFECECEC),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(text: TextSpan(
                                  text: "Trip",
                                  style: const TextStyle(
                                    color: cDarkBlue,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: " ",
                                    ),
                                    TextSpan(
                                      text: "Details",
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700
                                      ),
                                    )
                                  ]
                                ),
                                ),
                                InkWell(
                                  onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (builder)=>MoreDetailsScreen(driverId:driverId.toString()))) ;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: cPrimaryColor,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 15,),
                                    RichText(text: TextSpan(
                                    text: "More",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: " ",
                                          ),
                                          TextSpan(
                                            text: "information  ",
                                            style: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500
                                            ),
                                          )
                                        ]
                                    ),),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: SvgPicture.asset(iArrowRight),
                                          ),
                                        )

                                    ]
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            DottedLine(
                              dashColor: cFont.withOpacity(.5),
                            ),
                            SizedBox(height: 10,),
                            TabBar(
                              labelPadding: EdgeInsets.only(right: 15),


                              onTap: (index) {
                                currentIndexProvider.updateIndex(index);
                                print("currentIndexProvider.currentIndex => ${currentIndexProvider.currentIndex}");

                                currentIndexProvider.currentIndex == 1 ? tripType = "assigned" : currentIndexProvider.currentIndex == 2 ? tripType = "live" : tripType = "";
                                print("$tripType--$index");
                                tripDetail(tripType);
                              },
                              controller: _tabController,

                              tabAlignment: TabAlignment.start,
                              dividerColor: Colors.transparent,
                              indicatorSize: TabBarIndicatorSize.label,
                              dividerHeight: 0,
                              isScrollable: true,
                              labelColor: cDarkBlue,
                              padding: EdgeInsets.zero,
                              indicatorPadding: EdgeInsets.zero,
                              labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                              ),
                              unselectedLabelStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),
                              unselectedLabelColor: Colors.grey.shade400,
                              indicator: null,
                              indicatorColor: Colors.transparent,
                              tabs: List.generate(
                                tabs.length,
                                    (index) => Consumer<CurrentIndexProvider>(

          builder: (context, currentIndex, _){
           // currentIndexProvider.updateIndex(_tabController!.index );
                                    return Container(
                                                                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                                        decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: currentIndexProvider.currentIndex == index ? cDarkBlue : Colors.transparent,
                                        width: 1.5,
                                      ),
                                                                        ),
                                                                        child: Center(
                                      child: Text(tabs[index], style: TextStyle(fontSize: 16),),
                                                                        ),
                                                                      );}
                                    ),
                              ),
                            ),
                            Expanded(child: Consumer<CurrentIndexProvider>(
                      builder: (context, currentIndexProvider, _) {
                        // Get the current index value from the provider
                        final currentIndex = currentIndexProvider.currentIndex;
                           return  TabBarView(
                             physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(
                                    tabs.length, (index) => FutureBuilder(
                                    future: driverViewTripModel,
                                      builder: (context, AsyncSnapshot<DriverViewTripDetailsModel?> snapshot) {
                                      if(snapshot.hasData){
                                      return
                                        snapshot.data!.data!.isEmpty?
                                            Center(child: Text("No trip available"),):


                                        ListView.builder(
                                        padding: EdgeInsets.only(top: 15),
                                        itemCount: snapshot.data!.data!.length,
                                        itemBuilder: (context,index){


                                          return TripCardWidget(
                                            tripType:tripType,
                                            bookingId: snapshot.data!.data![index].bookingId.toString(),
                                            customerName:  snapshot.data!.data![index].customerName,
                                            customerNumber: snapshot.data!.data![index].customerNumber,
                                            bookingType:  snapshot.data!.data![index].bookingType,
                                            driverStatus:  snapshot.data!.data![index].status,
                                            date:     snapshot.data!.data![index].date,
                                            enDate:     snapshot.data!.data![index].endDate,
                                            address:     snapshot.data!.data![index].address,
                                            remark:     snapshot.data!.data![index].remark,
                                            destination:   snapshot.data!.data![index].destination,
                                            trippType:snapshot.data!.data![index].tripType,
                                            driverIdAssign:  snapshot.data!.data![index].driverIdAssign,
                                            pickupLocation: snapshot.data!.data![index].pickupLocation,
                                            time:  snapshot.data!.data![index].time,
                                            vehicle:   snapshot.data!.data![index].vehicle,
                                            vehNo:   snapshot.data!.data![index].vehNo,
                                            vehType:  snapshot.data!.data![index].vehType,




                                          );
                                        },
                                      );
                                      }
                                      else if(snapshot.connectionState==ConnectionState.waiting){
                                        return Center(child: CircularProgressIndicator(),);
                                      }else{
                                        return Center(child: Text("Please Try Again"),);
                                      }

                                      }
                                    )
                                ),
                              );}),
                            )



                          ],
                        ),

                                    ),
                    ),
                )
              ],
            ),
          ),
        ),
      );}
    );
  }

  Row buildRow(text1, text2) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  RichText(text:  TextSpan(
                    text: text1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                    ),
                    children: [
                      TextSpan(
                          text: "  ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          )
                      ),
                      TextSpan(
                        text: text2,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        )
                      )
                    ]
                  ),
                  ),
                  const Text(
                    "Coming soon",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      )
                  )

                ],
              );
  }
}

class CustomTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function onTap;

  CustomTab({required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? cDarkBlue : Colors.transparent,
            width: isSelected ? 2 : 0,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? cDarkBlue : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
class MyController extends GetxController {
  var selectedIndex = 0.obs;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
