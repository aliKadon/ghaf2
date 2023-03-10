import 'dart:convert';

import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/payment_mathod.dart';

class PaymentMethodApiController with ApiHelper {
  Future<List<PaymentMethod>> getPaymentMethod() async {
    var url = Uri.parse('${Constants.baseUrl}/PaymentMethod/get-paymentmethod');
    var response = await http.get(url, headers: headers);

    // print('========================payment method');
    // print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body) ;
      if (jsonData['status'] == 200) {
        // print('=============================data');
        // print(jsonData['data']);
        return List<PaymentMethod>.from(jsonData['data'].map((x) => PaymentMethod.fromJson(x)));

      }
    }
    return [];
  }
}
