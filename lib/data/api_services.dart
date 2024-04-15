import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:kerala_wings/data/models/driver_register.dart';
import 'package:kerala_wings/data/models/otp_model.dart';
import 'package:kerala_wings/utils/constants.dart';
import '../utils/toastUtil.dart';
import '../utils/urls.dart';
import 'models/driver_view_trip_model.dart';
import 'models/questions_model.dart';



class NetworkHelper{


  // Future login({required BuildContext context, required String email,required String password}) async {
  //   http.Response? response;
  //
  //   if (await SharedPrefUtil.contains(keyAccessToken)) {
  //     await SharedPrefUtil.delete(keyAccessToken);
  //   }
  //
  //   response = await _postRequest(
  //       context: context,
  //       url: "${Urls.loginUrl}",
  //       header: {
  //         "Content-Type": "application/json",
  //         "api-key":"fb7fb2cb-d0da-444d-bd92-20f0e947b132"
  //
  //         //"Content-Type": "multipart/form-data",
  //       },body: {
  //     "email": email,
  //     "password": password
  //   });
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   }
  //   else if(response.statusCode == 401) {
  //     ToastUtil.show("Username or Password doesn't exist");
  //     debugPrint(response.body);
  //   }
  //   else {
  //     ToastUtil.show("Server Error Please try After sometime ${response.statusCode}");
  //     debugPrint(response.body);
  //   }
  // }

  // Future signUp({required BuildContext context, required String email,required String password,required String name,required String phone}) async {
  //   http.Response? response;
  //
  //   if (await SharedPrefUtil.contains(keyAccessToken)) {
  //     await SharedPrefUtil.delete(keyAccessToken);
  //   }
  //
  //   response = await _postRequest(
  //       context: context,
  //       url: "${Urls.signUpUrl}",
  //       header: {
  //         "Content-Type": "application/json",
  //         "api-key":"fb7fb2cb-d0da-444d-bd92-20f0e947b132"
  //
  //         //"Content-Type": "multipart/form-data",
  //       },body: {
  //     "name":name,
  //     "phone":phone,
  //     "email": email,
  //     "password": password,
  //   });
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   }
  //   else if(response.statusCode == 401) {
  //     ToastUtil.show("Username or Password doesn't exist");
  //     debugPrint(response.body);
  //   }
  //   else {
  //     ToastUtil.show("Server Error Please try After sometime ${response.statusCode}");
  //     debugPrint(response.body);
  //   }
  // }

  // //all_issues_api
  Future<OtpModel?> getOtp(
      {required BuildContext context,phone}) async {
    http.Response? response;
    response = await _getRequest(context: context, url: "${Urls.otpUrl}?phone=$phone",header: {
      "Content-Type": "application/json",
      "api-key":"a4690239-5216-4974-87f6-1588153d7a20"

      // "Authorization": "Bearer $token"
    }, );
    /*_postRequest(
      context: context,
      url: "${Urls.getAllIssuesUrl}",
      header: {
        "Content-Type": "application/json",
        // "Authorization": "Bearer $token"
      }, body: {},);*/
    if (response!.statusCode == 200) {
      var data = jsonDecode(response.body);
      if(data['data']['driver']!=null){
        drivercode = data['data']['driver']['code'];
        name = data['data']['driver']['f_name'];
        driverPhone = data['data']['driver']['phone'];
        driverType = data['data']['driver']['type'];
      }
      return OtpModel.fromJson(jsonDecode(response.body));
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
      return null;
    }
  }
   //get_question_api
  Future<QuestionsModel?> getQuestions(
      {required BuildContext context,phone}) async {
    http.Response? response;
    response = await _postRequest(context: context, url: Urls.getQuestionsUrl,header: {
      "Content-Type": "application/json",
      "api-key":"a4690239-5216-4974-87f6-1588153d7a20"

      // "Authorization": "Bearer $token"
    }, body: {
    "name":"questions",
      "where":"driver_type",
      "value":"cd"


    }, );
    /*_postRequest(
      context: context,
      url: "${Urls.getAllIssuesUrl}",
      header: {
        "Content-Type": "application/json",
        // "Authorization": "Bearer $token"
      }, body: {},);*/
    if (response!.statusCode == 200) {
      return QuestionsModel.fromJson(jsonDecode(response.body));
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
      return null;
    }
  }



  // //magazine_api
  // Future<MagazineModel?> getMagazineApi(
  //     {required BuildContext context}) async {
  //   http.Response? response;
  //   response = await _getRequest(context: context, url: "${Urls.getMagazineUrl}",header: {
  //     "Content-Type": "application/json",
  //     "api-key":"fb7fb2cb-d0da-444d-bd92-20f0e947b132"
  //
  //     // "Authorization": "Bearer $token"
  //   }, );
  //   /*_postRequest(
  //     context: context,
  //     url: "${Urls.getAllIssuesUrl}",
  //     header: {
  //       "Content-Type": "application/json",
  //       // "Authorization": "Bearer $token"!
  //     }, body: {},);*/
  //   if (response!.statusCode == 200) {
  //     return MagazineModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     ToastUtil.show("Server Error Please try After sometime");
  //     debugPrint(response.body);
  //     return null;
  //   }
  // }
  //
  //



