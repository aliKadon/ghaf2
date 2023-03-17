import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/wallet_api_controller.dart';

class WalletGetxController extends GetxController with Helpers {

  late final WalletApiController _walletApiController = WalletApiController();

  var balance = 0;

  void getMyWalletBalance({required BuildContext context}) async{
    try {
      balance = await _walletApiController.getMyWalletBalance();
      update();
    }catch (error) {
      showSnackBar(context, message: error.toString());
    }
  }
}