import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eztransport/core/others/base_view_model.dart';
import 'package:eztransport/core/others/logger_customizations/custom_logger.dart';
import 'package:eztransport/core/services/auth_service.dart';
import 'package:eztransport/core/services/local_storage_service.dart';
import 'package:eztransport/locator.dart';
import 'package:eztransport/ui/screens/home/home_screen.dart';
import 'package:eztransport/ui/screens/login/login.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SplashViewModel extends BaseViewModel {
  final Logger log = CustomLogger(className: 'SplashViewModel');
  double containerOpacity = 0.0;
  final _localStorageService = locator<LocalStorageService>();
  final _authService = locator<AuthService>();

  SplashViewModel() {
    Timer(const Duration(seconds: 2), () {
      containerOpacity = 1;
    });
    _initialSetup();
  }

  _initialSetup() async {
    // final connectivityResult = await Connectivity().checkConnectivity();
    // if (connectivityResult == ConnectivityResult.none) {
    //   // Get.dialog(const NetworkErrorDialog());
    //   //Get.offAll(const NoInternet());
    //   return;
    // }

    await _localStorageService.init();
    await _authService.doSetup();
    _initialRoute();
    notifyListeners();
  }

  _initialRoute() {
    if (_authService.isLogin != null) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}
