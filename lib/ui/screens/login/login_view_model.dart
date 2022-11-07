import 'dart:convert';

import 'package:eztransport/core/models/body/login_body.dart';
import 'package:eztransport/core/models/responses/login_response.dart';
import 'package:eztransport/core/others/logger_customizations/custom_logger.dart';
import 'package:eztransport/core/services/auth_service.dart';
import 'package:eztransport/core/services/local_storage_service.dart';
import 'package:eztransport/locator.dart';
import 'package:eztransport/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends ChangeNotifier {
  //T0d0: instead of logger use CustomLogger
  //T0d0: make the variables private if they are not used anywhere else

  final _log = CustomLogger(className: "Login View Model");
  bool isRememberMe = false;
  final authService = locator<AuthService>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _localStorageService = locator<LocalStorageService>();

  bool passwordVisibility = true;
  List<String>? responseData;
  LoginBody body = LoginBody();
  LoginResponse? user;

  togglePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  requestLogin() async {
    try {
      final response = await authService.loginWithPhoneAndPassword(body);
      _log.i(response);
      saveData(response);
      Get.to(const HomeScreen());
    } catch (e, s) {
      _log.e('@LoginViewModel requestLogin Exceptions : $e');
      _log.e(s);
    }
  }

  saveData(String response) {
    responseData = response.toString().split(",");
    String status = "";
    for (int i = 2; i < responseData!.first.length - 1; i++) {
      status += responseData!.first[i];
    }
    responseData!.first = status.toString();
    _log.i(responseData!.first);
    String email = "";
    for (int i = 1; i < responseData!.last.length - 2; i++) {
      email += responseData!.last[i];
    }
    responseData!.last = email;
    _log.i(responseData!.last);
    if (responseData!.first == "Success") {
      String name = '';
      for (int i = 1; i < responseData![1].length - 1; i++) {
        name += responseData![1][i];
      }
      user = LoginResponse(status: status, userEmail: email, userName: name);
      _localStorageService.setUserName = name;
      _localStorageService.setUserEmail = email;
      _log.i(name);
    }
    Get.to(const HomeScreen());
    notifyListeners();
  }

  toggleIsRememberMe() {
    debugPrint('@toggleIsRememberMe: isRememberMe: $isRememberMe');
    isRememberMe = !isRememberMe;
    notifyListeners();
  }
}
