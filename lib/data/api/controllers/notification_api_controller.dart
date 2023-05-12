import 'dart:convert';

import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/api_response.dart';
import '../../../domain/model/customer_notification.dart';

class NotificationApiController with ApiHelper {
  Future<List<CustomerNotification>> getCustomerNotification() async {
    var url = Uri.parse(
        '${Constants.baseUrl}/Auth/get-customer-notifications?Type&pageIndex&pageRows');
    var response = await http.get(url, headers: headers);

    print('=============================notifications');
    print(jsonDecode(response.body));


    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return List<CustomerNotification>.from(
            jsonData['data'].map((x) => CustomerNotification.fromJson(x)));
      }
    }
    return [];
  }

  Future<ApiResponse> markAsRead({required String id}) async {
    var url = Uri.parse('${Constants.baseUrl}/Auth/mark-as-read?Id=$id');
    var response = await http.post(url, headers: headers);


    print('=========================mark as read');
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
