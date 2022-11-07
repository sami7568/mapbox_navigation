import 'package:eztransport/core/constants/api_end_points.dart';
import 'package:eztransport/core/models/body/login_body.dart';
import 'package:eztransport/core/others/logger_customizations/custom_logger.dart';
import 'package:eztransport/core/services/api_services.dart';
import 'package:eztransport/locator.dart';

class DatabaseService {
  final ApiServices _apiServices = locator<ApiServices>();
  final log = CustomLogger(className: 'database');

  Future<dynamic> loginWithPhoneAndPassword(LoginBody body) async {
    final response = await _apiServices.post(
      endPoint: EndPoints.login,
      data:
          // body.toJson(),
          {"userphone": "1230012222", "password": "test@0010"},
    );
    return response;
  }

  Future<dynamic> getData(int index) async {
    final response = await _apiServices.post(
      endPoint: EndPoints.data,
      data: {"name": "Nooreini Tester", "date": index},
    );
    return response;
  }

  Future<dynamic> noShow(DateTime time) async {
    final response = await _apiServices.get(
      endPoint: EndPoints.data,
      params: {
        "update": "Nooreini Tester",
        "value": "No Show-" + time.toString()
      },
    );
    return response;
  }

  Future<dynamic> arriveAtPickup(double lat, double lng, DateTime time) async {
    final response = await _apiServices.get(
      endPoint: EndPoints.data,
      params: {"update": "Nooreini Tester", "value": "$lat $lng $time"},
    );
    return response;
  }
}
