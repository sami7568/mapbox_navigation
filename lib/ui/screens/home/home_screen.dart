import 'package:expansion_widget/expansion_widget.dart';
import 'package:eztransport/core/constants/colors.dart';
import 'package:eztransport/core/constants/decoration.dart';
import 'package:eztransport/core/constants/style.dart';
import 'package:eztransport/ui/custom/home_tab.dart';
import 'package:eztransport/ui/custom/text_input_field.dart';
import 'package:eztransport/ui/screens/home/home_view_model.dart';
import 'package:eztransport/ui/screens/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeViewModel(this),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          body: DefaultTabController(
            initialIndex: model.currentTabIndex,
            length: 3,
            child: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //width: 360.w,
                    height: 50.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration:
                        BoxDecoration(color: kSlateGreyColor.withOpacity(0.3)),
                    child: Center(
                      child: Text(
                        "Noo Tester:11222333@test_24 Trips",
                        style: bodyTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Tomorrow undefined",
                    style: bodyTextStyle.copyWith(
                      color: kBlueColor,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  //tabBar
                  tabBar(model),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomTextField(
                      prefix: Icon(
                        Icons.search,
                        color: kGreyColor,
                      ),
                      hintText: "Filter Items",
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  //tabBarView here
                  Container(
                    height: 600.h,
                    child: TabBarView(
                      controller: model.tabController,
                      children: [
                        //today
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              expansionWidget(model),
                              SizedBox(
                                height: 5.h,
                              ),
                              expansionWidget(model),
                              SizedBox(
                                height: 5.h,
                              ),
                              expansionWidget(model),
                            ],
                          ),
                        ),

                        //tomorrow
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              expansionWidget(model, isTomorrow: true),
                              SizedBox(
                                height: 5.h,
                              ),
                              expansionWidget(model, isTomorrow: true),
                              SizedBox(
                                height: 5.h,
                              ),
                              expansionWidget(model, isTomorrow: true),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  Container tabBar(HomeViewModel model) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: kWhiteColor,
        border: Border.all(color: kGreyColor),
        boxShadow: [
          BoxShadow(
            color: kGreyColor.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 6,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.all(10.h),
      child: TabBar(
        labelColor: kBlackColor,
        controller: model.tabController,
        tabs: const [
          Tabs(
            title: 'Today',
            icon: Icons.refresh,
          ),
          Tabs(
            title: 'Tomorrow',
            icon: Icons.calendar_month,
          ),
        ],
      ),
    );
  }

  ExpansionWidget expansionWidget(HomeViewModel model,
      {bool isTomorrow = false}) {
    return ExpansionWidget(
      initiallyExpanded: false,
      titleBuilder: (double animationValue, _, bool isExpaned, toggleFunction) {
        return InkWell(
          onTap: () {
            toggleFunction(animated: true);
            model.toggleIsExpand();
          },
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: boxDecoration,
            child: Center(
              child: iconName(
                  model.isExpand ? Icons.minimize_outlined : Icons.add,
                  "John Doe (3)"),
            ),
          ),
        );
      },
      content: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.h),
        decoration: boxDecoration.copyWith(color: kWhiteColor),
        margin: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(
          children: [
            legs(isTomorrow: isTomorrow),
            SizedBox(height: 10.h),
            legs(isTomorrow: isTomorrow),
            SizedBox(height: 10.h),
            legs(isTomorrow: isTomorrow),
          ],
        ),
      ),
    );
  }

  legs({bool isTomorrow = false}) {
    return Consumer<HomeViewModel>(
      builder: (context, model, child) => Container(
        decoration: BoxDecoration(
          border: border,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: kSlateGrayColor,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
            ),
            child: iconName(Icons.call, "12345678"),
          ),
          Container(
            width: 330.w,
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: kSlateGrayColor,
              ),
              color: kPlatinumColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("08:00 AM [leg1/3]"),
                SizedBox(
                  height: 5.h,
                ),
                const Text("504 E Molloy Rd Syracuse NY 1321"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    circularAvatarIcon(Icons.add_location),
                  ],
                ),
                const Text(
                  "#101 Union Ave Syracuse NY NY 1302",
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "  leg(1/3)NoShow@ 12:14:00",
            style: bodyTextStyle.copyWith(),
          ),
          SizedBox(
            height: 10.h,
          ),
          if (!isTomorrow)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(Icons.cancel, "Cancel", kPlatinumColor),
                button(Icons.check, "Pickup", kBlackColor, onTap: () {
                  // model.startNavigation();
                  Get.to(MapScreen());
                }),
              ],
            ),
          SizedBox(
            height: 10.h,
          ),
        ]),
      ),
    );
  }

  button(IconData icon, String title, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: kSlateGrayColor),
        ),
        child: Center(
          child: Row(
            children: [
              circularAvatarIcon(icon),
              SizedBox(
                width: 5.w,
              ),
              Text(
                title,
                style: bodyTextStyle.copyWith(
                  color: color == kBlackColor ? kWhiteColor : kBlackColor,
                  fontSize: 16.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  CircleAvatar circularAvatarIcon(IconData icon) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: kSlateGrayColor,
      child: Icon(
        icon,
        // color: kBlackColor,
        size: 18,
      ),
    );
  }

  Row iconName(IconData icon, String title) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14.r,
          backgroundColor: kGreyColor,
          child: Icon(
            icon,
            color: kWhiteColor,
            size: 20,
          ),
        ),
        SizedBox(width: 20.w),
        Text(
          title,
          style: bodyTextStyle.copyWith(
            fontSize: 17.sp,
            wordSpacing: 1.3,
            color: icon == Icons.add ? kCaribbeanCurrentColor : kBlackColor,
          ),
        ),
      ],
    );
  }
}
