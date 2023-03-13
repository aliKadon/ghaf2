import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/data/api/api_settings.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/order.dart';
import 'package:ghaf_application/domain/model/order_to_pay.dart';
import 'package:http/http.dart' as http;


class OrdersApiController with ApiHelper {
  late final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  // create order.
  Future<ApiResponse> createOrder() async {
    print('send request : create');
    var response = await _dio.post(
      '/Orders/create-order',
      options: Options(
        headers: headers,
      ),

    );
    print('============================================create order');
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

  // get ready orders to pay.
  Future<List<OrderToPay>> getReadyOrdersToPay() async {
    // print('send request : get-ready-order-to-pay');
    // var url = Uri.parse('${Constants.baseUrl}/Orders/get-ready-order-to-pay');
    // var response = await http.get(url,headers: headers);

    var response = await _dio.get(
      '/Orders/get-ready-order-to-pay',
      options: Options(
        headers: headers,
      ),
    );
    print('============================================');
    print(response.statusCode);
    print(response.data);
    print('===============delivery method');
    // print(jsonData['data']['availableDeliveryMethod']);
    if (response.statusCode == 200) {

      // var jsonData = jsonDecode(response.data);
      // print(jsonData['data']);
      if(response.data['status'] == 200) {
        return List<OrderToPay>.from(
            response.data['data'].map((x) => OrderToPay.fromJson(x)));

          // Order.fromJson(jsonData['data']['orderDetails']);

          // List<Order>.from(
          //   jsonData['data']['orderDetails'].map((x) => Order.fromJson(x)));
      }
    }
    return [];
  }
}
