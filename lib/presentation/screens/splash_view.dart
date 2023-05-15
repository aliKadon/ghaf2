import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/screens/internet_checking/no_internet_screen.dart';

import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/services/firebase_messaging_service.dart';
import 'package:ghaf_application/services/local_notifications_service.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  // checking the internet connection
  // Map _source = {ConnectivityResult.none: false};
  // final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  // String string = '';


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
    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => MainView(),));


    bool result = await InternetConnectionChecker().hasConnection;
    print('=======================check internet');
    print(result);
    if(result == true) {
      print('YAY! Free cute dog pics!');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainView(),));
    } else {
      print('No internet :( Reason:');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NoInternetScreen(),));
      // print(InternetConnectionChecker().lastTryResults);
    }

    // checking the internet connection
    // _networkConnectivity.myStream.listen((source) {
    //   _source = source;
    //   print('source $_source');
    //   // 1.
    //   print('======================connection network');
    //   print(ConnectivityResult.wifi);
    //   switch (_source.keys.toList()[0]) {
    //     case ConnectivityResult.mobile:
    //       Navigator.of(context).pushReplacement(
    //           MaterialPageRoute(builder: (context) => MainView(),));
    //       break;
    //     case ConnectivityResult.wifi:
    //       Navigator.of(context).pushReplacement(
    //           MaterialPageRoute(builder: (context) => MainView(),));
    //       break;
    //     case ConnectivityResult.none:
    //     default:
    //       string = 'Offline';
    //   }
    // });



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
  void _handleMessage(RemoteMessage message) {
    Navigator.of(context).pushNamed(Routes.aboutAppRoute);
  }

  @override
  void initState() {

    super.initState();
    // _networkConnectivity.initialise();
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
