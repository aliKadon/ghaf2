import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/services/firebase_messaging_service.dart';
import 'package:ghaf_application/services/local_notifications_service.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    // init firebase.
    await Firebase.initializeApp();
    await FirebaseMessagingService.instance.init();
    await LocalNotificationsService.instance.init();
    //
    SharedPrefController().getUser();
    if (AppSharedData.currentUser != null) {
      if (AppSharedData.currentUser!.role == Constants.roleRegisterCustomer)
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      else if (AppSharedData.currentUser!.sellerSubmittedForm!)
        Navigator.pushReplacementNamed(context, Routes.subscriptionSellerRoute);
      else
        Navigator.pushReplacementNamed(context, Routes.submitForm);
    } else {
      if (SharedPrefController().getDisplayOnBoarding())
        Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
      else
        Navigator.pushReplacementNamed(context, Routes.welcomeRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(ImageAssets.bgSplash), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.logo1,
              width: AppSize.s132,
              height: AppSize.s148,
            ),
            SizedBox(
              height: AppSize.s62,
            ),
            Text(
              AppLocalizations.of(context)!.click_and_get,
              style: getSemiBoldStyle(
                color: ColorManager.primaryDark,
                fontSize: FontSize.s24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
