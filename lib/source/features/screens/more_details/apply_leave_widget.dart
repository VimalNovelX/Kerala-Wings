import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kerala_wings/data/models/driver_leave_apply_model.dart';
import 'package:kerala_wings/source/features/screens/home/more_details_screen.dart';
import 'package:kerala_wings/utils/constants.dart';
import 'package:kerala_wings/utils/toastUtil.dart';
import 'package:kerala_wings/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

import '../../../../data/api_services.dart';
import '../../../constants/colors.dart';

class ApplyLeaveWidget extends StatefulWidget {
  final String? driverId;
  const ApplyLeaveWidget({super.key, this.driverId});

  @override
  State<ApplyLeaveWidget> createState() => _ApplyLeaveWidgetState();
}

class _ApplyLeaveWidgetState extends State<ApplyLeaveWidget> {

  Future<DriverLeaveApplyModel?>? driverLeaveApplyModel;



  DateTime _selectedDate = DateTime.now();
  TextEditingController _startDate =TextEditingController();
  TextEditingController _endDate =TextEditingController();
  TextEditingController _startTime =TextEditingController();
  TextEditingController _endTime =TextEditingController();
   DateTime? _startDatepicked;
   DateTime? _endDatepicked;
   TimeOfDay? _startTimepicked;
   TimeOfDay? _endTimepicked;
   String leaveDays ="0";
  bool _chosenValue=false;
  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    DateTime dayAfterTomorrow = DateTime(now.year, now.month, now.day + 2);

    // Check if it's after 5 PM
    if (now.hour >= 17) {
      // If it's after 5 PM, disable tomorrow
      tomorrow = dayAfterTomorrow;
    }

     _startDatepicked = (await showDatePicker(
      context: context,
      initialDate:tomorrow,
      firstDate: tomorrow,
      lastDate: DateTime(2101),
    ))!;

    if (_startDatepicked != null) {
      setState(() {
        _startDate.text = DateFormat('dd/MM/yyyy').format(_startDatepicked!);
      });
    }
  }
  Future<void> _selectEndDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    DateTime dayAfterTomorrow = DateTime(now.year, now.month, now.day + 2);

    // Check if it's after 5 PM
    if (now.hour >= 17) {
      // If it's after 5 PM, disable tomorrow
      tomorrow = dayAfterTomorrow;
    }
    _endDatepicked = (await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: tomorrow,
      lastDate: DateTime(2101),
    ))!;

    if (_endDatepicked != null) {
      setState(() {
        _endDate.text = DateFormat('dd/MM/yyyy').format(_endDatepicked!);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {

    _startTimepicked = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    ))!;

    if (_startTimepicked != null) {
      setState(() {
        _startTime.text = _startTimepicked!.format(context);
      });
      print(_startTime.text);
    }
  }
  Future<void> _selectEndTime(BuildContext context) async {
    _endTimepicked = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 11, minute: 59),
    ))!;

    if (_endTimepicked != null) {
      setState(() {
        _endTime.text = _endTimepicked!.format(context);
      });
    }
  }

  // Future<void> _selectEndDate(BuildContext context) async {
  //   DateTime now = DateTime.now();
  //   DateTime tomorrow = DateTime.now().add(Duration(days: 1));
  //   DateTime dayAfterTomorrow = DateTime(now.year, now.month, now.day + 2);
  //
  //   // Check if it's after 5 PM
  //   if (now.hour >= 17) {
  //     // If it's after 5 PM, disable tomorrow
  //     tomorrow = dayAfterTomorrow;
  //   }
  //   _endDatepicked = (await showDatePicker(
  //     context: context,
  //     initialDate: tomorrow,
  //     firstDate: tomorrow,
  //     lastDate: DateTime(2101),
  //   ))!;
  //
  //   if (_endDatepicked != null) {
  //     // Show a dialog to select leave days
  //     int? selectedLeaveDays = await showDialog<int>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Select Leave Days'),
  //           content: Text('How many days are you taking leave for?'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(1); // 1 day leave
  //               },
  //               child: Text('1 Day'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(2); // 2 days leave
  //               },
  //               child: Text('2 Days'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(3); // 3 days leave
  //               },
  //               child: Text('3 Days'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //
  //     if (selectedLeaveDays != null) {
  //       // Set the leave days
  //       setState(() {
  //         _endDatepicked = _endDatepicked!.add(Duration(days: selectedLeaveDays - 1));
  //         _endDate.text = DateFormat('dd/MM/yyyy').format(_endDatepicked!);
  //       });
  //     }
  //   }
  // }
  //
  //

  List<String> months = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',




  ];



  bool isLessThan10Hours(
      {required DateTime start, required TimeOfDay startTime, required DateTime end, required TimeOfDay endTime}) {
    final startDateTime = DateTime(start.year, start.month, start.day, startTime.hour, startTime.minute);
    final endDateTime = DateTime(end.year, end.month, end.day, endTime.hour, endTime.minute);
    final duration = endDateTime.difference(startDateTime);
    leaveDays =duration.inDays.toString();
    leaveDays=="0"?leaveDays="1":leaveDays;
    return duration.inHours < 23;
  }


  String convertToFormattedDateTime(String date) {
    // Parse the date string
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);

    // Parse the time string
    //TimeOfDay parsedTime = TimeOfDay.fromDateTime(DateFormat.jm().parse(time));

    // Combine date and time into a DateTime object
    DateTime dateTime = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);

    // Format the DateTime object into the desired format "yyyy-MM-dd HH:mm:ss"
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String convertTimeOfDayToString(TimeOfDay timeOfDay) {
    // Convert TimeOfDay to DateTime
    final now = DateTime.now();
    final DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

    // Format DateTime into desired format
    return DateFormat("HH:mm:ss").format(dateTime);
  }


