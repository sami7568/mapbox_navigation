import 'package:eztransport/core/services/localization_service.dart';
import 'package:eztransport/ui/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  final String title;
  // ignore: todo
  //T0d0: Update the [_designWidth] & [_designHeight]

  static const double _designWidth = 375;
  static const double _designHeight = 812;
  const MyApp({required this.title, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(_designWidth, _designHeight),
      builder: (context, widget) => GetMaterialApp(
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder()
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
        translations: LocalizationService(),
        locale: const Locale('en'),
        title: title,
        home: LoginScreen(),
      ),
    );
  }
}