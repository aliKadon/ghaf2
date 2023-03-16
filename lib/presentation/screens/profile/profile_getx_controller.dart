
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/user_details_api_controller.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/subscribe_view_getx_controller.dart';

import '../../../domain/model/api_response.dart';

class ProfileGetxController extends GetxController with Helpers {
  // final BuildContext context;
  // ProfileGetxController({required this.context})

  late ApiResponse apiResponse;
  late final UserDetailsApiController _userDetailsApiController = UserDetailsApiController();

  void changePassword(
      {required BuildContext context, required String oldPassword,
        required String newPassword,
        required String confirmPassword}) async {
    try {
      apiResponse = await _userDetailsApiController.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword);
      Navigator.of(context).pushReplacement(CupertinoDialogRoute(
          builder: (context) => MainView(), context: context));
      showSnackBar(context, message: apiResponse.message);
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
