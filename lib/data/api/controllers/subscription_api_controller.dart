import 'package:dio/dio.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/data/api/api_settings.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

class SubscriptionApiController with ApiHelper {
  late final Dio _dio = Dio(BaseOptions(baseUrl: ApiSettings.baseUrl));

  // subscribe as ghaf golden.
  Future<ApiResponse> subscribeAsGhafGolden() async {
    // print('send request : customer-subscripe-as-ghafgold');
    Map<String, dynamic> data = {
      "paymentMethodType": "card",
      "cardNumber": "4242424242424242",
      "cardExpMonth": 8,
      "cardExpCvc": "314",
      "cardExpYear": 2023,
      "PlanId": "23649D13-7E5F-4962-94BC-08DAE4189B69"
    };
    // print(data);
    var response = await _dio.post(
      'Auth/customer-subscripe-as-ghafgold',
      data: data,
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
