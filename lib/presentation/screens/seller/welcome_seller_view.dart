import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class WelcomeSellerView extends StatefulWidget {
  const WelcomeSellerView({Key? key}) : super(key: key);

  @override
  State<WelcomeSellerView> createState() => _WelcomeSellerViewState();
}

class _WelcomeSellerViewState extends State<WelcomeSellerView> {


  Location location = new Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? locationData;

  var isLoading = true;

  void getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('latitude', locationData!.latitude!);
    prefs.setDouble('longitude', locationData!.longitude!);

    if (locationData!.latitude != null) {
      isLoading = false;
    }
    print('===========================location');
    print(locationData!.latitude);
  }

  @override
  void initState() {
    getLocation();
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
            height: AppSize.s206,
            width: AppSize.s206,
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
              onPressed: () {

                Navigator.pushNamed(
                  context, Routes.registerRoute,
                  arguments: {
                    'role': 'Seller',
                    'locationLat': locationData?.latitude,
                    'locationLong': locationData?.longitude,
                  }

                  );

                } ,
              child: Text(
                AppLocalizations.of(context)!.register_create_account,
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
              onPressed: () => Navigator.pushNamed(
                  context, Routes.registeraition,
                  arguments: 'IndividualSeller'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.transparent,
                elevation: 0,
                side: BorderSide(
                  color: ColorManager.primaryDark,
                  width: AppSize.s1,
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.register_payment_link,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
