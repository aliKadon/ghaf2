import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/review_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

class ReviewGetxController extends GetxController with Helpers {
  late final ReviewApiController _reviewApiController = ReviewApiController();

  late ApiResponse apiResponse;

  void addAppReview(
      {required BuildContext context,
      required String description,
      required num points}) async {
    try {
      apiResponse = await _reviewApiController.addAppReview(
          description: description, points: points);
      showSnackBar(context, message: apiResponse.message);
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void addShopReview(
      {required BuildContext context,
        required String StoreId,
        required String description,
        required num points}) async {
    try {
      showLoadingDialog(context: context, title: 'Sending');
      apiResponse = await _reviewApiController.addStoreReview(storeId: StoreId,
          opinion: description, points: points);
      if(apiResponse.status == 200) {
        Navigator.of(context).pop();
        showSnackBar(context, message: apiResponse.message);
      }else {
        Navigator.of(context).pop();
        showSnackBar(context, message: apiResponse.message,error: true);
      }

    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
