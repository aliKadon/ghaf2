import 'dart:convert';

import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/domain/model/promo_code.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/api_response.dart';
import '../../../domain/model/payment_mathod.dart';

class PaymentMethodApiController with ApiHelper {
  Future<List<PaymentMethod>> getPaymentMethod() async {
    var url = Uri.parse('${Constants.baseUrl}/PaymentMethod/get-paymentmethod');
    var response = await http.get(url, headers: headers);

    // print('========================payment method');
    // print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        // print('=============================data');
        // print(jsonData['data']);
        return List<PaymentMethod>.from(
            jsonData['data'].map((x) => PaymentMethod.fromJson(x)));
      }
    }
    return [];
  }

  Future<ApiResponse> deletePaymentMethod({required String id}) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/PaymentMethod/remove-paymentmethod?Id=$id');
    var response = await http.post(url, headers: headers);

    print('========================delete payment method');
    print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return ApiResponse(
            message: jsonData['message'], status: jsonData['status']);
      }
    }
    return failedResponse;
  }

  Future<ApiResponse> addPaymentMethod({
    required String cardNumber,
    required num cardExpMonth,
    required String cardExpCvc,
    required num cardExpYear,
  }) async {
    var url = Uri.parse('${Constants.baseUrl}/PaymentMethod/add-paymentmethod');
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          'paymentMethodType': 'card',
          'cardNumber': cardNumber,
          'cardExpMonth': cardExpMonth,
          'cardExpCvc': cardExpCvc,
          'cardExpYear': cardExpYear,
        }));
    // print('=======================addPayment');
    // print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return ApiResponse(
            message: jsonData['message'], status: jsonData['status']);
      }
    }
    return failedResponse;
  }

  Future<List<PromoCode>> getPromoCode({int? status}) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/GiftAndReward/get-customer-promocode?status=$status');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return List<PromoCode>.from(
            jsonData['data'].map((e) => PromoCode.fromJson(e)));
      }
    }
    return [];
  }
}
