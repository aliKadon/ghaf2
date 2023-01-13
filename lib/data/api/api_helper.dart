import 'dart:io';

import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';

import '../../domain/model/api_response.dart';

mixin ApiHelper {
  ApiResponse get failedResponse =>
      ApiResponse(message: 'something went wrong, try again!', status: 500);

  Map<String, String> get headers {
    return {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.contentTypeHeader: 'application/json',
      // HttpHeaders.acceptHeader: 'application/json; charset=UTF-8',
    };
  }

  Map<String, String> get headers1 {
    return {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.contentTypeHeader: ' application/octet-stream',
      // HttpHeaders.acceptHeader: 'application/json; charset=UTF-8',
    };
  }
}
