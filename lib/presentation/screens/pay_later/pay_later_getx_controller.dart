import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/pay_later_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/pay_later_produc.dart';

import '../../../domain/model/pay_later_installment.dart';

class PayLaterGetxController extends GetxController with Helpers {
  List<PayLaterInstallment> payLaterInstallments = [];
  List<PayLaterProduct> payLaterProducts = [];
  List<PayLaterProduct> payLaterProductActive = [];
  List<PayLaterProduct> payLaterProductComplete = [];
  num? totalCredit;
  var isLoading = true;
  late ApiResponse apiResponse;
  final PayLaterApiController _payLaterApiController = PayLaterApiController();


  void getCustomerPayLaterProduct({required BuildContext context}) async {
    try {
      payLaterProducts = await _payLaterApiController.getCustomerPayLaterProduct();
      for(PayLaterProduct payLaterProduct in payLaterProducts) {
        if (payLaterProduct.active!) {
          payLaterProductActive.add(payLaterProduct);
        }else {
          payLaterProductComplete.add(payLaterProduct);
        }
      }
      update();
    }catch (e) {
      showSnackBar(context, message: e.toString(),error: true);
    }
  }

  void getCustomerInstallments({required BuildContext context,required String id}) async {
    try {
      payLaterInstallments = await _payLaterApiController.getCustomerInstallments(id: id);
      totalCredit = await _payLaterApiController.totalCredit;
      isLoading = false;
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
