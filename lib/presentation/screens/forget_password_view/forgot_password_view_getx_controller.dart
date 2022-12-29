import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/auth_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';

class ForgotPasswordViewGetXController extends GetxController with Helpers {
  // constructor fields.
  final BuildContext context;

  // constructor.
  ForgotPasswordViewGetXController({
    required this.context,
  });

  // vars.
  late final AuthApiController _authApiController = AuthApiController();
  late final GlobalKey<FormState> formKey = GlobalKey();

  // fields.
  String? email;

  // forgot password.
  void forgotPassword() async {
    try {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      showLoadingDialog(context: context, title: 'Sending');
      final ApiResponse apiResponse = await _authApiController.forgotPassword(
        email: email!,
      );
      if (apiResponse.status == 200) {
        // success.
        showSnackBar(context, message: apiResponse.message, error: false);
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.resetPassword);
      } else {
        // failed.
        Navigator.pop(context);
        showSnackBar(context, message: apiResponse.message, error: true);
      }
    } on DioError catch (error) {
      // error.
      debugPrint(error.response?.data());
      Navigator.pop(context);
      showSnackBar(context, message: error.toString(), error: true);
    } catch (error) {
      // error.
      debugPrint(error.toString());
      Navigator.pop(context);
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
