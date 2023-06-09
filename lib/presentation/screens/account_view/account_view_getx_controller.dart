import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/auth_api_controller.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';

import '../../../domain/model/privacy_policy.dart';
import '../../../domain/model/social-medial-accounts.dart';

class AccountViewGetXController extends GetxController with Helpers {


  // vars.
  late final SharedPrefController _sharedPrefController =
      SharedPrefController();
  PrivacyPolicy? privacyPolicy;
  SocialMediaAccounts? socialMediaAccounts;
  bool isLoadingPrivacy = true;

  final AuthApiController _authApiController = AuthApiController();

  // logout.
  void logout({
    required BuildContext context,
  }) async {
    showLoadingDialog(context: context, title: 'Logging Out');
    await _sharedPrefController.logout();
    await Future.delayed(Duration(seconds: 1));
    Navigator.pop(context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainView(),
        ));
  }

  void getPrivacyAndTerms({required BuildContext context}) async {
    try {
      privacyPolicy = await _authApiController.getPrivacyAndTerms();
      isLoadingPrivacy = false;
      update();
    }catch (e) {
      showSnackBar(context, message: e.toString(),error: true);
    }
  }

  void getSocialMediaAccounts({required BuildContext context}) async {
    try {
      socialMediaAccounts = await _authApiController.getSocialMediaAccounts();
      update();
    }catch (e) {
      showSnackBar(context, message: e.toString(),error: true);
    }
  }

}
