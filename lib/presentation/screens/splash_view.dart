import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';

import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/services/firebase_messaging_service.dart';
import 'package:ghaf_application/services/local_notifications_service.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 7), _goNext);
  }

  // LocationData? locationData;
  _goNext() async {
    // init firebase.
    await Firebase.initializeApp();
    await FirebaseMessagingService.instance.init(context: context);
    await LocalNotificationsService.instance.init();
    //
    SharedPrefController().getUser();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainView(),));
    // if (AppSharedData.currentUser != null) {
    //   if (AppSharedData.currentUser!.role == Constants.roleRegisterCustomer) {
    //     Navigator.pushReplacementNamed(context, Routes.mainRoute);
    //   } else if (AppSharedData.currentUser!.role ==
    //           Constants.roleRegisterIndividual &&
    //       AppSharedData.currentUser!.active == true) {
    //     Navigator.pushReplacementNamed(context, Routes.mainSellerRoute);
    //   } else if (AppSharedData.currentUser!.role ==
    //         Constants.roleRegisterIndividual &&
    //     AppSharedData.currentUser!.active == false) {
    //   Navigator.pushReplacementNamed(
    //       context, Routes.paymentLinkSubscriptionSellerRoute);
    // } else if (AppSharedData.currentUser!.role ==
    //         Constants.roleRegisterSeller &&
    //     AppSharedData.currentUser!.sellerSubmittedForm == false) {
    //   Navigator.pushReplacementNamed(context, Routes.submitForm, arguments: {
    //     'locationLat': 24.400661,
    //     'locationLong': 54.635448,
    //   });
    // } else if (AppSharedData.currentUser!.role ==
    //       Constants.roleRegisterSeller &&
    //       AppSharedData.currentUser!.sellerSubmittedForm == true && AppSharedData.currentUser!.active == true ){
    //     Navigator.pushReplacementNamed(context, Routes.sellerStatus,arguments: 'Seller');
    //
    // } else if (AppSharedData.currentUser!.role ==
    //       Constants.roleRegisterSeller &&
    //       AppSharedData.currentUser!.sellerSubmittedForm == true && AppSharedData.currentUser!.active == false){
    //     Navigator.pushReplacementNamed(context, Routes.subscriptionSellerRoute);
    //   } }else
    //   else if (AppSharedData.currentUser!.sellerSubmittedForm!)
    //     Navigator.pushReplacementNamed(context, Routes.subscriptionSellerRoute);
    //   else
    //     Navigator.pushReplacementNamed(context, Routes.submitForm,arguments:{
    //       'locationLat': 24.400661,
    //       'locationLong': 54.635448,
    //     });
    // } else
    //
    // {
    //   if (SharedPrefController().getDisplayOnBoarding())
    //     Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    //   else
    //     Navigator.pushReplacementNamed(context, Routes.welcomeRoute);
    // }
  }
  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer.open(Audio('assets/images/sound.mp3'));
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
              image: ExactAssetImage(ImageAssets.bgSplashtap),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.bgSplashScreen,

            ),
            // SizedBox(
            //   height: AppSize.s62,
            // ),
            // Text(
            //   '    ${AppLocalizations.of(context)!.click_and_get}',
            //   style: getSemiBoldStyle(
            //     color: ColorManager.primaryDark,
            //     fontSize: FontSize.s26,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
