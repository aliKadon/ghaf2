import 'package:dio/dio.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/data/api/api_settings.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/order.dart';

class OrdersApiController with ApiHelper {
  late final Dio _dio = Dio(BaseOptions(baseUrl: ApiSettings.baseUrl));

  // create order.
  Future<ApiResponse> createOrder() async {
    print('send request : create-order');
    var response = await _dio.post(
      'Orders/create-order',
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
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

  // get ready orders to pay.
  // Future<List<Order>> getReadyOrdersToPay() async {
  //   print('send request : get-ready-order-to-pay');
  //   var response = await _dio.post(
  //     'Orders/get-ready-order-to-pay',
  //     options: Options(
  //       headers: headers,
  //     ),
  //   );
  //   print('============================================');
  //   print(response.statusCode);
  //   print(response.data);
  //   if (response.statusCode == 200) {
  //     return List<Order>.from(
  //         response.data["data"].map((x) => Order.fromJson(x['orderDetails'])));
  //   }
  //   return [];
  // }
}
