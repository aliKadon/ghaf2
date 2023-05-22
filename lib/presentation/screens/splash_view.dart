import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/screens/internet_checking/no_internet_screen.dart';

import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/payment_link_subscription_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/products_with_out_details_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/register_payment_link_seller/register_payment_link_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/regular_seller/controller/seller_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/seller/regular_seller/subscription_seller_view.dart';
import 'package:ghaf_application/services/firebase_messaging_service.dart';
import 'package:ghaf_application/services/local_notifications_service.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../app/constants.dart';
import '../../app/utils/app_shared_data.dart';
import '../../data/api/controllers/auth_api_controller.dart';
import '../../domain/model/api_response.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import 'internet_checking/controller/internet_checker.dart';


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

  late final InternetCheckerGetxController _internetCheckerGetxController =
  Get.put(InternetCheckerGetxController());
  late final SellerGetxController _sellerGetxController =
  Get.put(SellerGetxController());

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();




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

      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainView(),));
      print('======================current user');
      print(AppSharedData.currentUser);
      print(AppSharedData.currentUser?.role);
      print(AppSharedData.currentUser?.individualSellerSubmittedForm);
      print(AppSharedData.currentUser?.active);
      print(AppSharedData.currentUser?.sellerSubmittedForm);
    if (AppSharedData.currentUser == null) {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    }else
      if (AppSharedData.currentUser!.role == Constants.roleRegisterCustomer) {
        if (AppSharedData.currentUser!.active!) {
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubscriptionSellerView(),));
        } else {
          // Navigator.pushReplacementNamed(
          //     context, Routes.subscribeFromHomePage);
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubscriptionSellerView(),));

        }
      } else if (AppSharedData.currentUser!.role ==
          Constants.roleRegisterSeller) {
        if (AppSharedData.currentUser!.sellerSubmittedForm! == false) {
          Navigator.of(context)
              .pushNamed(Routes.submitForm, arguments: {'': 20.222});
        } else {
          // _sellerGetxController.getSellerDetails(context: context);
          Navigator.pushReplacementNamed(context, Routes.sellerStatus,)
              .then((value) => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('success'))));
        }
      } else if (AppSharedData.currentUser!.role ==
          Constants.roleRegisterIndividual) {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => AddItem2SellerView(true),));
        if (AppSharedData.currentUser!.individualSellerSubmittedForm ==
            false) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => RegisterPaymentLinkSellerView(),
          ));
        } else if (AppSharedData.currentUser!.individualSellerSubmittedForm ==
            true &&
            AppSharedData.currentUser!.active == false) {
          print('========================you need to subscribe');
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PaymentLinkSubscriptionSellerView(),
          ));
        } else if (AppSharedData.currentUser!.individualSellerSubmittedForm ==
            true &&
            AppSharedData.currentUser!.active == true) {
          print('========================add item');
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ProductsWithOutDetailsSellerView(),
          ));
        }
      }
    } else {
      print('No internet :( Reason:');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NoInternetScreen(),));
      // print(InternetConnectionChecker().lastTryResults);
    }
    _internetCheckerGetxController.startMonitoringConnectivity(navigatorKey: navigatorKey);


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
