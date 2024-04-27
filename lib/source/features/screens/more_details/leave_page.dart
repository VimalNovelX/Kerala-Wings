import 'dart:developer';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kerala_wings/data/api_services.dart';
import 'package:kerala_wings/data/models/leave_history_model.dart';
import 'package:lottie/lottie.dart';
import '../../../../data/models/applied_leave_model.dart';
import '../../../constants/colors.dart';
import 'apply_leave_widget.dart';

class LeaveScreen extends StatefulWidget {
  final String? driverId;
  const LeaveScreen({super.key, this.driverId});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _showDatePickerDialog() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;

      });
      final String selectedMonth = DateFormat('MM').format(_selectedDate);
      final String selectedYear = DateFormat('yyyy').format(_selectedDate);
      getLeaveHistory(selectedMonth:selectedMonth,selectedYear: selectedYear );
    }
  }

  Future<AppliedLeaveModel?>? currentLeaveHistoryModel;
  Future<LeaveHistoryModel?>? leaveHistoryModel;




  getLeaveHistory({selectedYear,selectedMonth}){

    leaveHistoryModel=    NetworkHelper().leaveHistoryAPI(context: context,year:selectedYear.toString(),month: selectedMonth.toString(),driverId: widget.driverId );

    return leaveHistoryModel;
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     leaveHistoryModel = NetworkHelper().leaveHistoryAPI(context: context,driverId: widget.driverId,month: DateTime.now().month,year: DateTime.now().year);
    currentLeaveHistoryModel=    NetworkHelper().appliedLeaveAPI(context: context,driverId: widget.driverId );

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  SizedBox(

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [

            DottedLine(
              dashColor: cFont.withOpacity(.5),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Applied Leave",
                    style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w600,fontSize: 22),
                  )),
            ),

            SizedBox(height: 10,),



            SizedBox(
              height:  size.height*.25,
              child: FutureBuilder(
                future: currentLeaveHistoryModel,
                builder: (context, AsyncSnapshot<AppliedLeaveModel?> snapshot) {
                 if(snapshot.hasData){
                if( snapshot.data!.data!.length==0){
                    return  Center(child: Column(
                      children: [
                        Lottie.asset('assets/json/noLeave.json'),
                        Text("No Leaves Yet")
                      ],
                    ));}
                else{ return  ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  shrinkWrap: true,

                  itemBuilder: (BuildContext context, int index){

                  return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: const ColoredBox(
                  color: Colors.red,
                  child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.delete, color: Colors.white),
                  ),
                  ),
                  ),
                  onDismissed: (DismissDirection direction) {
                  log('Dismissed with direction $direction');
                  // Your deletion logic goes here.
                  },
                  confirmDismiss: (DismissDirection direction) async {
                  final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                  return AlertDialog(
                  title: const Text('Are you sure you want to delete?'),
                  actions: [
                  TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('No'),
                  ),
                  TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Yes'),
                  )
                  ],
                  );
                  },
                  );
                  log('Deletion confirmed: $confirmed');
                  return confirmed;
                  },
                  child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),

                  decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30)),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(snapshot.data!.data![index].days.toString(), style: TextStyle(fontSize:18,fontWeight: FontWeight.w500,color: Colors.blue),),
                  SizedBox(height: 40,
                  child:  VerticalDivider(
                  indent:5,
                  endIndent: 2,
                  thickness: 2,
                  color: Colors.red,
                  width: 10,
                  ),),
                  Column(children: [
                  Text(
                  "${DateFormat('dd MMM yy').format(DateTime.parse(snapshot.data!.data![index].fromDateTime!)).toUpperCase()} - ${DateFormat('dd MMM yy').format(DateTime.parse(snapshot.data!.data![index].toDateTime!)).toUpperCase()}",
                  style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                  ),
                  ),

                  Container(
                  padding: EdgeInsets.all(2),

                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
                  child: RichText(text:
                  TextSpan(text: " Requested: ", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue),
                  children: [TextSpan(text: "${DateFormat('dd MMM yy').format(DateTime.parse(snapshot.data!.data![index].createdAt!)).toUpperCase()} | ${DateFormat('hh:mm a').format(DateTime.parse(snapshot.data!.data![index].createdAt!)).toUpperCase()}",style: TextStyle(color: Colors.yellow.shade700)),]),),

                  )

                  ],)

                  ],),

                  ),
                  );

                  });}

                 }
                 else if(snapshot.connectionState ==ConnectionState.waiting){
                   return Center(child: CircularProgressIndicator(),);
                 } else{
                   return Center(child: Text(" No data"),);
                 }

                }
              ),
            ),
            Spacer(flex: 1,),

            DottedLine(
              dashColor: cFont.withOpacity(.5),
            ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text("Leave History",
              style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w600,fontSize: 22),
              )),
        ),


        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap:  () {
              _showDatePickerDialog();

        print("Selected Month: ${_selectedDate.month}");
        } ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(

                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                        DateFormat('MMMM').format(_selectedDate),
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 15)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(

                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${_selectedDate.year}",
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 15)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

            SizedBox(
              height:  size.height*.3,

              child: FutureBuilder(
                  future: leaveHistoryModel,
                  builder: (context, AsyncSnapshot<LeaveHistoryModel?> snapshot) {
                    if(snapshot.hasData){
                      if( snapshot.data!.data!.length==0){
                        return  Center(child: Column(
                          children: [
                            Lottie.asset('assets/json/noLeave.json'),
                            Text("No Leaves Yet")
                          ],
                        ));}
                      else{ return  ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          shrinkWrap: true,

                          itemBuilder: (BuildContext context, int index){

                            return Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),

                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data!.data![index].days.toString(), style: TextStyle(fontSize:18,fontWeight: FontWeight.w500,color: Colors.blue),),
                                  SizedBox(height: 40,
                                    child:  VerticalDivider(
                                      indent:5,
                                      endIndent: 2,
                                      thickness: 2,
                                      color: Colors.red,
                                      width: 10,
                                    ),),
                                  Column(children: [
                                    Text(
                                      "${DateFormat('dd MMM yy').format(DateTime.parse(snapshot.data!.data![index].fromDateTime!)).toUpperCase()} - ${DateFormat('dd MMM yy').format(DateTime.parse(snapshot.data!.data![index].toDateTime!)).toUpperCase()}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    Container(
                                      padding: EdgeInsets.all(2),

                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30)),
                                      child: RichText(text:
                                      TextSpan(text: " Requested: ", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue),
                                          children: [TextSpan(text: "${DateFormat('dd MMM yy').format(DateTime.parse(snapshot.data!.data![index].createdAt!)).toUpperCase()} | ${DateFormat('hh:mm a').format(DateTime.parse(snapshot.data!.data![index].createdAt!)).toUpperCase()}",style: TextStyle(color: Colors.yellow.shade700)),]),),

                                    )

                                  ],)

                                ],),

                            );

                          });}

                    }
                    else if(snapshot.connectionState ==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    } else{
                      return Center(child: Text(" No data"),);
                    }

                  }
              ),
            ),
            Spacer(flex: 1,),

            SizedBox(
              height: 60,
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.bottomSheet(ApplyLeaveWidget(driverId:widget.driverId));
                       // startTrip();
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
                            "Apply Leave",
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

      ),
    );
  }
}
