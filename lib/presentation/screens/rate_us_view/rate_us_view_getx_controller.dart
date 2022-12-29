import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/app_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

class RateUsViewGetXController extends GetxController with Helpers {
  // vars.
  late final AppApiController _appApiController = AppApiController();
  late final GlobalKey<FormState> formKey = GlobalKey();

  // constructor fields.
  final BuildContext context;

  // fields.
  String? description;
  int rate = 1;

  // constructor.
  RateUsViewGetXController({
    required this.context,
  });

  // review app.
  void reviewApp() async {
    try {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      showLoadingDialog(context: context, title: 'Sending');
      final ApiResponse apiResponse = await _appApiController.reviewApp(
        description: description!,
        rate: rate!,
      );
      if (apiResponse.status == 200) {
        // success.
        showSnackBar(context, message: apiResponse.message, error: false);
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        // failed.
        Navigator.pop(context);
        showSnackBar(context, message: apiResponse.message, error: true);
      }
    } catch (error) {
      // error.
      Navigator.pop(context);
      debugPrint(error.toString());
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
