import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                ),

                Spacer(),
                Text(
                  'Language',
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
                'Select Your Language',
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
                  Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
                }, child: Text('Arabic')),
                Spacer(),
                ElevatedButton(onPressed: (){
                  curLocale.setLocale( Locale('en'));
                  print(SharedPrefController().lang1);
                  SharedPrefController().changeLanguage(language: 'en');
                  Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
                }, child: Text('English')),
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
