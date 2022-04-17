import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool isPass;
  final TextEditingController controller;
  final TextInputType textInputType;
  final IconData icons;
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.isPass,
      required this.textInputType,
      required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: TextFormField(
        obscureText: isPass,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icons),
          filled: true,
          // fillColor: Colors.black,
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            // borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            // borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            // borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
