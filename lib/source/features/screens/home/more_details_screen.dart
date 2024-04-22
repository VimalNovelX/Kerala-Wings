import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kerala_wings/source/features/screens/more_details/terms_n_condition_page.dart';
import 'package:kerala_wings/utils/constants.dart';

import '../../../common_widgets/back_button.dart';
import '../../../constants/colors.dart';
import '../more_details/leave_page.dart';
import '../more_details/tarrif_page.dart';
import 'home_screen.dart';

class MoreDetailsScreen extends StatefulWidget {
  final String? driverId;
  const MoreDetailsScreen({super.key, this.driverId});

  @override
  State<MoreDetailsScreen> createState() => _MoreDetailsScreenState();
}

class _MoreDetailsScreenState extends State<MoreDetailsScreen> {
  final MyController controller = Get.put(MyController());
  TabController? _tabController;
  List tabs = ["Leave","Tarrif","Payment","Terms And Conditions"];
  @override
  Widget build(BuildContext context) {

    return  DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomBackButton(
              onTap: (){
                Get.back();
              },
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin:
              const EdgeInsets.only(top: 15, bottom: 15, right: 15),
              decoration: BoxDecoration(
                  color: cPrimaryColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                  child: buildRichText(
                      "MORE ", " INFORMATION", 12, Colors.white,
                      cPrimaryColor
                  )),
            )
          ],
        ),
        body:  SafeArea(
          child: Column(children: [
           Expanded(
             flex: 1,
             child:

           TabBar(
             labelPadding: EdgeInsets.only(right: 15),
             onTap: (index) {
               controller.updateSelectedIndex(index);
               //
               // setState(() {
               //   index==1?tripType="assigned":index==2?tripType="live":tripType="";
               // });
               // print("$tripType--$index");
               // tripDetail(tripType);
             },
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
                   (index) => Obx(
                     () => Container(
                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(20),
                     border: Border.all(
                       color: controller.selectedIndex.value == index
                           ? cDarkBlue
                           : Colors.transparent,
                       width: 1.5,
                     ),
                   ),
                   child: Center(
                     child: Text(tabs[index]),
                   ),
                 ),
               ),
             ),
           ),),
           Expanded(flex: 15,
           child:  TabBarView(

               physics: const NeverScrollableScrollPhysics(),

               children: [
             LeaveScreen(driverId:widget.driverId.toString()),
             TarrifPage(driverId:widget.driverId.toString()),
             PaymentTab(driverId:widget.driverId.toString()),
             TermsNConditions(driverId:widget.driverId.toString()),


           ]),
           )
          ],),
        ),


      ),
    );
  }
  RichText buildRichText(String text1, String text2, double size, color,color1) {
    return RichText(
      text: TextSpan(
          text: text1,
          style: TextStyle(
              color: color1,
              fontWeight: FontWeight.w600,
              fontSize: size),
          children: [
            TextSpan(
              text: text2,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: size),
            )
          ]),
    );
  }

}

class PaymentTab extends StatelessWidget {
  final String? driverId;
  const PaymentTab({super.key, this.driverId});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DottedLine(
          dashColor: cFont.withOpacity(.5),
        ),
      Center(
      child: Container(
      width: 300,
      height: 300,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/images/qrCode.jpeg')),
      border: Border.all(color: Colors.black26,width: .5),
      borderRadius: BorderRadius.circular(15)),

      ),
      ),
      DottedLine(
      dashColor: cFont.withOpacity(.5),
      ),
      SizedBox(height: 10,),
      Text("keralawingstvm-5@oksbi", style: TextStyle(color:cPrimaryColor,fontSize: 22,fontWeight: FontWeight.w600 ),),
      SizedBox(height: 5,),

      Text("UPI NO: 9747 055 599", style: TextStyle(color:Colors.grey.shade400,fontSize: 22,fontWeight: FontWeight.w600 ),),
        DottedLine(
          dashColor: cFont.withOpacity(.5),
        ),SizedBox(height: 5,),
        Text("Driver Contact: 907 488 4898", style: TextStyle(color:Colors.grey.shade400,fontSize: 22,fontWeight: FontWeight.w600 ),),
        SizedBox(height: 5,),
        DottedLine(
          dashColor: cFont.withOpacity(.5),
        ),
        SizedBox(height: 5,),
        buildRow(phone: "0471 255 5599"),
        buildRow(phone: "9747 055 599"),
        buildRow(phone: "9037 502 502"),
        buildRow(phone: "9037 375 353"),
      ],),
    );
  }

  Padding buildRow({phone}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset('assets/png/phone.png'),
        SizedBox(width: 10),
        Text(phone, style: TextStyle(fontSize: 18),)

      ],),
    );
  }
}
