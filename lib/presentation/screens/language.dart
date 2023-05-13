import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:provider/provider.dart';

import '../../app/get/language_getx_controller.dart';
import '../../providers/language_provider.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  Locale? local;
  final LanguageGetXController languageGetXController =
  Get.put<LanguageGetXController>(LanguageGetXController());

  @override
  Widget build(BuildContext context) {
    final curLocale = Provider.of<LocaleProvider>(context, listen: false);
    String activeLang = curLocale.locale.languageCode;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(Routes.mainRoute),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.038,
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  AppLocalizations.of(context)!.language,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s24),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            Container(
              child: Image.asset('assets/images/language.png'),
            ),
            Center(
              child: Text(
                AppLocalizations.of(context)!.select_language,
                style: getSemiBoldStyle(
                    color: ColorManager.primary, fontSize: FontSize.s24),
              ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            Row(
              children: [
                SizedBox(
                  width: AppSize.s60,
                ),
                ElevatedButton(
                    onPressed: () {

                      curLocale.setLocale(Locale('ar'));
                      // SharedPrefController().changeLanguage(language: 'ar');
                      print(SharedPrefController().lang1);
                      // Navigator.of(context)
                      //     .pushReplacementNamed(Routes.mainRoute);
                      languageGetXController.changeLanguage(language1: 'ar');
                    },
                    child: Text(AppLocalizations.of(context)!.arabic)),
                Spacer(),
                ElevatedButton(
                    onPressed: () {

                      curLocale.setLocale(Locale('en'));
                      print(SharedPrefController().lang1);
                      // SharedPrefController().changeLanguage(language: 'en');
                      // Navigator.of(context)
                      //     .pushReplacementNamed(Routes.mainRoute);
                      languageGetXController.changeLanguage(language1: 'en');
                    },
                    child: Text(AppLocalizations.of(context)!.english)),
                SizedBox(
                  width: AppSize.s60,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
