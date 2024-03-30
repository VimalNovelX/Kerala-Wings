import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerala_wings/source/common_widgets/back_button.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     CustomBackButton(
                       onTap: (){},
                     ),
                     SizedBox(height: 20,),
                     RichText(text: TextSpan(
                       text: "Set up Your\n",
                       style: TextStyle(
                         color: cFont,
                         fontSize:30,
                         fontWeight: FontWeight.bold
                       ),
                       children: [
                         TextSpan(
                           text: "Profile",
                           style: TextStyle(
                             color: cPrimaryColor
                           )
                         )
                       ]
                     ),
                     ),

                   ],
                 ),
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: cGrey,
                    child: SvgPicture.asset(iProfile)
                  )
                ],
              ),
              SizedBox(height: 10,),

              Text(
                "Create Your profile to drive for Kerala Wings",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400
                ),
              ),
              SizedBox(height: 10,),

              DottedLine(
                dashColor: Colors.grey.shade400
              ),
              SizedBox(height: 10,),

              selectionRow(
                color: cPrimaryColor,
                title: "Driver",
                index: "Driver"
              ),


            ],
          ),
        ),
      ),
    );
  }

  InkWell selectionRow({index, title,color}) {
    return InkWell(
      onTap: (){
        index = index;
      },

      child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey.shade400,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: color,
                    ),
                  ),
                  SizedBox(width: 7,),
                  Text(
                      title,
                    style: TextStyle(
                      fontSize: 16,
                      color: cPrimaryColor,
                      fontWeight: FontWeight.w600
                    ),
                  )
                ],
              ),
    );
  }
}
