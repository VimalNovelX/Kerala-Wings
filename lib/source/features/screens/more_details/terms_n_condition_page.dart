import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kerala_wings/data/api_services.dart';


import '../../../../data/models/driver_terms_n_conditions.dart';
import '../../../constants/colors.dart';

class TermsNConditions extends StatefulWidget {
  final String? driverId;
  const TermsNConditions({super.key, this.driverId});

  @override
  State<TermsNConditions> createState() => _TermsNConditionsState();
}

class _TermsNConditionsState extends State<TermsNConditions> {
  bool _isEnglish =true;
  bool _isMal =false;

  Future<DriverTermsNConditionModel?>? driverTermsNConditionModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    driverTermsNConditionModel = NetworkHelper().driverTermsNConditionAPI(context: context);
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  SafeArea(child: Container(

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          DottedLine(
            dashColor: cFont.withOpacity(.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            InkWell(
                onTap: (){
                  setState(() {_isEnglish=true;
                    _isMal=false;
                  });
                },
                child: buildContainer(text: "English",boolean: _isEnglish)),
            InkWell(
                onTap: (){
                  setState(() {_isEnglish=false;
                  _isMal=true;
                  });
                },

                child: buildContainer(text:"Malayalam",boolean: _isMal )),


          ],),

     SizedBox(

       height: size.height- size.height*.3,
       child:  FutureBuilder(
           future: driverTermsNConditionModel,
           builder: (context, AsyncSnapshot<DriverTermsNConditionModel?>snapshot) {
             if(snapshot.hasData){
               return ListView.builder(

                   itemCount: _isEnglish?snapshot.data!.data!.english!.length:snapshot.data!.data!.malayalam!.length,
                   shrinkWrap: true,
                   itemBuilder: (context, int index){
                     return   Padding(
                       padding: const EdgeInsets.all(4.0),
                       child: Text(_isEnglish?"${index+1}). "+snapshot.data!.data!.english![index].termsAndCondition.toString():"${index+1}). "+snapshot.data!.data!.malayalam![index].termsAndCondition.toString(),
                       textAlign: TextAlign.justify,

                       ),
                     );

                   });
             }else if(snapshot.connectionState==ConnectionState.waiting){

               return Center(child: CircularProgressIndicator(),);

             }else {
               return Center(child: Text("Please Try Again!!!"),);
             }
           }
       ),
     )




        ],),
      ),


    ));
  }

  Container buildContainer({text,boolean}) {
    return Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            decoration: BoxDecoration(
              color: boolean?cPrimaryColor.withOpacity(.3):Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
          child: Center(child: Text(text, style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.w600,
              color: boolean?cPrimaryColor:Colors.grey),),),);
  }
}
