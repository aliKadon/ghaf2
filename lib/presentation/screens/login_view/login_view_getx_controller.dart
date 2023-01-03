import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/auth_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';

class LoginViewGetXController extends GetxController with Helpers {
  // constructor fields.
  final BuildContext context;

  // constructor.
  LoginViewGetXController({
    required this.context,
  });

  // vars.
  late final AuthApiController _authApiController = AuthApiController();
  late final GlobalKey<FormState> formKey = GlobalKey();

  late final errorMessageLoginApiResponse;
  late final errorMessageProfileApiResponse;


  // fields.
  String? userName;
  String? password;

  // login.
  void login() async {

    try {

      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      showLoadingDialog(context: context, title: 'Logging In');
      final ApiResponse loginApiResponse = await _authApiController.login(
        userName: userName!,
        password: password!,
      );
      print('HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII');
      errorMessageLoginApiResponse = loginApiResponse.message;


      ApiResponse profileApiResponse = await AuthApiController().profile();
      errorMessageProfileApiResponse = profileApiResponse.message;
      if (loginApiResponse.status == 200 && profileApiResponse.status == 200) {
        // success.
        Navigator.pop(context);
        if (AppSharedData.currentUser!.role == Constants.roleRegisterCustomer) {
          if (AppSharedData.currentUser!.active!) {
            Navigator.pushReplacementNamed(context, Routes.mainRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.subscribeRoute);
          }
        } else {
          Navigator.pushReplacementNamed(context, Routes.submitForm);
        }
      } else {
        // failed.
        Navigator.pop(context);
        showSnackBar(context, message: loginApiResponse.message);
        showSnackBar(context, message: profileApiResponse.message, error: true);
      }
    } catch (error) {
      // error.
      // Navigator.pop(context);
      // showSnackBar(context, message: error.toString(), error: true);
      print(error.toString());

      // if (errorMessageLoginApiResponse != null) {
      //   showSnackBar(context, message: errorMessageLoginApiResponse, error: true);
      //
      // }else {
      //   showSnackBar(context, message: errorMessageProfileApiResponse, error: true);
      //
      // }

    }
  }
}
