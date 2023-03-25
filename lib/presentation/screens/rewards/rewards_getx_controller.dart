import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/redeem_api_controller.dart';

import '../../../domain/model/redeem.dart';

class RewardsGetxController extends GetxController with Helpers {
  Redeem? redeemHistory;
  var isLoadingHistory = true;

  late final RedeemApiController _redeemApiController = RedeemApiController();

  void getRedeemHistory({required BuildContext context}) async {

    redeemHistory = await _redeemApiController.getRedeemHistory();
    isLoadingHistory = false;
    update();

    // try {
    //   redeemHistory = (await _redeemApiController.getRedeemHistory())!;
    //   isLoadingHistory = false;
    //   update();
    // }catch(error) {
    //   showSnackBar(context, message: error.toString(),error: true);
    // }
  }
}