import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/wallet_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/payment_history.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/transaction.dart';

class WalletGetxController extends GetxController with Helpers {
  late final WalletApiController _walletApiController = WalletApiController();

  late ApiResponse apiResponse;
  late ApiResponse apiResponse1;
  List<PaymentHistory> paymentsHistory = [];
  num balance = 0;

  void getMyWalletBalance({required BuildContext context}) async {
    try {
      balance = await _walletApiController.getMyWalletBalance();
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString());
    }
  }

  void topUp(
      {required BuildContext context,
      required String paymentMethodId,
      required num amount}) async {
    try {
      apiResponse = await _walletApiController.topUp(
          paymentMethodId: paymentMethodId, amount: amount);
      update();
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => TransactionScreen(),
      ));
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void sharePoint(
      {required BuildContext context,
      required String email,
      required int amount}) async {
    try {
      apiResponse1 =
          await _walletApiController.sharePoints(email: email, amount: amount);
      update();
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => TransactionScreen(),
      ));
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void getPaymentHistory ({required BuildContext context}) async {
    try {
      paymentsHistory = await _walletApiController.getPaymentHistory();
      update();
    }catch(error) {
      showSnackBar(context, message: error.toString());
    }
  }
}
