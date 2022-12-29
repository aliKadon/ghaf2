import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';

class AccountViewGetXController extends GetxController with Helpers {
  // vars.
  late final SharedPrefController _sharedPrefController =
      SharedPrefController();

  // logout.
  void logout({
    required BuildContext context,
  }) async {
    showLoadingDialog(context: context, title: 'Logging Out');
    await _sharedPrefController.logout();
    await Future.delayed(Duration(seconds: 1));
    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.welcomeRoute);
  }
}
