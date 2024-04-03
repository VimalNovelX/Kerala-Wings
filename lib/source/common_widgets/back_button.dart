import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kerala_wings/source/constants/colors.dart';
import 'package:kerala_wings/source/constants/images.dart';

class CustomBackButton extends StatelessWidget {
  final onTap;
  const CustomBackButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: cGrey.withOpacity(.5),
        radius: 20,
        child: SvgPicture.asset(iBackIcons),
      ),
    );
  }
}
