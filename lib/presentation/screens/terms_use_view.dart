import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../app/preferences/shared_pref_controller.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'account_view/account_view_getx_controller.dart';

class TermsOfUseView extends StatefulWidget {
  const TermsOfUseView({Key? key}) : super(key: key);

  @override
  State<TermsOfUseView> createState() => _TermsOfUseViewState();
}

class _TermsOfUseViewState extends State<TermsOfUseView> {
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
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p16),
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
                              AppLocalizations.of(context)!.terms_of_use,
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
                        language == 'en'
                            ? HtmlWidget(
                                controller.privacyPolicy!.termsAndConditionsEn!)
                            : HtmlWidget(controller
                                .privacyPolicy!.termsAndConditionsAr!),
                        // Text(
                        //   '${AppLocalizations.of(context)!.terms}',
                        //   textAlign: TextAlign.start,
                        //   style: getRegularStyle(
                        //     color: ColorManager.grey,
                        //     fontSize: FontSize.s16,
                        //   ),
                        // ),
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
