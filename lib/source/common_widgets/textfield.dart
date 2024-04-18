import 'package:flutter/material.dart';
import 'package:kerala_wings/source/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final String hitText;
  final validator;
  final keyboardType;
  final suffix;
  final preffix;
  final style;
  final bool obscureText;
  final readOnly;
  final onChanged;
  final isExpand;
  final onTap;


  CustomTextField({Key? key,
    this.controller,
    required this.hitText,
    this.validator, this.keyboardType,
    this.suffix,
    required this.obscureText,
    this.preffix,
    this.style,
    this.readOnly,
    this.isExpand,
    this.onChanged, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      maxLines: null,
      expands: isExpand,
        style: style,
        readOnly: readOnly,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        // style: ,

        decoration: InputDecoration(
          prefixIcon: suffix,
          suffixIcon: preffix,
          prefixIconColor: Colors.black,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400
          ),
          // errorMaxLines: 1,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          filled: true,
          fillColor: cGrey.withOpacity(.5),
          hintText: hitText,
          errorStyle:  const TextStyle(
            color: cRed
          ),

          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)
          ), enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(8)
        ), focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)
        ), errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)
        ),

        )

    );
  }
}
