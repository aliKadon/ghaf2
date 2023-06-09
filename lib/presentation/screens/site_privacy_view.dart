import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/account_view/account_view_getx_controller.dart';

import '../../app/preferences/shared_pref_controller.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class SitePrivacyView extends StatefulWidget {
  const SitePrivacyView({Key? key}) : super(key: key);

  @override
  State<SitePrivacyView> createState() => _SitePrivacyViewState();
}

class _SitePrivacyViewState extends State<SitePrivacyView> {
  //controller
  final AccountViewGetXController _accountViewGetXController =
      Get.put(AccountViewGetXController());

  var language = SharedPrefController().lang1;

  @override
  void initState() {
    // TODO: implement initState
    _accountViewGetXController.getPrivacyAndTerms(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AccountViewGetXController>(
        builder: (controller) => controller.isLoadingPrivacy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.038,
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Image.asset(
                                  SharedPrefController().lang1 == 'ar'
                                      ? IconsAssets.arrow2
                                      : IconsAssets.arrow,
                                  height: AppSize.s18,
                                  width: AppSize.s10,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              AppLocalizations.of(context)!.site_privacy,
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s18,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: AppSize.s12,
                        ),
                        Divider(height: 1, color: ColorManager.greyLight),
                        SizedBox(
                          height: AppSize.s17,
                        ),
                        Center(
                          child: language == 'en'
                              ? HtmlWidget(controller.privacyPolicy!.valueEn!)
                              : HtmlWidget(controller.privacyPolicy!.valueAr!!),
                          // Text(
                          //   // AppLocalizations.of(context)!.privacy_text,
                          //   controller.privacyPolicy!.valueEn!,
                          //   textAlign: TextAlign.start,
                          //   style: getRegularStyle(
                          //     color: ColorManager.grey,
                          //     fontSize: FontSize.s16,
                          //   ),
                          // ),
                        ),
                        SizedBox(
                          height: AppSize.s18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
