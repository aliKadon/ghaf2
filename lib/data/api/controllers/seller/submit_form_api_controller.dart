import 'package:dio/dio.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/data/api/api_settings.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

class SubmitFormApiController with ApiHelper {
  late final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  // submit form.
  Future<ApiResponse> submitForm({
    required String storeName,
    required String phoneNumber,
    required String website,
    required String socialMediaAccount,
    required bool isInUAE,
    required String businessLicenceNumber,
    required int numberOfBranches,
    required String addressName,
    required String addressLat,
    required String addressLong,
    required String addressCity,
    required String addressCountry,
    required MultipartFile licencePDF,
  }) async {
    print('send request : submit-application-form');
    Map<String, dynamic> data = {
      "storeName": storeName,
      "phoneNumber": phoneNumber,
      "webSite": website,
      "SocialMediaAccount": socialMediaAccount,
      "isInUAE": isInUAE.toString(),
      "businessLicenseNumber": businessLicenceNumber,
      "numberOfBranches": numberOfBranches.toString(),
      "storeAddress.addressName": addressName,
      "storeAddress.altitude": addressLat,
      "storeAddress.longitude": addressLong,
      "storeAddress.CityName": addressCity,
      "storeAddress.CountryName": addressCountry,
      "storeAddress.BuildingOrStreetName" : '11',
      "storeAddress.VillaOrApprtmentNumber" : '11',
      "storeAddress.Phone" : phoneNumber,
      "LicensePDF": licencePDF,
    };
    print(data);
    var response = await _dio.post(
      '/auth/submit-application-form',
      data: FormData.fromMap(data),
      options: Options(
        headers: headers,
      ),
    );
    print('============================================');
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return ApiResponse(
          message: response.data['message'],
          status: response.data['status'],
        );
      }else if(response.data['status'] == 500){
        return ApiResponse(
          message: response.data['message'],
          status: response.data['status'],
        );
      }
    }
    return failedResponse;
  }

  // subscribe as free.
  Future<ApiResponse> subscribeAsFree() async {
    print('send request : customer-subscripe-for-free');
    var response = await _dio.post(
      'Auth/customer-subscripe-for-free',
      options: Options(
        headers: headers,
      ),
    );
    print('============================================');
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return ApiResponse(
          message: response.data['message'],
          status: response.data['status'],
        );
      }
    }
    return failedResponse;
  }

  // cancel subscription.
  Future<ApiResponse> cancelSubscription() async {
    print('send request : customer-cancel-subscribtion');
    var response = await _dio.post(
      'Auth/customer-cancel-subscribtion',
      options: Options(
        headers: headers,
      ),
    );
    print('============================================');
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return ApiResponse(
          message: response.data['message'],
          status: response.data['status'],
        );
      }
    }
    return failedResponse;
  }
}