//class_division_dropdown
  Future<DriverRegisterModel?> driverRegisterApi(
      {required BuildContext context,f_name,phone,
        driverType,address,licenceNo,dob,licenceExp,
        salaryType,districts,adhaarNo,hPhone,
        activeLocation,required File frontLicence,required File backLicence,
        profile,bloodGroup,qus,father
      }) async {
    http.Response? response;
    response = await _postRequest(
      context: context,
      url: "${Urls.driverRegisterUrl}",
      header: {
        "Content-Type": "application/json",
        // "Authorization": "Bearer $token"
      }, body: {
    "f_name":f_name,
    "phone":phone,
    "driver_type":driverType,
    "address":address,
    "licence_no":licenceNo,
    "dob":dob,
    "licence_exp":licenceExp,
    "salary_type":salaryType,
    "districts":districts,
    "adhaar_no":adhaarNo,
    "h_phone":hPhone,
    "active_location":activeLocation,
    "front_licence":base64Encode(frontLicence.readAsBytesSync()),
    "back_licence":base64Encode(backLicence.readAsBytesSync()),
    "profile":profile,
    "blood_group":bloodGroup,
    "qus":jsonEncode(qus),
  //"qus":{"2":"yes","3":"no","4":"no","5":"yes","7":"yes"},
    "father":father,
 },);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ToastUtil.show("${data['msg']}");

      return DriverRegisterModel.fromJson(jsonDecode(response.body));
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
      return null;
    }
  }


  Future<DriverViewTripDetailsModel?> driverViewTripDetailsApi(
      {required BuildContext context,driver_id, type
      }) async {
    http.Response? response;
    response = await _postRequest(
      context: context,
      url: "${Urls.driverViewTripDetailsUrl}",
      header: {
        "Content-Type": "application/json",
        // "Authorization": "Bearer $token"
      }, body: {
    "driver_id":driver_id.toString(),
      "type":type
 },);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ToastUtil.show("${data['msg']}");

      return DriverViewTripDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
      return null;
    }
  }
 Future<DriverViewTripDetailsModel?> startDriverTripApi(
      {required BuildContext context,bookingId, tripStartBy
      }) async {
    http.Response? response;
    response = await _postRequest(
      context: context,
      url: "${Urls.startDriverTripUrl}",
      header: {
        "Content-Type": "application/json",
        // "Authorization": "Bearer $token"
      }, body: {
    "booking_id":bookingId.toString(),
      "trip_start_by":tripStartBy
 },);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ToastUtil.show("${data['msg']}");

      return DriverViewTripDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
      return null;
    }
  }



 Future<DriverRegisterModel?> driversRegisterApi(
      {required BuildContext context,f_name,phone,
        driverType,address,licenceNo,dob,licenceExp,
        salaryType,districts,adhaarNo,hPhone,
        activeLocation,frontLicence,backLicence,
        profile,bloodGroup,qus,father
      }) async {
    http.Response? response;
    response = await _multiPartPostRequest(
      context: context,
      url: "${Urls.driverRegisterUrl}",
      header: {
        "Content-Type": "application/json",
        // "Authorization": "Bearer $token"
      }, body: {
    "f_name":f_name,
    "phone":phone,
    "driver_type":driverType,
    "address":address,
    "licence_no":licenceNo,
    "dob":dob,
    "licence_exp":licenceExp,
    "salary_type":salaryType,
    "districts":districts,
    "adhaar_no":adhaarNo,
    "h_phone":hPhone,
    "active_location":activeLocation,
    "front_licence":frontLicence,
    "back_licence":backLicence,
    "profile":profile,
    "blood_group":bloodGroup,
    "qus":"",
   // "qus":{"2":"yes","3":"no","4":"no","5":"yes","7":"yes"},
    "father":father,
 }, fileList: [],);
    if (response.statusCode == 200) {
      return DriverRegisterModel.fromJson(jsonDecode(response.body));
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
      return null;
    }
  }


