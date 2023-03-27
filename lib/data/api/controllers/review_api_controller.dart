import 'dart:convert';

import 'package:ghaf_application/app/constants.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/api_response.dart';
import '../api_helper.dart';

class ReviewApiController with ApiHelper {
  Future<ApiResponse> addAppReview(
      {required String description, required num points}) async {
    var url = Uri.parse('${Constants.baseUrl}/AppReview/add-user-review');
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'description': description,
        'points': points,
      }),
    );
    print('===================app review');
    print(description);
    print(points);
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

  Future<ApiResponse> addProductReview(
      {required String prodId, required num points}) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/Product/add-review?prodId=$prodId&points=$points');
    var response = await http.post(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return ApiResponse(
            message: jsonData['message'], status: jsonData['status']);
      }
    }
    return failedResponse;
  }

  Future<ApiResponse> addStoreReview(
      {required String storeId, required num points,required String opinion}) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/Auth/create-store-review?storeId=$storeId&opinion=$opinion&points=$points');
    var response = await http.post(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return ApiResponse(
            message: jsonData['message'], status: jsonData['status']);
      }
    }
    return failedResponse;
  }
}
