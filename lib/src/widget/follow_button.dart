import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FollowButton extends StatefulWidget {
  final String title;
  final Function()? function;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const FollowButton(
      {Key? key,
      required this.backgroundColor,
      this.function,
      required this.textColor,
      required this.title,
      required this.borderColor})
      : super(key: key);

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: 55.w,
      padding: EdgeInsets.only(top: 2.h),
      child: TextButton(
        onPressed: widget.function,
        child: Container(
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              border: Border.all(color: widget.borderColor)),
          alignment: Alignment.center,
          child: Text(
            widget.title,
            style: TextStyle(color: widget.textColor),
          ),
        ),
      ),
    );
  }
}
