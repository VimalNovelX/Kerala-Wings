import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kerala_wings/data/api_services.dart';

import '../../../../data/models/tarrif_model.dart';
import '../../../constants/colors.dart';

class TarrifPage extends StatefulWidget {
  final String? driverId;
  const TarrifPage({super.key, this.driverId});

  @override
  State<TarrifPage> createState() => _TarrifPageState();
}

class _TarrifPageState extends State<TarrifPage> {
  
  
  Future<DriverTariffModel?>? driverTariffModel;
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    driverTariffModel = NetworkHelper().driverTariffAPI(context: context);
  }
  
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Container(

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          DottedLine(
            dashColor: cFont.withOpacity(.5),
          ),

         FutureBuilder(
              future: driverTariffModel,
              builder: (context, AsyncSnapshot<DriverTariffModel?>snapshot) {
                if(snapshot.hasData){
                  return Expanded(
                    child: ListView(
                      shrinkWrap: true,

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network('${snapshot.data!.data!.tarif1}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network('${snapshot.data!.data!.tarif2}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network('${snapshot.data!.data!.tarif3}'),
                        ),

                      ],

                    ),
                  );
                }else if(snapshot.connectionState==ConnectionState.waiting){

                  return Center(child: CircularProgressIndicator(),);

                }else {
                  return Center(child: Text("Please Try Again!!!"),);
                }
              }
          )



        ],),
      ),


    ));
  }
}
