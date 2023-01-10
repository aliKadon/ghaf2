import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/auth_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

class ResetPasswordViewGetXController extends GetxController with Helpers {
  // constructor fields.
  final BuildContext context;

  // constructor.
  ResetPasswordViewGetXController({
    required this.context,
  });

  // vars.
  late final AuthApiController _authApiController = AuthApiController();
  late final GlobalKey<FormState> formKey = GlobalKey();

  // fields.
  String? code;
  String? newPassword;
  String? confirmPassword;

  // reset password.
  void resetPassword() async {
    try {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      if (code == null) {
        showSnackBar(context,
            message: 'Enter verification code please', error: true);
        return;
      }
      showLoadingDialog(context: context, title: 'Resetting');
      final ApiResponse apiResponse = await _authApiController.resetPassword(
        code: code!,
        password: newPassword!,
        confirmPassword: confirmPassword!,
      );
      if (apiResponse.status == 200) {
        // success.
        showSnackBar(context, message: apiResponse.message, error: false);
        Navigator.pop(context);
        Navigator.pop(context);
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
      showSnackBar(context, message: 'An Error Occurred, Please Try again', error: true);
    }
  }
}
