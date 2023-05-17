import 'dart:convert';

import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/domain/model/read-individual-products.dart';
import 'package:http/http.dart' as http;

import '../../../../../domain/model/api_response.dart';
import '../../../api_helper.dart';

class IndividualSellerApiController with ApiHelper {
  Future<ApiResponse> createProduct(
      {required String name,
      required String description,
      String? characteristics,
      required String productType,
      required num price,
      required List<String> images}) async {
    var url =
        Uri.parse('${Constants.baseUrl}/product/create-individual-products');
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          'name': name,
          'description': description,
          'characteristics': characteristics,
          'productType': productType,
          'price': price,
          'images': images,
        }));
    print('=========================create product');
    print(response.statusCode);
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

  Future<String> createLink({required List<dynamic> ItemForLinks}) async {
    var data = {
      'prodId': '740eedd8-5efa-42c5-ac86-08db31bb5948',
      'Quantity': 3,
    };
    List<dynamic> list = [];
    list.add(data);
    var url = Uri.parse('${Constants.baseUrl}/product/create-paymnet-link');
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          'ItemForLinks': ItemForLinks,
        }));
    print('=========================create link');
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return jsonData['data'];
      }
    }
    return 'nothing to show';
  }

  Future<List<ReadIndividualProducts>> getIndividualProducts() async {
    var url =
        Uri.parse('${Constants.baseUrl}/product/read-individual-products');
    var response = await http.get(url, headers: headers);

    print('=========================get Individual Products');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return List<ReadIndividualProducts>.from(
            jsonData['data'].map((x) => ReadIndividualProducts.fromJson(x)));
      }
    }
    return [];
  }

  Future<ApiResponse> getSellerDetails() async {
    var url =
    Uri.parse('${Constants.baseUrl}/Auth/get-user-details');
    var response = await http.post(url,
        headers: headers,);
    print('=========================seller details');
    print(response.statusCode);
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
}
