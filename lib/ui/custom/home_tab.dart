import 'package:eztransport/core/constants/colors.dart';
import 'package:eztransport/core/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tabs extends StatelessWidget {
  const Tabs({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      iconMargin: EdgeInsets.zero,
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 13.r,
            backgroundColor: kPlatinumColor,
            foregroundColor: kBlackColor,
            child: Icon(
              icon,
              color: kGreyColor,
              size: 16.h,
            ),
          ),
          Text(
            title,
            style: bodyTextStyle1.copyWith(
              color: kBlackColor,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
