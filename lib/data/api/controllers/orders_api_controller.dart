import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/domain/model/address.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/order_to_pay.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/order.dart';

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
    // print('============================================create order');
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      return ApiResponse(
        message: response.data['message'],
        status: response.data['status'],
      );
    }
    return failedResponse;
  }

  Future<ApiResponse> deleteUnpaidOrderById({required String orderId}) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/Orders/delete-unpaid-order?Id=$orderId');
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
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
    // print('===============delivery method');
    // print(jsonData['data']['availableDeliveryMethod']);
    if (response.statusCode == 200) {
      // var jsonData = jsonDecode(response.data);
      // print(jsonData['data']);
      if (response.data['status'] == 200) {
        return List<OrderToPay>.from(
            response.data['data'].map((x) => OrderToPay.fromJson(x)));

        // Order.fromJson(jsonData['data']['orderDetails']);

        // List<Order>.from(
        //   jsonData['data']['orderDetails'].map((x) => Order.fromJson(x)));
      }
    }
    return [];
  }

  Future<ApiResponse> payForOrder({
    required String orderId,
    required String deliveryMethodId,
    String? desiredDeliveryDate,
    required Address deliveryPoint,
    String? OrderNotes,
    String? PromoCode,
    bool? useWallet,
    bool? asap,
    Map<String,dynamic>? SheduleInfo,
    bool? useRedeemPoints = false,
    bool? usePayLater = false,
    required String PaymentMethodId,
  }) async {
    var url = Uri.parse('${Constants.baseUrl}/Orders/pay-for-order');
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          'orderId': orderId,
          'deliveryMethodId': deliveryMethodId,
          'desiredDeliveryDate': desiredDeliveryDate,
          'deliveryPoint': deliveryPoint,
          'useRedeemPoints': useRedeemPoints,
          'usePayLater': usePayLater,
          'OrderNotes' : OrderNotes,
          'PaymentMethodId': PaymentMethodId,
          'PromoCode': PromoCode,
          'Asap' : asap,
          'UseWallet' : useWallet,
          'SheduleInfo' : SheduleInfo,
        }));
    print('============================================ pay for order');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return ApiResponse(
            message: jsonData['message'], status: jsonData['status']);

      }else {
        return ApiResponse(
            message: jsonData['message'], status: jsonData['status']);
      }
    }
    return failedResponse;
  }

  Future<Order?> getOrderById({required String orderId}) async{
    var url = Uri.parse('${Constants.baseUrl}/orders/get-order-by-id?id=$orderId');

    var response = await http.get(url,headers: headers);

    print('=======================order by id');
    print(response.body);

    if(response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return Order.fromJson(jsonData['data']);
      }
    }
    return null;
  }
}
