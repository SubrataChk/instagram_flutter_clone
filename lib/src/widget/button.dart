import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomButton({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 5.h,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blueAccent),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
          ),
        ),
      ),
    );
  }
}
