import 'package:eztransport/core/constants/assets.dart';
import 'package:eztransport/core/constants/colors.dart';
import 'package:eztransport/core/constants/strings.dart';
import 'package:eztransport/core/constants/style.dart';
import 'package:eztransport/ui/screens/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SplashViewModel(),
      child: Consumer<SplashViewModel>(
        builder: (context, model, child) => Scaffold(
          body: Container(
            padding: const EdgeInsets.only(bottom: 32),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                AnimatedOpacity(
                  duration: duration,
                  curve: Curves.fastLinearToSlowEaseIn,
                  opacity: model.containerOpacity,
                  child: AnimatedContainer(
                    duration: duration,
                    curve: Curves.fastLinearToSlowEaseIn,
                    alignment: Alignment.center,
                    height: 64,
                    width: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image(
                      image: const AssetImage(kAppLogoImage),
                      width: 52.w,
                      height: 64.h,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Image(
                  image: const AssetImage(kAppLogoImage),
                  width: 204.w,
                  height: 88.h,
                ),
                Expanded(child: Container()),
                Text(
                  kCopyRight,
                  style: bodyTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Duration duration = const Duration(milliseconds: 2000);
}
