import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/pay_later_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

import '../../../domain/model/pay_later.dart';

class PayLaterGetxController extends GetxController with Helpers {
  List<PayLater> payLater = [];
  num? totalCredit;
  late ApiResponse apiResponse;
  final PayLaterApiController _payLaterApiController = PayLaterApiController();

  void getCustomerInstallments({required BuildContext context}) async {
    try {
      payLater = await _payLaterApiController.getCustomerInstallments();
      totalCredit = await _payLaterApiController.totalCredit;
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void payForInstallments(
      {required BuildContext context,
      required String productId,
      required String paymentMethodId}) async {
    try {
      showLoadingDialog(context: context,title: 'loading...');
      apiResponse = await _payLaterApiController.payForInstallment(
          paymentMethodId: paymentMethodId, productId: productId);
      Navigator.of(context).pop();
      showSnackBar(context, message: apiResponse.message);
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
