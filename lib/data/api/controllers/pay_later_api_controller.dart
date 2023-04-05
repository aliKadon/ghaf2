import 'dart:convert';

import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/domain/model/pay_later.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/api_response.dart';

class PayLaterApiController with ApiHelper {
  num? totalCredit;

  Future<List<PayLater>> getCustomerInstallments() async {
    var url =
        Uri.parse('${Constants.baseUrl}/Orders/get-customer-installments');
    var response = await http.get(url, headers: headers);

    print('=================pay later');
    print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        totalCredit = jsonData['totalCredit'];
        return List<PayLater>.from(
            jsonData['data'].map((x) => PayLater.fromJson(x)));
      }
    }
    return [];
  }

  Future<ApiResponse> payForInstallment(
      {required String paymentMethodId, required String productId}) async {
    var url = Uri.parse('${Constants.baseUrl}/Orders/pay-for-instalments');
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(
        {
          'InstalmentId': productId,
          'PaymentMethodId': paymentMethodId,
        },
      ),
    );
    print('=================pay for installments ');
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return ApiResponse(
            message: jsonData['message'], status: jsonData['status']);
      } else {
        ApiResponse(message: jsonData['message'], status: jsonData['status']);
      }
    }
    return failedResponse;
  }
}
