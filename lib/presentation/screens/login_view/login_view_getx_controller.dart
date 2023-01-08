
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/auth_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/services/firebase_messaging_service.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewGetXController extends GetxController with Helpers {
  // constructor fields.
  final BuildContext context;

  // constructor.
  LoginViewGetXController({
    required this.context,
  });

  // vars.
  late final AuthApiController _authApiController = AuthApiController();
  late final GlobalKey<FormState> formKey = GlobalKey();

  // late final errorMessageLoginApiResponse;
  // late final errorMessageProfileApiResponse;

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

    if( locationData!.latitude != null) {
      isLoading = false;
    }
    print('===========================location');
    print(locationData!.latitude);
  }


  // fields.
  String? userName;
  String? password;
  FirebaseMessagingService? firebaseMessagingService;

  // login.
  void login() async {

    // if (!formKey.currentState!.validate()) return;
    // formKey.currentState!.save();
    // showLoadingDialog(context: context, title: 'Logging In');
    // final ApiResponse loginApiResponse = await _authApiController.login(
    //   userName: userName!,
    //   password: password!,
    // );
    // ApiResponse profileApiResponse = await AuthApiController().profile();

    try {

      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      showLoadingDialog(context: context, title: 'Logging In');
      final ApiResponse loginApiResponse = await _authApiController.login(
        userName: userName!,
        password: password!,
      );
      print('HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII');
      // errorMessageLoginApiResponse = loginApiResponse.message;


      ApiResponse profileApiResponse = await AuthApiController().profile();
      // errorMessageProfileApiResponse = profileApiResponse.message;
      if (loginApiResponse.status == 200 && profileApiResponse.status == 200) {
        print('=======================================role');
        print(AppSharedData.currentUser!.role);
        // success.
        Navigator.pop(context);
        if (AppSharedData.currentUser!.role == Constants.roleRegisterCustomer) {

          if (AppSharedData.currentUser!.active!) {
            Navigator.pushReplacementNamed(context, Routes.mainRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.subscribeRoute);
          }
        } else if (AppSharedData.currentUser!.role == Constants.roleRegisterSeller) {
          Navigator.pushReplacementNamed(context, Routes.submitForm,arguments: locationData);
        }else {
          if (AppSharedData.currentUser!.active!) {
            Navigator.pushReplacementNamed(context, Routes.registerPaymentLinkSellerRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.paymentLinkSubscriptionSellerRoute);


          }

        }
      } else {
        // failed.
        Navigator.pop(context);
        showSnackBar(context, message: loginApiResponse.message,error: true);
        showSnackBar(context, message: profileApiResponse.message, error: true);
      }
    } catch (error) {
      // error.
      // Navigator.pop(context);
      // showSnackBar(context, message: loginApiResponse.message, error: true);
      // showSnackBar(context, message: profileApiResponse.message, error: true);
      showSnackBar(context, message: 'Un Error Occurred', error: true);

      print(error.toString());

      // if (errorMessageLoginApiResponse != null) {
      //   showSnackBar(context, message: errorMessageLoginApiResponse, error: true);
      //
      // }else {
      //   showSnackBar(context, message: errorMessageProfileApiResponse, error: true);
      //
      // }

    }
  }
}
