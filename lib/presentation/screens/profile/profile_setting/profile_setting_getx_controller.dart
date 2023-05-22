import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';

import '../../../../app/utils/helpers.dart';
import '../../../../data/api/controllers/user_details_api_controller.dart';
import '../../../../domain/model/user.dart';
import '../../seller/individual_seller/products_with_out_details_seller_view.dart';

class ProfileSettingGetxController extends GetxController with Helpers {
  late final UserDetailsApiController _userDetailsApiController =
      UserDetailsApiController();

  late User userDetails;

  var isLoading = true;

  late ApiResponse apiResponse;

  void init({required BuildContext context}) {
    getUserDetails(context);
  }

  void getUserDetails(BuildContext context) async {
    try {
      await _userDetailsApiController.getUserDetails(context: context);
      isLoading = false;
    } catch (error) {
      // showSnackBar(context, message: error.toString(),error: true);
      print('==============================error subscribe');
      print(error);
    }
  }

  void editUserDetails(
      {required BuildContext context,
      required String firstName,
      required String lastName,
      required String telephone}) async {
    try {
      apiResponse = await _userDetailsApiController.updateUserDetails(
          context: context,
          firstName: firstName,
          lastName: lastName,
          telephone: telephone);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainView(),
      ));

      showSnackBar(context, message: apiResponse.message);
    } catch (error) {
      showSnackBar(context, message: error.toString());
    }
  }

  void editUserDetailsSeller(
      {required BuildContext context,
        required String firstName,
        required String lastName,
        required String telephone}) async {
    try {
      apiResponse = await _userDetailsApiController.updateUserDetails(
          context: context,
          firstName: firstName,
          lastName: lastName,
          telephone: telephone);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ProductsWithOutDetailsSellerView(),
      ));
      showSnackBar(context, message: apiResponse.message);
    } catch (error) {
      showSnackBar(context, message: error.toString());
    }
  }
}
