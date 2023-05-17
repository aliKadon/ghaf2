import 'dart:convert';

import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/api_response.dart';
import '../../../domain/model/items_to_return.dart';

class HelpApiController with ApiHelper {
  Future<List<ItemsToReturn>> getItemsToReturn({String? productName}) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/GetHelp/get-items-list-to-return?productName=$productName');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return List<ItemsToReturn>.from(
            jsonData['data'].map((x) => ItemsToReturn.fromJson(x)));
      }
    }
    return [];
  }

  Future<ApiResponse> returnItemTicket(
      {required String orderId,
      required String productId,
      required String comment,
      String? ticketImage}) async {
    var url = Uri.parse('${Constants.baseUrl}/GetHelp/return-item-ticket');
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          'orderId': orderId,
          'productId': productId,
          'comment': comment,
          'ticketImage': ticketImage,
        }));

    print('===========================return item');
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

  Future<ApiResponse> reportDelayTicket({
    required String orderId,
    required String comment,
  }) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/GetHelp/report-delay-ticket?OrderId=$orderId&commnet=$comment');
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

  Future<ApiResponse> reportOrderIssueTicket({
    required String orderId,
    required String comment,
  }) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/GetHelp/report-order-issue-ticket?OrderId=$orderId&commnet=$comment');
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

  Future<ApiResponse> reportGeneralIssueTicket({
    required String comment,
  }) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/GetHelp/report-general-issue-ticket?commnet=$comment');
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

  Future<ApiResponse> requestCallBack({required String bid}) async {
    var url = Uri.parse('${Constants.baseUrl}/Auth/request-call?bid=$bid');
    var response = await http.post(url, headers: headers);

    print('=========================call back');
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

  Future<ApiResponse> cancelOrder({required String orderId}) async {
    var url = Uri.parse('${Constants.baseUrl}/Orders/cancel-order?Id=$orderId');
    var response = await http.post(url, headers: headers);

    print('=========================cancel order');
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
