import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:http/http.dart' as http;

import '../../../app/preferences/shared_pref_controller.dart';
import '../../../app/utils/app_shared_data.dart';
import '../../../domain/model/api_response.dart';
import '../../../domain/model/user.dart';
import '../api_helper.dart';

class UserDetailsApiController with ApiHelper, Helpers {
  late final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  Future<ApiResponse> getUserDetails({
    required BuildContext context,
  }) async {
    // // print('send request : getUserDetails');
    // // print(headers);
    var response = await _dio.get(
      '/Auth/get-user-details',
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
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

  Future<ApiResponse> updateUserDetails({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String telephone,
  }) async {
    Uri uri = Uri.parse(
        '${Constants.baseUrl}/Auth/update-user-info?firstname=$firstName&lastname=$lastName&phone=$telephone');
    var response = await http.post(uri, headers: headers);
    // print('============================================11');
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        print(jsonResponse['message']);
        SharedPrefController().setFirstName(firstName);
        SharedPrefController().setLastName(lastName);
        SharedPrefController().setTelephone(telephone);

      }
      return ApiResponse(
        message: jsonResponse['message'],
        status: jsonResponse['status'],
      );
    }
    return failedResponse;
  }

  Future<ApiResponse> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/Auth/change-user-password?oldPassword=$oldPassword&newPassword=$newPassword&confirmNewPassword=$confirmPassword');
    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return ApiResponse(
            message: jsonData['message'], status: jsonData['status']);
      }
    }
    return failedResponse;
  }

  Future<ApiResponse> deleteAccount() async {
    var url = Uri.parse(
        '${Constants.baseUrl}/Auth/delete-user-account');
    var response = await http.post(url, headers: headers1);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return ApiResponse(
            message: jsonData['message'], status: jsonData['status']);
      }
    }
    return failedResponse;
  }


}