//
// //class_student_list
//   Future<StudentListModel?> classStudentList(
//       {required BuildContext context,className, section}) async {
//     http.Response? response;
//     response = await _postRequest(
//       context: context,
//       url: "${Urls.getStudentListUrl}",
//       header: {
//         "Content-Type": "application/json",
//         // "Authorization": "Bearer $token"
//       }, body: {"class":className,
//       "section":section},);
//     if (response.statusCode == 200) {
//       return StudentListModel.fromJson(jsonDecode(response.body));
//     } else {
//       ToastUtil.show("Server Error Please try After sometime");
//       debugPrint(response.body);
//       return null;
//     }
//   }
//
// //present Students List
//
//   Future<PresentStudentsModel?> presentStudentList(
//       {required BuildContext context,className, section}) async {
//     http.Response? response;
//     response = await _postRequest(
//       context: context,
//       url: "${Urls.viewPresentUrl}",
//       header: {
//         "Content-Type": "application/json",
//         // "Authorization": "Bearer $token"
//       }, body: {"class":className,
//       "section":section,"date":"2023-06-20",
//       "period": "P1"},);
//     if (response.statusCode == 200) {
//       return PresentStudentsModel.fromJson(jsonDecode(response.body));
//     } else {
//       ToastUtil.show("Server Error Please try After sometime");
//       debugPrint(response.body);
//       return null;
//     }
//   }
//
//
//
// //present Students List
//
//   Future<AbsentStudentsModel?> absentStudentsApi(
//       {required BuildContext context,className, section, date}) async {
//     http.Response? response;
//     response = await _postRequest(
//       context: context,
//       url: "${Urls.viewAbsentUrl}",
//       header: {
//         "Content-Type": "application/json",
//         // "Authorization": "Bearer $token"
//       }, body: {"class":className,
//       "date":"2023-06-20",
//       "section":section,
//       "period": "P2"},);
//     if (response.statusCode == 200) {
//       return AbsentStudentsModel.fromJson(jsonDecode(response.body));
//     } else {
//       ToastUtil.show("Server Error Please try After sometime");
//       debugPrint(response.body);
//       return null;
//     }
//   }
//
//
// //submit attendance
//
//   PeriodAttendanceModel? retrieveAttendanceData;
//
//   Future<SubmitAttendModel?> submitAttendanceApi(
//       {required BuildContext context,className, section,date, }) async {
//     http.Response? response;
//     response = await _postRequest(
//       context: context,
//       url: "${Urls.submitAttendanceUrl}",
//       header: {
//         "Content-Type": "application/json",
//         // "Authorization": "Bearer $token"
//       }, body: {
//       "AttDate":"2023-06-20",
//       "class":className,
//       "Sec":section,"attendance":jsonEncode(retrieveAttendanceData!.attendance),
//       //"attendance":jsonEncode({"STU20": "Present", "STU21": "Absent"}),
//       "Period":"P1"
//
//
//     },);
//     if (response.statusCode == 200) {
//       return SubmitAttendModel.fromJson(jsonDecode(response.body));
//     } else {
//       ToastUtil.show("Server Error Please try After sometime");
//       debugPrint(response.body);
//       return null;
//     }
//   }



}
Future<http.Response?> _getRequest({
  required BuildContext context,
  required String url,
  Map<String, String>? header,
}) async {
  http.Response? response;

  try {
    response = await http.get(Uri.parse(url), headers: header ?? {});
    debugPrint("$url---$header-->${response.body}");
  } on SocketException {
    ToastUtil.show("Please check your internet connection");
  } catch (e) {
    ToastUtil.show(e.toString());
    // rethrow;
  }
  return response;
}

Future<http.Response> _postRequest({
  required BuildContext context,
  required String url,
  required Map<String, String> body,
  Map<String, String>? header,
}) async {
  late http.Response response;

  try {
    response = await http.post(Uri.parse(url),
        body: jsonEncode(body), headers: header);
    debugPrint("$url--$header--$body--->${response.body}");
  } on SocketException {
    ToastUtil.show("Please check your internet connection");
  } catch (e) {
    rethrow;
  }
  return response;
}

Future<http.Response> _multiPartPostRequest(
    {required BuildContext context,
      required String url,
      required Map<String, String> body,
      required Map<String, String> header,
      required List<http.MultipartFile> fileList}) async {
  http.Response response;
  http.MultipartRequest request;
  try {
    request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers.addAll(header)
      ..fields.addAll(body)
      ..files.addAll(fileList);
    response = await http.Response.fromStream(await request.send());
    debugPrint("$url------->${response.body}");
  } catch (e) {
    debugPrint("$url------->$e");
    rethrow;
  }
  return response;
}

//
// Future uploadFilesData({
//   var formData,
//   required String url,
//   required BuildContext context,
//   required Map<String, String> header,
// }) async {
//   // FormData data = FormData.fromMap(formData);
//   Dio dio = Dio();
//   dio.options.headers = header;
//   var response = await dio
//       .post(
//     url,
//     data: formData,
//   )
//       .catchError((error) {
//     debugPrint(error.toString());
//   });
//   return response.data;
// }
