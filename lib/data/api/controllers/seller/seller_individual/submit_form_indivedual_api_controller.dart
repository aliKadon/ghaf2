import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';


import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:http/http.dart' as http;

import '../../../../../domain/model/api_response.dart';

class SubmitFormIndividualApiController with ApiHelper {

  late final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  Future<ApiResponse> submitForm({
    String? businessType,
    String? businessSector,
    String? BusinessName,
    String? phoneNumber,
    String? email,
    String? password,
    File? LicensePDF,
    String? AddressName,
    String? CityName,
    String? CompanyName,
    String? CountryName,
    String? PostalCode,
    String? BankName,
    String? AccountNumber,
    String? BankAddress,
    String? IBAN,
  }) async {
    var url = Uri.parse('${Constants.baseUrl}/Auth/submit-individual-form');
    Map<String, dynamic> data = {
      "businessType": businessType,
      "businessSector": businessSector,
      "BusinessName": 'aaaaa',
      "phoneNumber": phoneNumber,
      "Email": email,
      "password": password,
      "LicensePDF": await dio.MultipartFile.fromFile(LicensePDF!.path),
      "AddressName": AddressName,
      "CityName": CityName,
      "CompanyName": CompanyName,
      "CountryName": CountryName,
      "PostalCode": PostalCode,
      "BankName": BankName,
      "AccountNumber": AccountNumber,
      "BankAddress": BankAddress,
      "IBAN": IBAN,
    };
    var response = await _dio.post(
      '/Auth/submit-individual-form',
      data: FormData.fromMap(data),
      options: Options(
        headers: headers,
      ),
    );

    print('=====================submit form');
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
}
