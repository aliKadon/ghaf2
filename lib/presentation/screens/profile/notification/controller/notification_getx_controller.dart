import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/notification_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

import '../../../../../domain/model/customer_notification.dart';

class NotificationGetxController extends GetxController with Helpers {
  List<CustomerNotification> customerNotification = [];
  late ApiResponse apiResponse;
  late final NotificationApiController _notificationApiController =
      NotificationApiController();

  void getCustomerNotification({required BuildContext context}) async {

    try {
      customerNotification =
          await _notificationApiController.getCustomerNotification();
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void markAsRead({required BuildContext context, required String id}) async {
    try {
      apiResponse = await _notificationApiController.markAsRead(id: id);
      getCustomerNotification(context: context);
      // showSnackBar(context, message: apiResponse.message);
      update();
    } catch (e) {
      showSnackBar(context, message: e.toString(), error: true);
    }
  }
}
