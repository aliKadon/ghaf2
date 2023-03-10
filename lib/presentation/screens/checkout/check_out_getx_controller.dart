import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/payment_method_api_controller.dart';

import '../../../domain/model/payment_mathod.dart';

class CheckOutGetxController extends GetxController with Helpers {
  List<PaymentMethod> paymentMethod = [];
  var isLoading = true.obs;

  late final PaymentMethodApiController _paymentMethodApiController =
      PaymentMethodApiController();

  void getPaymentMethod({required BuildContext context}) async {
    try {
      paymentMethod = await _paymentMethodApiController.getPaymentMethod();
      isLoading.value = false;
    }catch (error) {
      showSnackBar(context, message: error.toString(),error: true);
    }
  }
}
