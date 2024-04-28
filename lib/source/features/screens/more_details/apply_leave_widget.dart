import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kerala_wings/data/models/driver_leave_apply_model.dart';
import 'package:kerala_wings/utils/constants.dart';
import 'package:kerala_wings/utils/toastUtil.dart';
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
   String? leaveDays;
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


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    _startTime.text =  TimeOfDay(hour: 0, minute: 0).format(context);
    _startTimepicked=  TimeOfDay(hour: 0, minute: 0);
_endTimepicked=TimeOfDay(hour: 11, minute: 59);
    _endTime.text = TimeOfDay(hour: 11, minute: 59).format(context);
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
                      decoration: const InputDecoration(

                        hintText: "12:00 AM",
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
            Row(
              children: [
                buildText(color: cPrimaryColor,text: "End Date",weight: FontWeight.w600,size: 18.0),
              Expanded(child: SizedBox(),),

                _startTime.text.isNotEmpty&&_startDate.text.isNotEmpty&&_endTime.text.isNotEmpty&&
                    _endDate.text.isNotEmpty?
                isLessThan10Hours(end: _endDatepicked!,endTime: _endTimepicked!,start: _startDatepicked!,startTime: _startTimepicked!)?
                buildText(color: Colors.black,text: "Half  \n Day  ",weight: FontWeight.w600,size: 12.0):

             Row(children: [
               buildText(color: cPrimaryColor,text: "$leaveDays\t",weight: FontWeight.w600,size: 35.0),
               buildText(color: Colors.black,text: "Days\nSelected",weight: FontWeight.w600,size: 12.0)

             ],):SizedBox(),
        
              ],
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

                        hintText: "11:59 PM",
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
            SizedBox(
              height: 60,
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        //print("_startDate=>${_startDate.text}=>_endDate=>${_endDate.text}==>$driverId=>${_startTime.text}=>${_endTime.text}");


                        //print(DateFormat("HH:mm:ss").parse());

                        print(convertTimeOfDayToString(_startTimepicked!));

                        print( _startDate.text);
                        print( _endDate.text);
                        print( _startTime.text);
                        print( _endTime.text);

                        _startDate.text.isNotEmpty&&_endDate.text.isNotEmpty&&_startTime.text.isNotEmpty&&
                            _endTime.text.isNotEmpty?
                        applyLeave(toDate:convertToFormattedDateTime(_endDate.text),
                        fromDate:convertToFormattedDateTime(_startDate.text),
                            fromTime: convertTimeOfDayToString(_startTimepicked!),
                            toTime:convertTimeOfDayToString(_endTimepicked!),
                            driverId: widget.driverId,
                          days: leaveDays
                        ):ToastUtil.show("Please choose date and time");

                        Navigator.pop(context);
                        //startTrip();
                      },
                      child: Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: cPrimaryColor,
                        ),
                        child: const Center(
                          child: Text(
                            "Confirm Leave",
                            style: TextStyle(
                              fontSize: 22,fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),



        
        ],),
      
      ),
    );
  }

  Text buildText({text, color, size, weight}) {
    return Text(text, style: TextStyle(
                fontSize: size,color: color,
                fontWeight: weight),);
  }
}
