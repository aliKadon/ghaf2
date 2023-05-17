import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/internet_checking/no_internet_screen.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetCheckerGetxController extends GetxController {
  bool isInitialConnection = true;

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // void startMonitoringConnectivity({required GlobalKey<NavigatorState> navigatorKey}) {
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     if (result == ConnectivityResult.none) {
  //       print('==================== no internet');
  //       navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => NoInternetScreen(),));
  //       // No internet connection
  //     } else {
  //       print('==================== Internet connection is available');
  //       // Internet connection is available
  //     }
  //   });
  // }

  void startMonitoringConnectivity(
      {required GlobalKey<NavigatorState> navigatorKey}) async {
    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        print('==================== no internet1');

        // No internet connection

      } else {
        print('==================== Internet connection is available1');

        // Internet connection is available
      }

      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{
        if (isInitialConnection) {
          isInitialConnection = false;
          return;
        }

        print('=======================result');
        print(result);

        if (result == ConnectivityResult.none) {
          // No internet connection

          print('==================== no internet');

          navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
            builder: (context) => NoInternetScreen(),
          ));

          // Update your app state accordingly (e.g., show an error message, disable certain features)

        } else {
          print('==================== Internet connection is available');
          var isDeviceConnected = false;

          isDeviceConnected =
              await InternetConnectionCheckerPlus().hasConnection;
          if (isDeviceConnected) {
            print('==================== Internet connection is available3');

          }else {
            print('==================== no Internet3');
            navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
              builder: (context) => NoInternetScreen(),
            ));

          }

          // Internet connection is available

          // Update your app state accordingly (e.g., hide the error message, enable features)

        }
      });
    });
  }
}
