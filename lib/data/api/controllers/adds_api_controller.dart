import 'dart:convert';

import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/domain/model/adds.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/store_adds.dart';

class AddsApiController with ApiHelper {
  Future<List<Adds>> getAdds() async {
    var url = Uri.parse('${Constants.baseUrl}/GiftAndReward/read-adds');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return List<Adds>.from(jsonData['data'].map((x) => Adds.fromJson(x)));
      }
    }
    return [];
  }

  Future<List<StoreAdds>> getStoreAdds() async {
    var url = Uri.parse('${Constants.baseUrl}/GiftAndReward/read-store-adds');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return List<StoreAdds>.from(
            jsonData['data'].map((x) => StoreAdds.fromJson(x)));
      }
    }
    return [];
  }
}
