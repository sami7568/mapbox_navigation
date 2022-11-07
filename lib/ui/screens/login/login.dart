import 'package:eztransport/core/constants/assets.dart';
import 'package:eztransport/core/constants/colors.dart';
import 'package:eztransport/core/constants/strings.dart';
import 'package:eztransport/core/constants/style.dart';
import 'package:eztransport/ui/custom/custom_button.dart';
import 'package:eztransport/ui/custom/text_input_field.dart';
import 'package:eztransport/ui/screens/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

//T0d0: Use class widgets instead of functional widgets in the whole file
//T0d0: Use class widgets instead of functional widgets in the whole file

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kWhiteColor,
          appBar: AppBar(
            backgroundColor: kYellowColor,
            foregroundColor: kBlackColor,
            title: const Text("Ez Transport"),
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(kAppLogoImage, width: 100.h, height: 100.h),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Ez Transport",
                      style: headingTextStyle.copyWith(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Sign In",
                      style: headingTextStyle.copyWith(fontSize: 22.sp),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextField(
                      hintText: "User Phone",
                      errorText: "Please Enter Valid User Phone",
                      onChanged: (val) {
                        model.body.userphone = val;
                      },
                      validator: (val) {
                        return val.length < 5
                            ? "Please enter Valid User Phone"
                            : null;
                      },
                      controller: model.userNameController,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      hintText: "password",
                      errorText: "Please Enter Valid Password",
                      onChanged: (val) {
                        model.body.password = val;
                      },
                      validator: (val) {
                        return val.length < 3
                            ? "Please enter Valid Password"
                            : null;
                      },
                      controller: model.passwordController,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Forgot Password",
                      style: bodyTextStyle,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(
                      text: "Login",
                      onPressed: () {
                        model.requestLogin();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: RichText(
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: kDoNotHaveAccount,
                                style: bodyTextStyle1.copyWith(
                                    color: kSquidInkColor)),
                            TextSpan(
                                // recognizer: TapGestureRecognizer()
                                //   ..onTap = () => Get.to(
                                //         SignUpScreen(),
                                //         transition: Transition.rightToLeft,
                                //       ),
                                text: kSignUp,
                                style: bodyTextStyle1.copyWith(
                                    color: kSquidInkColor,
                                    decoration: TextDecoration.underline))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//T0d0: Use class widgets instead of functional widgets

}
