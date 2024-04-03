
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:kerala_wings/source/constants/colors.dart';


class CustomDropDown extends StatelessWidget {
  final String  hintText;
  final onChanged;
  final value;
  final validator;
  final items;
  final color;
  final textClr;

  const CustomDropDown(
      {Key? key,this.value, required this. hintText, this.validator,required this.onChanged, this.items, this.color, this.textClr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownButtonFormField<String>(
        value: value,
        items:items,
        style: TextStyle(
          fontSize: 16,
          fontWeight:FontWeight.w600,
          color: textClr
        ),
        decoration:InputDecoration(
          filled: true,
          fillColor: color,
          contentPadding: const EdgeInsets.symmetric(vertical: 17,horizontal: 15),
          hintText: hintText,

          hintStyle: TextStyle(),
          border: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ), enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10)
        ), focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)
        ), errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // focusColor: ,
        onChanged:onChanged,
        validator:validator,

      ),
    );
  }
}
