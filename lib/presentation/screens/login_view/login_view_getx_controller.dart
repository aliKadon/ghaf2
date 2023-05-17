import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/auth_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/screens/seller/regular_seller/controller/seller_getx_controller.dart';
import 'package:ghaf_application/services/firebase_messaging_service.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../seller/individual_seller/payment_link_subscription_seller_view.dart';
import '../seller/individual_seller/products_with_out_details_seller_view.dart';
import '../seller/individual_seller/register_payment_link_seller/register_payment_link_seller_view.dart';

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

  // late final errorMessageLoginApiResponse;
  // late final errorMessageProfileApiResponse;

  late final SellerGetxController _sellerGetxController =
      Get.put(SellerGetxController());

  var isLoading = true;

  // fields.
  String? userName;
  String? password;
  FirebaseMessagingService? firebaseMessagingService;

  // login.
  void login({required BuildContext context}) async {
    // if (!formKey.currentState!.validate()) return;
    // formKey.currentState!.save();
    // showLoadingDialog(context: context, title: 'Logging In');
    // final ApiResponse loginApiResponse = await _authApiController.login(
    //   userName: userName!,
    //   password: password!,
    // );
    // ApiResponse profileApiResponse = await AuthApiController().profile();

    try {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      showLoadingDialog(context: context, title: 'Logging In');
      final ApiResponse loginApiResponse = await _authApiController.login(
        userName: userName!,
        password: password!,
      );

      if (loginApiResponse.status == 200) {
        ApiResponse profileApiResponse = await AuthApiController().profile();
        // print('=======================================role');
        // print(AppSharedData.currentUser!.role);
        // success.
        Navigator.pop(context);
        print('======================current user');
        print(AppSharedData.currentUser?.role);
        print(AppSharedData.currentUser!.individualSellerSubmittedForm);
        print(AppSharedData.currentUser!.active);
        if (AppSharedData.currentUser!.role == Constants.roleRegisterCustomer) {
          if (AppSharedData.currentUser!.active!) {
            Navigator.pushReplacementNamed(context, Routes.mainRoute);
          } else {
            // Navigator.pushReplacementNamed(
            //     context, Routes.subscribeFromHomePage);
            Navigator.pushReplacementNamed(context, Routes.mainRoute);
          }
        } else if (AppSharedData.currentUser!.role ==
            Constants.roleRegisterSeller) {
          if (AppSharedData.currentUser!.sellerSubmittedForm! == false) {
            Navigator.of(context)
                .pushNamed(Routes.submitForm, arguments: {'': 20.222});
          } else {
            _sellerGetxController.getSellerDetails(context: context);
            // Navigator.pushReplacementNamed(context, Routes.sellerStatus,
            //         arguments: profileApiResponse.message)
            //     .then((value) => ScaffoldMessenger.of(context)
            //         .showSnackBar(SnackBar(content: Text('success'))));
          }
        } else if (AppSharedData.currentUser!.role ==
            Constants.roleRegisterIndividual) {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => AddItem2SellerView(true),));
          if (AppSharedData.currentUser!.individualSellerSubmittedForm ==
              false) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => RegisterPaymentLinkSellerView(),
            ));
          } else if (AppSharedData.currentUser!.individualSellerSubmittedForm ==
                  true &&
              AppSharedData.currentUser!.active == false) {
            print('========================you need to subscribe');
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => PaymentLinkSubscriptionSellerView(),
            ));
          } else if (AppSharedData.currentUser!.individualSellerSubmittedForm ==
                  true &&
              AppSharedData.currentUser!.active == true) {
            print('========================add item');
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProductsWithOutDetailsSellerView(),
            ));
          }
        }
      } else if (loginApiResponse.status >= 400) {
        Navigator.pop(context);
        _customDialogProgress(
            loginApiResponse.message, loginApiResponse.status,context);
      }else {
        Navigator.pop(context);
        _customDialogProgress(
            loginApiResponse.message, loginApiResponse.status,context);
      }

      // else {
      //   // failed
      //   _customDialogProgress();
      //   // Navigator.pop(context);
      //   // showSnackBar(context, message: loginApiResponse.message, error: true);
      //   // showSnackBar(context, message: profileApiResponse.message, error: true);
      // }
    } catch (error) {
      // error.
      Navigator.pop(context);
      // showSnackBar(context, message: loginApiResponse.message, error: true);
      // showSnackBar(context, message: profileApiResponse.message, error: true);

      showSnackBar(context,
          message: 'An Error Occurred, Please Try again', error: true);

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

  void _customDialogProgress(String message, int status,BuildContext context) async {
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
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    status == 400
                        ? Container(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.check_your_email,
                              textAlign: TextAlign.center,
                              style: getMediumStyle(
                                  color: ColorManager.red,
                                  fontSize: FontSize.s16),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
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
                          'Ok',
                          textAlign: TextAlign.center,
                          style: getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }

  void _customDialogSellerStatus() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: AppSize.s306,
            width: AppSize.s306,
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.success,
                  style: TextStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: AppSize.s22,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
