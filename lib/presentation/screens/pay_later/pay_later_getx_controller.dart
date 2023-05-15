import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/pay_later_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/pay_later_produc.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';

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

  var daysBetweenInstallments = 0;

  void calculateTheDaysBetweenInstallments(
      {required String firstDate, required String secondDate}) {
    final subStringFirstDate = firstDate.substring(0, 10);
    final first = DateTime.parse(subStringFirstDate);

    final subStringSecondDate = secondDate.substring(0, 10);
    final second = DateTime.parse(subStringSecondDate);

    // final regex = RegExp(r'^(.*)-(.*)-(.*)$');
    // final firstMatch = regex.firstMatch('2024-05-06');
    // final firstYear = firstMatch?.group(1);
    // final firstMonth = firstMatch?.group(2);
    // final firstDay = firstMatch?.group(3);
    // final secondMatch = regex.firstMatch(subStringSecondDate);
    // final secondYear = secondMatch?.group(1);
    // final secondMonth = secondMatch?.group(2);
    // final secondDay = secondMatch?.group(3);

    daysBetweenInstallments = second.difference(first).inDays;

    // String firstYear = firstDate.substring(0,firstDate.indexOf('_'));
    // String firstMonth =
  }

  void getCustomerPayLaterProduct({required BuildContext context}) async {
    try {
      payLaterProducts =
          await _payLaterApiController.getCustomerPayLaterProduct();
      for (PayLaterProduct payLaterProduct in payLaterProducts) {
        if (payLaterProduct.active!) {
          payLaterProductActive
              .removeWhere((m) => m.groupId == payLaterProduct.groupId);
          payLaterProductActive.add(payLaterProduct);
        } else {
          payLaterProductComplete
              .removeWhere((m) => m.groupId == payLaterProduct.groupId);
          payLaterProductComplete.add(payLaterProduct);
        }
      }
      update();
    } catch (e) {
      showSnackBar(context, message: e.toString(), error: true);
    }
  }

  void getCustomerInstallments(
      {required BuildContext context, required String id}) async {
    try {
      payLaterInstallments =
          await _payLaterApiController.getCustomerInstallments(id: id);
      totalCredit = await _payLaterApiController.totalCredit;
      isLoading = false;
      calculateTheDaysBetweenInstallments(
          firstDate: payLaterInstallments[0].installmentDate!,
          secondDate: payLaterInstallments[0].installmentDate!);
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
      showLoadingDialog(context: context, title: 'loading...');
      apiResponse = await _payLaterApiController.payForInstallment(
          paymentMethodId: paymentMethodId, productId: productId);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainView(),
      ));
      showSnackBar(context, message: apiResponse.message);
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
