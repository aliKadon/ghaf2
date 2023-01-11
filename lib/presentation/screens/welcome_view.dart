
import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:location/location.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {



  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageAssets.logo2,
            fit: BoxFit.fill,
            height: AppSize.s263,
            width: AppSize.s263,
          ),
          SizedBox(
            height: AppSize.s148,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppMargin.m16,
            ),
            width: double.infinity,
            height: AppSize.s55,
            child: ElevatedButton(
              onPressed: () =>Navigator.pushReplacementNamed(context, Routes.registerRoute,arguments:
                {
                  'role': 'Customer',
                  'locationLat': 24.400661,
                  'locationLong': 54.635448,
                }

              ),
              child: Text(
                AppLocalizations.of(context)!.create_account,
                style: getSemiBoldStyle(
                    color: ColorManager.white, fontSize: FontSize.s18),
              ),
            ),
          ),
          SizedBox(
            height: AppSize.s26,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppMargin.m16,
            ),
            width: double.infinity,
            height: AppSize.s55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.transparent,
                elevation: 0,
                side: BorderSide(
                  color: ColorManager.primaryDark,
                  width: AppSize.s1,
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.login,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s18),
              ),
            ),
          ),
          SizedBox(
            height: AppSize.s148,
          ),

          // ElevatedButton(onPressed:() {_customDialogProgress();}, child: Text('an')),
        ],
      ),
    );
  }

}
