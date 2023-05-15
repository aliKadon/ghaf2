import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';

import '../../resources/values_manager.dart';
import '../splash_view.dart';

class NoInternetScreen extends StatefulWidget {
  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool _doubleBackToExitPressedOnce = false;

  Future<bool> _onWillPop() async {
    if (_doubleBackToExitPressedOnce) {
      return true;
    }

    _doubleBackToExitPressedOnce = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Press back again to exit')),
    );

    Timer(Duration(seconds: 2), () {
      _doubleBackToExitPressedOnce = false;
    });

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s20,
            ),
            Image.asset(
              ImageAssets.connectionLost,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 1,
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Text(
                AppLocalizations.of(context)!.no_internet_connection,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorManager.primaryDark,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.s14),
              ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            Container(
              width: AppSizeWidth.s206,
              height: AppSize.s60,
              child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SplashView(),
                    ));
                  },
                  child: Text(AppLocalizations.of(context)!.try_again)),
            )
          ],
        ),
      ),
    );
  }
}
