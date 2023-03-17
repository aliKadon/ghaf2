import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../app/utils/helpers.dart';
import '../../../../data/api/controllers/user_details_api_controller.dart';
import '../../../../domain/model/user.dart';

class ProfileSettingGetxController extends GetxController with Helpers {
  late final UserDetailsApiController _userDetailsApiController =
      UserDetailsApiController();

  late User userDetails;

  var isLoading = true;

  void init({
    required BuildContext context
  }) {
    getUserDetails(context);
  }



  void getUserDetails (BuildContext context) async{
    try {
      await _userDetailsApiController.getUserDetails(context: context);
      isLoading = false;
    }catch(error) {
      showSnackBar(context, message: error.toString());
    }

  }

  void editUserDetails(
      {required BuildContext context,
      required String firstName,
      required String lastName,
      required String telephone}) async {
    try {
      await _userDetailsApiController.updateUserDetails(context: context,
          firstName: firstName, lastName: lastName, telephone: telephone);
    } catch (error) {
      showSnackBar(context, message: error.toString());
    }
  }
}
