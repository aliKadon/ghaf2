import 'dart:convert';

import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/domain/model/payment_history.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/api_response.dart';

class WalletApiController with ApiHelper {
  Future<dynamic> getMyWalletBalance() async {
    var url = Uri.parse('${Constants.baseUrl}/Wallet/get-my-wallet-balance');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return jsonData['data'];
      }
    }
    return 0;
  }

  Future<ApiResponse> topUp(
      {required String paymentMethodId, required num amount}) async {
    var url = Uri.parse('${Constants.baseUrl}/Wallet/top-up');
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          'PaymentMethodId': paymentMethodId,
          'amount': amount,
        }));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return ApiResponse(
            message: jsonData['message'], status: jsonData['status']);
      }
    }
    return failedResponse;
  }

  Future<ApiResponse> sharePoints(
      {required String email, required int amount}) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/Wallet/share-points?email=$email&Amount=$amount');
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

  Future<List<PaymentHistory>> getPaymentHistory() async {
    var url = Uri.parse('${Constants.baseUrl}/Wallet/get-my-wallet-payments');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return List<PaymentHistory>.from(
            jsonData['data'].map((x) => PaymentHistory.fromJson(x)));
      }
    }
    return [];
  }
}
