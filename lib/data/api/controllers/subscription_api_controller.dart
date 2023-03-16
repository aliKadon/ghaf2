import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/data/api/api_settings.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/subscription_plan.dart';
import 'package:http/http.dart' as http;

class SubscriptionApiController with ApiHelper {
  late final Dio _dio = Dio(BaseOptions(baseUrl: ApiSettings.baseUrl));

  // subscribe as ghaf golden.
  Future<ApiResponse> subscribeAsGhafGolden(
      {required String planId, required String paymentMethodId}) async {
    // print('send request : customer-subscripe-as-ghafgold');

    Map<String, dynamic> data = {
      "PlanId": planId,
      "PaymentMethodId": paymentMethodId,
    };

    var response = await _dio.post(
      '/Auth/customer-subscripe-as-ghafgold',
      data: data,
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

  Future<ApiResponse> cancelSubscribe() async {
    var url =
        Uri.parse('${Constants.baseUrl}/Auth/customer-cancel-subscribtion');
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

  Future<List<SubscriptionPlan>> getSubscriptionPlan() async {
    var url = Uri.parse('${Constants.baseUrl}/Auth/get-customer-plans');
    var response = await http.get(url, headers: headers);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonData['status'] == 200) {
        return List<SubscriptionPlan>.from(
            jsonData['data'].map((x) => SubscriptionPlan.fromJson(x)));
      }
    }
    return [];
  }

  // subscribe as free.
  Future<ApiResponse> subscribeAsFree() async {
    // print('send request : customer-subscripe-for-free');
    var response = await _dio.post(
      'Auth/customer-subscripe-for-free',
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
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

  // cancel subscription.
  Future<ApiResponse> cancelSubscription() async {
    // print('send request : customer-cancel-subscribtion');
    var response = await _dio.post(
      'Auth/customer-cancel-subscribtion',
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
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
}
