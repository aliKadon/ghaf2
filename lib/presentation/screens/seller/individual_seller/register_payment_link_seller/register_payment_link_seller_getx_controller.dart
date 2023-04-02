import 'dart:io';
import 'dart:typed_data';


import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/seller/seller_individual/submit_form_indivedual_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/presentation/screens/login_view/login_view.dart';

import '../../../../../app/constants.dart';

class RegisterPaymentLinkSellerGetxController extends GetxController
    with Helpers {
  late ApiResponse apiResponse;
  late SubmitFormIndividualApiController _submitFormIndividualApiController =
      SubmitFormIndividualApiController();


  File _licencePDFFile = File('/path/to/default/file.pdf');

  File get licencePDFFile => _licencePDFFile;

  set licencePDFFile(File? value) {
    _licencePDFFile = value!;
    update(['licencePDFFile']);
  }

  // pick pdf file.
  void pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      licencePDFFile = File(result.paths.first!);
    }
  }

  void submitForm({
    required BuildContext context,
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

    try {
      apiResponse = await _submitFormIndividualApiController.submitForm(
          phoneNumber: phoneNumber,
          email: email,
          AccountNumber: AccountNumber,
          AddressName: AddressName,
          BankAddress: BankAddress,
          BankName: BankName,
          BusinessName: BusinessName,
          businessSector: businessSector,
          businessType: businessType,
          CityName: CityName,
          CompanyName: CompanyName,
          CountryName: CountryName,
          IBAN: IBAN,
          LicensePDF: LicensePDF,
          password: password,
          PostalCode: PostalCode);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginView(role: ''),));
      showSnackBar(context, message: apiResponse.message);
    }catch (error) {
      showSnackBar(context, message: error.toString(),error: true);
    }
  }
}