applyLeave({days,fromDate,toDate,driverId,toTime,fromTime}){
  driverLeaveApplyModel = NetworkHelper().leaveApplyAPI(context: context,driverId:widget.driverId,days: days,fromDate: fromDate,toDate: toDate,fromTime: fromTime,toTime: toTime  );

  return driverLeaveApplyModel;
  }





  time(){
    _startTime.text =  TimeOfDay(hour: 0, minute: 0).format(context);
    _startTimepicked=  TimeOfDay(hour: 0, minute: 0);
    _endTimepicked=TimeOfDay(hour: 11, minute: 59);
    _endTime.text = TimeOfDay(hour: 11, minute: 59).format(context);
  }



@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    time();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return  SingleChildScrollView(
      child: Container(
        width: double.infinity,
        //height: 600,
       constraints: BoxConstraints(maxHeight:800 ),

        padding: const EdgeInsets.all(16),
      
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        ),),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                  text: "Apply \n",
                  style: const TextStyle(
                      color: cFont,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "Leave",
                        style: TextStyle(
                            color:
                         cPrimaryColor
                               ))
                  ]),
            ),
          ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          // child: ReadMoreText("ലീവിന് വേണ്ടിയുള്ള അപേക്ഷ തലേദിവസം 05.00PM നു മുൻപേ 9074884898 എന്ന നമ്പറിൽ \"I Need leave for 01/01/2000 to 01/01/2000\"(Type Reason)  എന്ന് Whatsapp സന്ദേശം അയക്കുക, ശേഷം ലീവ്  അനുവദിച്ചാൽ മാത്രം താഴെ LEAVE APPLY ചെയ്യുക."+
          //     "\n\n അത്യാഹിതം, വേണ്ടപ്പെട്ടവരുടെ വിയോഗം എന്നിവക്ക് മാത്രമേ Emergency leave അനുവദിക്കുകയുള്ളൂ, അല്ലാത്തപക്ഷം 3 ദിവസത്തേക്ക് അക്കൗണ്ട് ബ്ലോക്ക് ആകുന്നതായിരിക്കും."
          //   ,textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
          //   trimMode: TrimMode.Line,
          //   trimLines: 2,
          //   colorClickableText: Colors.pink,
          //   trimCollapsedText: 'Show more',
          //   trimExpandedText: '\t\t\t Show less', ),

          child: Text("🛑 ലീവിന് വേണ്ടിയുള്ള അപേക്ഷ തലേദിവസം 05.00PM നു മുൻപേ 9074884898 എന്ന നമ്പറിൽ \"I Need leave for 01/01/2000 to 01/01/2000\"(Type Reason)  എന്ന് Whatsapp സന്ദേശം അയക്കുക, ശേഷം ലീവ്  അനുവദിച്ചാൽ മാത്രം താഴെ LEAVE APPLY ചെയ്യുക."+
              "\n\n🛑 അത്യാഹിതം, വേണ്ടപ്പെട്ടവരുടെ വിയോഗം എന്നിവക്ക് മാത്രമേ Emergency leave അനുവദിക്കുകയുള്ളൂ, അല്ലാത്തപക്ഷം 3 ദിവസത്തേക്ക് അക്കൗണ്ട് ബ്ലോക്ക് ആകുന്നതായിരിക്കും."
            ,textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
          ),

        ),

          SizedBox(height: 10,),
            buildText(color: Colors.black,text: "Start Date",weight: FontWeight.w600,size: 18.0),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
              height: 50,
              width: width,
              decoration: BoxDecoration(
                  color: cGrey.withOpacity(.5),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * .4,
                    child: TextFormField(
                      onTap: () => _selectDate(context),
                      readOnly: true,
                      controller: _startDate,
                      decoration: const InputDecoration(prefixIcon: Icon(Icons.line_weight_sharp,color: Colors.grey,),
                        hintText: "DD/MM/YYYY",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.grey,width: 10,indent: 5,thickness: 1,),
                  SizedBox(
                    width: width * .3,
                    child: TextFormField(
                      onTap: () => _selectTime(context),
                      controller: _startTime,
                      readOnly: true,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(

                        hintText: /*"12:00 AM"*/"",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  buildText(color: cPrimaryColor,text: "End Date",weight: FontWeight.w600,size: 18.0),
                Expanded(child: SizedBox(),),

                  _startTime.text.isNotEmpty&&_startDate.text.isNotEmpty&&_endTime.text.isNotEmpty&&
                      _endDate.text.isNotEmpty&& _startDate.text== _endDate.text?
                  isLessThan10Hours(end: _endDatepicked!,endTime: _endTimepicked!,start: _startDatepicked!,startTime: _startTimepicked!)?
                  buildText(color: Colors.black,text: "Half  \n Day  ",weight: FontWeight.w600,size: 12.0):

                  _chosenValue==false?      Row(children: [
                 InkWell(
                     onTap: (){
                       setState(() {
                         _chosenValue=true;
                       });

                     },
                     child: buildText(color: cPrimaryColor,text: "$leaveDays\t",weight: FontWeight.w600,size: 35.0)),
                 buildText(color: Colors.black,text: "Days\nSelected",weight: FontWeight.w600,size: 12.0)

               ],)

                      // :SizedBox(),

                  :  Row(children: [
                    DropdownButton<String>(borderRadius: BorderRadius.circular(15),

                      focusColor: Colors.yellow.shade100,
                      elevation: 2,
                      value: leaveDays,
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      underline:  SizedBox(),
                      //elevation: 5,
                      style: TextStyle(color: Colors.white,fontSize: 14),
                      iconEnabledColor:Colors.black,
                   iconSize: 1,
                      alignment: Alignment.center,

                      //itemHeight: 50,
                      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 1),
                      isDense: false,
                      menuMaxHeight: 200,
                      //itemHeight: 80,
                      //itemHeight: 80,
                      items: months.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child:  buildText(color: cPrimaryColor,text: value,weight: FontWeight.w600,size: 35.0),
                        );
                      }).toList(),
                      hint: buildText(color: cPrimaryColor,text: "$leaveDays\t",weight: FontWeight.w600,size: 35.0),
                      onChanged: (String? value) {
                        int selectedMonthIndex = months.indexOf(value!);
                        setState(() {
                          leaveDays = value;
                          _startDatepicked = DateTime.now();
                          _startDate.text = DateFormat('dd/MM/yyyy').format(_startDatepicked!);
                          _endDatepicked = DateTime.now();
                          _endDatepicked = _endDatepicked!.add(Duration(days: int.parse(leaveDays) - 1));
                          _endDate.text = DateFormat('dd/MM/yyyy').format(_endDatepicked!);
                        });
print(_endDate.text);
print(_startDatepicked);


                      },
                    ),
                    buildText(color: Colors.black,text: "Days\nSelected",weight: FontWeight.w600,size: 12.0)

                  ],):Row(children: [
                    DropdownButton<String>(borderRadius: BorderRadius.circular(15),

                      focusColor: Colors.yellow.shade100,
                      elevation: 2,
                      value: leaveDays,
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      underline:  SizedBox(),
                      //elevation: 5,
                      style: TextStyle(color: Colors.white,fontSize: 14),
                      iconEnabledColor:Colors.black,
                      iconSize: 1,
                      alignment: Alignment.center,

                      //itemHeight: 50,
                      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 1),
                      isDense: false,
                      menuMaxHeight: 200,
                      //itemHeight: 80,
                      //itemHeight: 80,
                      items: months.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child:  buildText(color: cPrimaryColor,text: value,weight: FontWeight.w600,size: 35.0),
                        );
                      }).toList(),
                      hint: buildText(color: cPrimaryColor,text: "$leaveDays\t",weight: FontWeight.w600,size: 35.0),
                      onChanged: (String? value) {
                        int selectedMonthIndex = months.indexOf(value!);
                        setState(() {
                          leaveDays = value;
                          _startDatepicked = DateTime.now();
                          _startDate.text = DateFormat('dd/MM/yyyy').format(_startDatepicked!);
                          _endDatepicked = DateTime.now();
                          _endDatepicked = _endDatepicked!.add(Duration(days: int.parse(leaveDays) - 1));
                          _endDate.text = DateFormat('dd/MM/yyyy').format(_endDatepicked!);
                        });
                        print(_endDate.text);
                        print(_startDatepicked);


                      },
                    ),
                    buildText(color: Colors.black,text: "Days\nSelected",weight: FontWeight.w600,size: 12.0)

                  ],)

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
              height: 50,
              width: width,
              decoration: BoxDecoration(
                  color: cGrey.withOpacity(.5),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * .4,
                    child: TextFormField(
                      onTap: () => _selectEndDate(context),
                      readOnly: true,
                   controller: _endDate,
                      decoration: const InputDecoration(prefixIcon: Icon(Icons.line_weight_sharp,color: Colors.grey,),
                        hintText: "DD/MM/YYYY",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.grey,width: 10,indent: 5,thickness: 1,),
                  SizedBox(
                    width: width * .3,
                    child: TextFormField(
                      onTap: () => _selectEndTime(context),
                      controller: _endTime,
                      readOnly: true,
                      decoration: const InputDecoration(

                        hintText: /*"11:59 PM"*/"",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),

                ],
              ),
            ),
           SizedBox(height: 20,),
           Obx(() =>  InkWell(
              onTap: _startDate.text.isNotEmpty&&_endDate.text.isNotEmpty&&_startTime.text.isNotEmpty&&
                  _endTime.text.isNotEmpty? () {
                //print("_startDate=>${_startDate.text}=>_endDate=>${_endDate.text}==>$driverId=>${_startTime.text}=>${_endTime.text}");


                //print(DateFormat("HH:mm:ss").parse());

                print(convertTimeOfDayToString(_startTimepicked!));

                print( _startDate.text);
                print( _endDate.text);
                print( _startTime.text);
                print( _endTime.text);



                // Get.offAll(MoreDetailsScreen());
                print("widget id-----${widget.driverId}");

                applyLeaveApi(
                    widget.driverId,
                    convertToFormattedDateTime(_startDate.text),
                    convertToFormattedDateTime(_endDate.text),

                    convertTimeOfDayToString(_startTimepicked!),
                    convertTimeOfDayToString(_endTimepicked!),
                    leaveDays
                );


              } : (){
                    ToastUtil.show("Please choose date and time");


                //startTrip();
              },
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: cPrimaryColor,
                ),
                child:  Center(
                  child:isLoading.value? CircularProgressIndicator() :Text(
                    "Confirm Leave",
                    style: TextStyle(
                      fontSize: 22,fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),)



        
        ],),
      
      ),
    );
  }


  RxBool isLoading = false.obs;


  Future applyLeaveApi(driverId,fromDate,toDate,fromTime,toTime,days) async {
    try {
      isLoading.value = true;
      final String apiUrl = Urls.driverLeaveApplyUrl;
      final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            // "Content-Type": "application/json",

          },
          body: {
            "driver_id":driverId,
            "from_date":fromDate,
            "to_date":toDate,
            "from_time":fromTime,
            "to_time":toTime,
            "days":days,
          }
      );
      var data = jsonDecode(response.body);

      if(response.statusCode == 200){
        isLoading.value = false;

        ToastUtil.show("${data['msg']}");
        // NetworkHelper().appliedLeaveAPI(context: context)
        DriverLeaveApplyModel.fromJson(jsonDecode(response.body));


        setState(() {
          NetworkHelper().appliedLeaveAPI(context: context,driverId: widget.driverId.toString());

        });

        Navigator.pop(context, 'First Item');




      } else {
        isLoading.value = false;

        ToastUtil.show("Server Error Please try After sometime");
        debugPrint(response.body);
        return null;
      }
    } catch (e) {
      print("Error-------$e");
      isLoading.value = false;

    }
  }


  Text buildText({text, color, size, weight}) {
    return Text(text, style: TextStyle(
                fontSize: size,color: color,
                fontWeight: weight),);
  }
}
