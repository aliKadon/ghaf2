
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/user_details_api_controller.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/products_with_out_details_seller_view.dart';

import '../../../domain/model/api_response.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

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

  void changePasswordSeller(
      {required BuildContext context, required String oldPassword,
        required String newPassword,
        required String confirmPassword}) async {
    try {
      apiResponse = await _userDetailsApiController.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword);
      Navigator.of(context).pushReplacement(CupertinoDialogRoute(
          builder: (context) => ProductsWithOutDetailsSellerView(), context: context));
      showSnackBar(context, message: apiResponse.message);
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void deleteAccount({required BuildContext context}) async {
    try {
      // apiResponse = await _userDetailsApiController.deleteAccount();

      _deleteDialog(context: context);
      // Navigator.of(context).pushReplacement(CupertinoDialogRoute(
      //     builder: (context) => MainView(), context: context));
      // showSnackBar(context, message: apiResponse.message);
    } catch (error) {
      // showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void deleteAccountInsidePup({required BuildContext context}) async {
    try {
      apiResponse = await _userDetailsApiController.deleteAccount();
      if(apiResponse.status == 200) {
        SharedPrefController().logout();
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(CupertinoDialogRoute(
            builder: (context) => MainView(), context: context));
        showSnackBar(context, message: apiResponse.message);
      }
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void deleteAccountSeller({required BuildContext context}) async {
    try {
      _deleteDialog(context: context);
      // apiResponse = await _userDetailsApiController.deleteAccount();
      // Navigator.of(context).pushReplacement(CupertinoDialogRoute(
      //     builder: (context) => MainView(), context: context));
      // showSnackBar(context, message: apiResponse.message);
    } catch (error) {
      // showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void deleteAccountSellerInsidePup({required BuildContext context}) async {
    try {
      apiResponse = await _userDetailsApiController.deleteAccount();
      if(apiResponse.status == 200) {
        SharedPrefController().logout();
        Navigator.of(context).pushReplacement(CupertinoDialogRoute(
            builder: (context) => MainView(), context: context));
        showSnackBar(context, message: apiResponse.message);
      }
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void _deleteDialog({required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s306,
              width: AppSize.s306,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: AppSize.s28,
                    // ),
                    Image.asset(
                      ImageAssets.logo2,
                      height: AppSize.s130,
                      width: AppSize.s130,
                    ),
                    SizedBox(
                      height: AppSize.s5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.are_you_sure_delete_account,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s20),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     '${deliveryMethod}\n${paymentMethod}\n${address}',
                    //     textAlign: TextAlign.center,
                    //     style: getMediumStyle(
                    //         color: ColorManager.primaryDark,
                    //         fontSize: FontSize.s14),
                    //   ),
                    // ),
                    // status == 400
                    //     ? Container(
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     AppLocalizations.of(context)!.check_your_email,
                    //     textAlign: TextAlign.center,
                    //     style: getMediumStyle(
                    //         color: ColorManager.red,
                    //         fontSize: FontSize.s16),
                    //   ),
                    // )
                    //     :
                    Container(),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showLoadingDialog(context: context,title: 'Loading..');
                            deleteAccountInsidePup(context: context);

                            // Navigator.of(context).pop();
                          },
                          child: Container(
                            width: AppSize.s110,
                            height: AppSize.s38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.primaryDark,
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.yes,
                              textAlign: TextAlign.center,
                              style: getMediumStyle(color: ColorManager.white),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSize.s10,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();

                            // Navigator.of(context).pop();
                          },
                          child: Container(
                            width: AppSize.s110,
                            height: AppSize.s38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.primaryDark,
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.no,
                              textAlign: TextAlign.center,
                              style: getMediumStyle(color: ColorManager.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          );
        });
  }
}
