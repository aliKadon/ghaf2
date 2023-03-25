import 'dart:convert';

import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/domain/model/redeem_history_item.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/redeem.dart';
import '../api_helper.dart';

class RedeemApiController with ApiHelper {

  Future<Redeem?> getRedeemHistory() async {
    var url = Uri.parse('${Constants.baseUrl}/GiftAndReward/get-customer-redeem-history');
    var response = await http.get(url,headers: headers);

    // print('======================redeem history');
    // print(response.statusCode);
    // print(response.body);
    if(response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if(jsonData['status'] == 200) {
        return Redeem.fromJson(jsonData['data']);
      }
    }
    return null;
  }

}