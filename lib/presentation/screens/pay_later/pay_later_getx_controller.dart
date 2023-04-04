import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/pay_later_api_controller.dart';

import '../../../domain/model/pay_later.dart';

class PayLaterGetxController extends GetxController with Helpers {

  List<PayLater> payLater = [];
  num? totalCredit;
  final PayLaterApiController _payLaterApiController = PayLaterApiController();

  void getCustomerInstallments({required BuildContext context}) async{
    try {
      payLater = await _payLaterApiController.getCustomerInstallments();
      totalCredit = await _payLaterApiController.totalCredit;
      update();
    }catch(error) {
      showSnackBar(context, message: error.toString(),error: true);
    }
  }
}