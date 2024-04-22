import 'package:flutter/cupertino.dart';

import '../data/api_services.dart';
import '../data/models/leave_history_model.dart';
import '../utils/constants.dart';

class UpdateLeaveProvider extends  ChangeNotifier{

  Future<LeaveHistoryModel?>? leaveHistoryModel;


  getLeaveHistory({selectedYear,selectedMonth,context}){

    leaveHistoryModel=    NetworkHelper().leaveHistoryAPI(context: context,year:selectedYear.toString(),month: selectedMonth.toString(),driverId: driverId );

    return leaveHistoryModel;
  }


}