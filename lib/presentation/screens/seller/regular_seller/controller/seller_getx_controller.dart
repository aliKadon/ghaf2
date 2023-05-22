import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/seller/regular_seller_api_controller.dart';
import 'package:ghaf_application/domain/model/seller_details.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/values_manager.dart';
import '../introduce_to_subscribe.dart';

class SellerGetxController extends GetxController with Helpers {
  SellerDetails? sellerDetails;
  late final RegularSellerApiController _regularSellerApiController =
      RegularSellerApiController();

  void getSellerDetails({required BuildContext context}) async {
    try {
      sellerDetails = await _regularSellerApiController.getSellerDetails();
      print('======================seller active');
      print(sellerDetails!.active);
      _customDialogSellerStatus(context: context);
      update();

    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void _customDialogSellerStatus({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: AppSize.s206,
            width: AppSize.s306,
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.s22,
                ),
                sellerDetails!.active ==
                        'Account is not active, you have to subscribe'
                    ? Text(
                        AppLocalizations.of(context)!.progress,
                        style: TextStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s20,
                            fontWeight: FontWeight.w500),
                      )
                    : Text(
                        AppLocalizations.of(context)!.success,
                        style: TextStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s20,
                            fontWeight: FontWeight.w500),
                      ),
                SizedBox(
                  height: AppSize.s30,
                ),
                sellerDetails!.submittedFormStatusBool == 1 &&
                        sellerDetails!.active ==
                            'Account is not active, you have to subscribe'
                    ? Text(
                        AppLocalizations.of(context)!
                            .your_account_has_been_approved,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ColorManager.primary),
                      )
                    : sellerDetails!.active ==
                                'Account is not active, you have to subscribe' &&
                            sellerDetails!.submittedFormStatusBool == 0
                        ? Text(
                            AppLocalizations.of(context)!
                                .your_account_is_under_approval_proces,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorManager.primary),
                          )
                        : sellerDetails!.submittedFormStatusBool == 1 &&
                                sellerDetails!.active == 'Account is active'
                            ? Text(
                                AppLocalizations.of(context)!
                                    .your_subscription_has_been_completed,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.primary),
                              )
                            : Container(),
                SizedBox(
                  height: AppSize.s40,
                ),
                sellerDetails!.active ==
                        'Account is not active, you have to subscribe' &&
                    sellerDetails!.submittedFormStatusBool == 0
                    ? ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ColorManager.primaryDark)),
                        onPressed: () {
                          SharedPrefController().logout();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => MainView(),
                          ));
                        },
                        child: Text(AppLocalizations.of(context)!.close))
                    : sellerDetails!.submittedFormStatusBool == 1 &&
                            sellerDetails!.active == 'Account is active'
                        ? ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    ColorManager.primaryDark)),
                            onPressed: () {
                              dashboard(
                                url: 'https://www.web.ghafgate.com',
                              );
                            },
                            child: Text(
                                '${AppLocalizations.of(context)!.go_to_dashboard}'),
                          )
                        : sellerDetails!.submittedFormStatusBool == 1
                            ? ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        ColorManager.primaryDark)),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        IntroduceToSubscribe(),
                                  ));
                                },
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .subscribe_to_get_seller_services,
                                  style: TextStyle(fontSize: FontSize.s14),
                                ))
                            : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  dashboard({required String url}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
