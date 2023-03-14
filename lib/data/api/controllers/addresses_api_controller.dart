import 'package:dio/dio.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/data/api/api_settings.dart';
import 'package:ghaf_application/domain/model/address.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

class AddressesApiController with ApiHelper {
  late final Dio _dio = Dio(BaseOptions(baseUrl: ApiSettings.baseUrl));

  // add address.
  Future<ApiResponse> addAddress({
    required String addressName,
    required String lat,
    required String long,
    required String phoneNumber,
    required String villaOrApprtmentNumber,
    required String buildingOrStreetName,
    required String cityName,
    required String countryName,
  }) async {
    // print('send request : add-user-address');
    Map<String, dynamic> data = {
      "addressName": addressName,
      "altitude": lat,
      "longitude": long,
      "phone": phoneNumber,
      "villaOrApprtmentNumber":villaOrApprtmentNumber,
      "buildingOrStreetName" : buildingOrStreetName,
      "cityName": cityName,
      "countryName" : countryName,
    };
    // print(data);
    var response = await _dio.post(
      '/Auth/add-user-address',
      data: data,
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
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

  // edit address.
  Future<ApiResponse> editAddress({
    String? addressId,
    String? addressName,
    String? lat,
    String? long,
    String? phoneNumber,
  }) async {
    // print('send request : update-user-address');
    Map<String, dynamic> queryParameters = {
      "id": addressId,
      "name": addressName,
      "al": lat,
      "lo": long,
      "phone": phoneNumber,
    };
    // print(queryParameters);
    var response = await _dio.post(
      '/Auth/update-user-address',
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
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

  // delete address.
  Future<ApiResponse> deleteAddress({
    required String addressId,
  }) async {
    // print('send request : delete-user-address');
    Map<String, dynamic> queryParameters = {
      "id": addressId,
    };
    // print(queryParameters);
    var response = await _dio.post(
      '/Auth/delete-user-address',
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
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

  // get my addresses.
  Future<List<Address>> getMyAddresses() async {
    // print('send request : get-user-address');
    var response = await _dio.get(
      '/Auth/get-user-address',
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return List<Address>.from(
            response.data["data"].map((x) => Address.fromJson(x)));
      }
    }
    return [];
  }
}
