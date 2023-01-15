import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../providers/language_provider.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class LanguageStore extends StatefulWidget {
  const LanguageStore({Key? key}) : super(key: key);

  @override
  State<LanguageStore> createState() => _LanguageStoreState();
}

class _LanguageStoreState extends State<LanguageStore> {


  Locale? local;

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
                  onTap: () =>  Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
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
                ElevatedButton(onPressed: (){
                  curLocale.setLocale(Locale('ar'));
                  SharedPrefController().changeLanguage(language: 'ar');
                  print(SharedPrefController().lang1);
                  Navigator.pop(context);
                  // Navigator.of(context).pushReplacementNamed(Routes.productsWithOutDetailsSellerRoute);
                }, child: Text(AppLocalizations.of(context)!.arabic)),
                Spacer(),
                ElevatedButton(onPressed: (){
                  curLocale.setLocale( Locale('en'));
                  print(SharedPrefController().lang1);
                  SharedPrefController().changeLanguage(language: 'en');
                  Navigator.pop(context);
                  // Navigator.of(context).pushReplacementNamed(Routes.productsWithOutDetailsSellerRoute);
                }, child: Text(AppLocalizations.of(context)!.english)),
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
