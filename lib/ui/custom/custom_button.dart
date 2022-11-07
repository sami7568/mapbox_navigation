import 'package:eztransport/core/constants/colors.dart';
import 'package:eztransport/core/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  final String? text;
  const CustomButton({Key? key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      width: 335.w,
      //padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [
            0.1,
            0.9,
          ],
          colors: [kYellowColor, kYellowColor],
        ),
      ),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text!,
            style: buttonTextStyle,
          )),
    );
  }
}
