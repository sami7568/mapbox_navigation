import 'package:dio/dio.dart';

import 'package:eztransport/core/models/responses/base_responses/request_response.dart';
import 'package:eztransport/core/others/logger_customizations/custom_logger.dart';

class ApiServices {
  final log = CustomLogger(className: 'ApiServices');
  Future<Dio> launchDio() async {
    // final log = CustomLogger(className: 'api services');

    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.options.headers['Content-Type'] = "application/x-www-form-urlencoded";
    dio.options.headers['accept'] = 'application/json';

    dio.options.followRedirects = false;
    dio.options.validateStatus = (s) {
      if (s != null) {
        return s < 500;
      } else {
        return false;
      }
    };
    return dio;
  }

  get({required String endPoint, params}) async {
    try {
      Dio dio = await launchDio();
      final response = await dio.get(endPoint, queryParameters: params);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      ///
      /// The request was made and the server responded with a status code
      /// that falls out of the range of 2xx and is also not 304.
      ///
      if (e.response != null) {
        log.e(
            '@get - Server error \n Data: \n${e.response!.data} \n Request Header: ${e.response!.headers} \n Request Options: ${e.response!.requestOptions}');
        return RequestResponse.fromJson(
            'Server error with error code: ${e.response!.statusCode}');
      } else {
        ///
        /// Something happened in setting up or sending the request that triggered an Error
        ///

        log.e(
            '@get - Internal dio error \n Request options: \n${e.requestOptions} \n Request Header: ${e.response!.headers} \n Request Options: ${e.response!.requestOptions}');
        return RequestResponse.fromJson(
            'Internet request failed with error: ${e.message}. Please make sure you have stable internet connection');
      }
    }
  }

  post({required String endPoint, data}) async {
    try {
      Dio dio = await launchDio();
      final response = await dio.post(endPoint, data: data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      ///
      /// The request was made and the server responded with a status code
      /// that falls out of the range of 2xx and is also not 304.
      ///
      if (e.response != null) {
        log.e(
            '@get - Server error \n Data: \n${e.response!.data} \n Request Header: ${e.response!.headers} \n Request Options: ${e.response!.requestOptions}');
        return RequestResponse.fromJson(
            'Server error with error code: ${e.response!.statusCode}');
      } else {
        ///
        /// Something happened in setting up or sending the request that triggered an Error
        ///

        log.e(
            '@get - Internal dio error \n Request options: \n${e.requestOptions} \n Request Header: ${e.response!.headers} \n Request Options: ${e.response!.requestOptions}');
        return RequestResponse.fromJson(
            'Internet request failed with error: ${e.message}. Please make sure you have stable internet connection');
      }
    }
  }
}
