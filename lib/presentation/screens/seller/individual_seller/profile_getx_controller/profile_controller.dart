import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

import '../../../../../data/api/controllers/seller/seller_individual/individual_seller_api_controller.dart';

class ProfileController extends GetxController with Helpers {

  late ApiResponse apiResponse;
  final IndividualSellerApiController _individualSellerApiController = IndividualSellerApiController();

  void getSellerDetails({required BuildContext context}) async {
    try {
      apiResponse = await _individualSellerApiController.getSellerDetails();
      update();
    }catch (e) {
      showSnackBar(context, message: e.toString(),error: true);
    }
  }
}