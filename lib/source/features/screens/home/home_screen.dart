import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kerala_wings/data/api_services.dart';
import 'package:kerala_wings/data/models/end_trip_model.dart';
import 'package:kerala_wings/data/models/otp_model.dart';
import 'package:kerala_wings/data/models/start_trip_model.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';
import 'package:kerala_wings/source/features/screens/home/controller.dart';
import 'package:kerala_wings/source/features/screens/home/widgets/tripcard_widget.dart';
import 'package:kerala_wings/source/features/screens/startup_screens/login/login_screen.dart';
import 'package:kerala_wings/utils/constants.dart';
import 'package:kerala_wings/utils/toastUtil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/models/driver_view_trip_model.dart';
import '../../../../provider/current_index_provider.dart';
import 'more_details_screen.dart';
import 'widgets/bottom_sheet_widget.dart';

class HomeScreen extends StatefulWidget {
  final Future<OtpModel?>? otpModel;
  final driverId;
  final driverName;
  final driverType;
  final driverStatus;
  final driverProfile;
  HomeScreen({
    Key? key,
    this.otpModel,
    this.driverId,
    this.driverType,
    this.driverStatus,
    this.driverProfile,
    this.driverName,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MyController controller = Get.put(MyController());
  final MainPageController mainController = Get.put(MainPageController());
  late Future<OtpModel?> otPModel;
  TabController? _tabController;

  RxInt selectedIndex = 0.obs;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  List tabs = ["All", "Assigned", "Live"];

  Future<DriverViewTripDetailsModel?>? driverViewTripModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // driverViewTripModel = NetworkHelper().driverViewTripDetailsApi(
    //     context: context, driver_id: driverId, type: "");
  }

  String? tripType;

  tripDetail(type) {
    driverViewTripModel = NetworkHelper().driverViewTripDetailsApi(
        context: context, driver_id: driverId, type: type);
    return driverViewTripModel;
  }

  final isRideStart = RxBool(GetStorage().read('isRideStart') ?? false);
 Future<StartTripModel?>? startTripModel;
  Future<EndTripModel?>? endTripModel;



  @override
  Widget build(BuildContext context) {
    // otPModel =widget.otpModel! ;
    var width = MediaQuery.of(context).size.width;

    return Consumer<CurrentIndexProvider>(
        builder: (context, currentIndexProvider, _) {
      return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    prefs.clear();
                    // Navigator.push(context,MaterialPageRoute(builder:
                    //   (builder)=>SignUp()));

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text("Logout"))
            ],
          ),
        ),
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
                Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      padding: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                      ),
                      child: ListTile(
                        horizontalTitleGap: 8,
                        leading: CircleAvatar(
                            radius: 25,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: ClipRRect(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  'https://keralawingstravel.com/public/assets/images/profile/${driverProfile}',
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            )),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * .4,
                                  child: Text(
                                    driverName.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: cFont),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: width * .38,
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
                                            fontWeight: FontWeight.w600),
                                        children: [
                                      TextSpan(
                                        text: " ",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Driver",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade400,
                                        ),
                                      )
                                    ]))
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 3),
                                  decoration: BoxDecoration(
                                      color:driverStatus.toString() == "1" ? Color(0xFFEBF4EC) : Colors.red,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: driverStatus.toString() == "1"
                                        ? const Text(
                                            "ACTIVE",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: cGreen,
                                                fontWeight: FontWeight.w500),
                                          )
                                        : Text(
                                            "BLOCKED",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    RatingStars(
                                      valueLabelVisibility: false,
                                      starCount: 5,
                                      starColor: cYellow,
                                      starSize: 10,
                                      value:
                                          double.parse(driverRating.toString()),
                                      starOffColor: cFont.withOpacity(.8),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '${driverRating}.0',
                                      style: const TextStyle(
                                          color: cYellow, fontSize: 12),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
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
                      child: buildRow("Total", "Earnings"),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
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
                  ],
                ),
                Expanded(
                  child: DefaultTabController(
                    length: tabs.length,
                    child: Container(
                      width: width,
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                          color: Color(0xFFECECEC),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "Trip",
                                    style: const TextStyle(
                                        color: cDarkBlue,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700),
                                    children: [
                                      const TextSpan(
                                        text: " ",
                                      ),
                                      TextSpan(
                                        text: "Details",
                                        style: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ]),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              MoreDetailsScreen(
                                                  driverId:
                                                      driverId.toString())));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: cPrimaryColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: "More",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          children: [
                                            const TextSpan(
                                              text: " ",
                                            ),
                                            TextSpan(
                                              text: "information  ",
                                              style: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ]),
                                    ),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SvgPicture.asset(iArrowRight),
                                      ),
                                    )
                                  ]),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DottedLine(
                            dashColor: cFont.withOpacity(.5),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TabBar(
                            labelPadding: const EdgeInsets.only(right: 15),
                            onTap: (index) {
                              currentIndexProvider.updateIndex(index);
                              print(
                                  "currentIndexProvider.currentIndex => ${currentIndexProvider.currentIndex}");

                              currentIndexProvider.currentIndex == 1
                                  ? tripType = "assigned"
                                  : currentIndexProvider.currentIndex == 2
                                      ? tripType = "live"
                                      : tripType = "";
                              print("$tripType--$index");
                              mainController.fetchTrips(tripType);
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
                            labelStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                            unselectedLabelStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            unselectedLabelColor: Colors.grey.shade400,
                            indicator: null,
                            indicatorColor: Colors.transparent,
                            tabs: List.generate(
                              tabs.length,
                              (index) => Consumer<CurrentIndexProvider>(
                                  builder: (context, currentIndex, _) {
                                // currentIndexProvider.updateIndex(_tabController!.index );
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color:
                                          currentIndexProvider.currentIndex ==
                                                  index
                                              ? cDarkBlue
                                              : Colors.transparent,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      tabs[index],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Expanded(
                            child: Consumer<CurrentIndexProvider>(
                                builder: (context, currentIndexProvider, _) {
                              // Get the current index value from the provider
                              final currentIndex =
                                  currentIndexProvider.currentIndex;
                              return Obx(() =>  TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(
                                    tabs.length,
                                    (index) => mainController.isLoading.value? const Center(
                                      child: CircularProgressIndicator(),
                                    ) : mainController.trips.isEmpty? const Center(
                                      child: Text("No Trips available"),
                                    ) : ListView.builder(
                                      padding:
                                      const EdgeInsets.only(
                                          top: 15),
                                      itemCount: mainController.trips.length,
                                      itemBuilder:
                                          (context, index) {
                                            var trip = mainController.trips[index];
                                            trip.status.toString() == "Live"
                                                ? mainController.isRideStart.value = true
                                                : mainController.isRideStart.value = false;

                                        return TripCardWidget(

                                          onTap: (){
                                            debugPrint("mainController.isRideStart.value------${trip.status}----------${mainController.isRideStart.value}");
                                            Get.bottomSheet(
                                              // BottomSheetWidget(
                                              //     bookingId:snapshot
                                              //         .data!
                                              //         .data![index]
                                              //         .bookingId
                                              //         .toString(),
                                              //     customerName: snapshot
                                              //         .data!
                                              //         .data![index]
                                              //         .customerName,
                                              //     vehNo:  snapshot.data!
                                              //         .data![index].vehNo,
                                              //     vehType:  snapshot.data!
                                              //         .data![index].vehType,
                                              //     time:  snapshot.data!
                                              //         .data![index].time,
                                              //     driverIdAssign:snapshot.data!
                                              //         .data![index].driverIdAssign,
                                              //     date:  snapshot.data!
                                              //         .data![index].date,
                                              //     bookingType: snapshot.data!
                                              //         .data![index].bookingType,
                                              //     pickupLocation:    snapshot.data!
                                              //         .data![index].pickupLocation,
                                              //     driverStatus: snapshot.data!
                                              //         .data![index].status,
                                              //     destination:snapshot.data!
                                              //         .data![index].destination,
                                              //   vehicle: snapshot
                                              //       .data!
                                              //       .data![index]
                                              //       .vehicle,
                                              //
                                              // )

                                                trip.status.toString() == "Live"
                                                      ? Container(
                                                    padding: const EdgeInsets.all(15),
                                                    decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(30),
                                                        topRight: Radius.circular(30),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        const Text(
                                                          "Are You Sure",
                                                          style: TextStyle(
                                                            color: cFont,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          "you want to end the trip",
                                                          style: TextStyle(
                                                            color: cRed.withOpacity(.5),
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              child: Container(
                                                                height: 45,
                                                                width: width * .38,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(25),
                                                                  border: Border.all(
                                                                    color: cRed.withOpacity(.5),
                                                                  ),
                                                                ),
                                                                child: const Center(
                                                                  child: Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                      color: cRed,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return AlertDialog(
                                                                        title: const Text("Enter the Charge"),
                                                                        content: TextField(
                                                                          controller: mainController.textFieldController,
                                                                          keyboardType: TextInputType.number,
                                                                          decoration: const InputDecoration(
                                                                            hintText: "Rs.",
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          Center(
                                                                            child: TextButton(
                                                                              onPressed: () {
                                                                                mainController.textFieldController.text.isNotEmpty
                                                                                    ? mainController.endTrip(
                                                                                    mainController.textFieldController.text,
                                                                                    trip.bookingId.toString(),
                                                                                  tripType
                                                                                )
                                                                                    : ToastUtil.show(
                                                                                    "Enter amount to end the ride!!");
                                                                                // debugPrint("booking-------id------${trip.bookingId}---------${_textFieldController.text}");
                                                                              },
                                                                              style: TextButton.styleFrom(
                                                                                backgroundColor: cRed,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius:
                                                                                  BorderRadius.circular(25),
                                                                                ),
                                                                                padding: const EdgeInsets.symmetric(
                                                                                    horizontal: 20),
                                                                              ),
                                                                              child: const Text(
                                                                                "End Ride",
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: Container(
                                                                  height: 45,
                                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(25),
                                                                    color: cRed,
                                                                  ),
                                                                  child: const Center(
                                                                    child: Text(
                                                                      "End Ride",
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )

                                                      :

                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      color: cPrimaryColor,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(30),
                                                        topRight: Radius.circular(30),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        ListTile(
                                                          minVerticalPadding: 0,
                                                          title: Text(
                                                            trip.pickupLocation,
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.white,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            "${ trip.pickupLocation} to ${ trip.destination}",
                                                            style: const TextStyle(
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
                                                            vertical: 10,
                                                          ),
                                                          width: width,
                                                          decoration: const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(30),
                                                              topRight: Radius.circular(30),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    trip.customerName,
                                                                    style: const TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w600,
                                                                      color: cDarkBlue,
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    "Today",
                                                                    style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w600,
                                                                      color: cPrimaryColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  IntrinsicHeight(
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          trip.vehicle,
                                                                          style: TextStyle(
                                                                              color: trip.vehType ==
                                                                                  "Manual"
                                                                                  ? Colors.blue
                                                                                  : trip.vehType ==
                                                                                  "Automatic"
                                                                                  ? Colors.red
                                                                                  : Colors.green,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 12),
                                                                        ),
                                                                        const SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        VerticalDivider(
                                                                          indent: 2,
                                                                          endIndent: 2,
                                                                          thickness: 1,
                                                                          color: Colors.grey.shade500,
                                                                          width: 2,
                                                                        ),
                                                                        const SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Text(
                                                                          trip.vehNo,
                                                                          style: const TextStyle(
                                                                            fontSize: 10,
                                                                            color: cPrimaryColor,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  IntrinsicHeight(
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                    trip.date,
                                                                          style: TextStyle(
                                                                            color: Colors.grey.shade500,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 10,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        VerticalDivider(
                                                                          indent: 2,
                                                                          endIndent: 2,
                                                                          thickness: 1,
                                                                          color: Colors.grey.shade500,
                                                                          width: 2,
                                                                        ),
                                                                        const SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Text(
                                                                         trip.time,
                                                                          style: const TextStyle(
                                                                            fontSize: 10,
                                                                            color: Colors.grey,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 7,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                child: DottedLine(
                                                                  dashColor: Colors.grey.withOpacity(.5),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                    child: Container(
                                                                      height: 45,
                                                                      width: width * .38,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(25),
                                                                        border: Border.all(
                                                                          color: cRed.withOpacity(.5),
                                                                        ),
                                                                      ),
                                                                      child: const Center(
                                                                        child: Text(
                                                                          "Cancel",
                                                                          style: TextStyle(
                                                                            color: cRed,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Expanded(
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                       mainController.startTrip(
                                                                           trip.bookingId.toString(),
                                                                         trip.customerName,
                                                                         tripType.toString()

                                                                       );

                                                                      },
                                                                      child: Container(
                                                                        height: 45,
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal: 20),
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(25),
                                                                          color: cPrimaryColor,
                                                                        ),
                                                                        child: const Center(
                                                                          child: Text(
                                                                            "Start Ride",
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                            );
                                            trip.status.toString() == "Live" ? null :
                                                NetworkHelper().seenUpdate(
                                                    context: context,
                                                    bookingId: trip.bookingId.toString()
                                                );
                                            debugPrint("bookingida------------------${trip.bookingId.toString()}");

                                          },
                                          tripType: tripType,
                                          bookingId: trip.bookingId.toString(),
                                          customerName: trip.customerName,
                                          customerNumber: trip.customerNumber,
                                          bookingType: trip.bookingType,
                                          driverStatus: trip.status,
                                          date: trip.date,
                                          enDate: trip.endDate,
                                          address: trip.address,
                                          remark: trip.remark,
                                          destination: trip.destination,
                                          trippType: trip.tripType,
                                          driverIdAssign: trip.driverIdAssign,
                                          pickupLocation:trip.pickupLocation,
                                          time: trip.time,
                                          vehicle: trip.vehicle,
                                          vehNo: trip.vehNo,
                                          vehType:trip.vehType
                                        );
                                      },
                                    )
                                ),
                              ));
                            }),
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
      );
    });

  }
  Future<void> endTrip(amount,bookingId) async {
    // Call the endTripApi function with the provided reason
    endTripModel = NetworkHelper().endTripApi(
        context: context,
        bookingId: bookingId,
        tripStartBy: "revi",
        amount: amount);

    isRideStart.value = false;
    GetStorage().write('isRideStart', false);
    //Navigator.of(context).pop();

    Get.offAll(HomeScreen(driverId: driverId,));
  }





  Row buildRow(text1, text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: text1,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              children: [
                const TextSpan(
                    text: "  ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white)),
                TextSpan(
                    text: text2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white))
              ]),
        ),
        const Text("Coming soon",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white))
      ],
    );
  }
}

class CustomTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function onTap;

  CustomTab(
      {required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
