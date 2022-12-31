import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/services/firebase_messaging_service.dart';
import 'package:http/http.dart' as http;

import '../../../app/preferences/shared_pref_controller.dart';
import '../../../domain/model/api_response.dart';
import '../../../domain/model/user.dart';
import '../api_helper.dart';
import '../api_settings.dart';

class AuthApiController with ApiHelper {
  late final Dio _dio = Dio(BaseOptions(baseUrl: ApiSettings.baseUrl));

  Future<ApiResponse> register({required User user}) async {
    Uri uri = Uri.parse(ApiSettings.register);
    var response =
        await http.post(uri, headers: headers, body: jsonEncode(user.toJson()));
    print('============================================');
    print(response.statusCode);
    print(response.body);
    print(user.toJson());
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        var userObject = jsonResponse['data'];
        User user = User.fromJson(userObject);
        SharedPrefController().save(user: user);
      }
      return ApiResponse(
        message: jsonResponse['message'],
        status: jsonResponse['status'],
      );
    }
    return failedResponse;
  }

  Future<ApiResponse> login(
      {required String userName, required String password}) async {
    Uri uri = Uri.parse(ApiSettings.login);
    var response = await http.post(uri,
        headers: headers,
        body: jsonEncode({
          'userName': userName,
          'password': password,
          'fcm_token': await FirebaseMessagingService.instance.getToken(),
        }));
    print('111');
    print('============================================');
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      print('222');
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        SharedPrefController().setToken(jsonResponse['data']);
      }
      return ApiResponse(
        message: jsonResponse['message'],
        status: jsonResponse['status'],
      );
    }
    return failedResponse;
  }

  // forgot password.
  Future<ApiResponse> forgotPassword({
    required String email,
  }) async {
    print('send request : forgot-password');
    Map<String, dynamic> queryParameters = {
      'email': email,
    };
    print(queryParameters);
    var response = await _dio.post(
      'Auth/forgot-password',
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    print('============================================');
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return ApiResponse(
          message: response.data['message'],
          status: response.data['status'],
        );
      }
    }
    return failedResponse;
  }

  // reset password.
  Future<ApiResponse> resetPassword({
    required String code,
    required String password,
    required String confirmPassword,
  }) async {
    print('send request : reset-password');
    Map<String, dynamic> data = {
      "token": code,
      "password": password,
      "confirmPassword": confirmPassword,
    };
    print(data);
    var response = await _dio.post(
      '/reset-password',
      data: data,
      options: Options(
        headers: headers,
      ),
    );
    print('============================================');
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      return ApiResponse(
        message: response.data['message'],
        status: response.data['status'],
      );
    }
    return failedResponse;
  }

  Future<ApiResponse> profile() async {
    print('send request : getUserDetails');
    print(headers);
    var response = await _dio.get(
      'Auth/getUserDetails',
      options: Options(
        headers: headers,
      ),
    );
    print('============================================');
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        User user = User.fromJson(response.data['data']);
        SharedPrefController().save(user: user);
        AppSharedData.currentUser = user;
      }
      return ApiResponse(
        message: response.data['message'],
        status: response.data['status'],
      );
    }
    return failedResponse;
  }
}
