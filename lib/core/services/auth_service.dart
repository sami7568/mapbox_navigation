import 'package:eztransport/core/models/body/login_body.dart';
import 'package:eztransport/core/others/logger_customizations/custom_logger.dart';
import 'package:eztransport/core/services/database_service.dart';
import 'package:eztransport/core/services/local_storage_service.dart';
import 'package:eztransport/locator.dart';

//T0d0: Fix linter issues (camelCase and spellings)
class AuthService {
  bool? isLogin;
  final _localStorageService = locator<LocalStorageService>();
  final _dbService = locator<DatabaseService>();
  final log = CustomLogger(className: "auth Service");

  doSetup() async {
    isLogin = _localStorageService.userName != null;
    if (isLogin ?? false) {
      log.d('User is already logged-in');
    } else {
      log.d('@doSetup: User is not logged-in');
    }
  }

  loginWithPhoneAndPassword(LoginBody body) async {
    final response = await _dbService.loginWithPhoneAndPassword(body);
    return response;
  }

  logout() async {
    isLogin = false;
    //userProfile = null;
    // _localStorageService.accessToken = null;
    // await _dbService.clearFcmToken(await DeviceInfoService().getDeviceId());
  }
}
