import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/seller/submit_form_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import '../../account_view/account_view_getx_controller.dart';

class SubmitFormViewGetXController extends GetxController with Helpers {
  // notifiable.
  File? _licencePDFFile;

  File? get licencePDFFile => _licencePDFFile;

  late final AccountViewGetXController _accountViewGetXController =
  Get.put(AccountViewGetXController());
  set licencePDFFile(File? value) {
    _licencePDFFile = value;
    update(['licencePDFFile']);
  }

  // constructor fields.
  final BuildContext context;

  // constructor.
  SubmitFormViewGetXController({
    required this.context,
  });

  // vars.
  late final SubmitFormApiController _submitFormApiController =
      SubmitFormApiController();
  late final GlobalKey<FormState> formKey = GlobalKey();
  late final LatLng latLng = const LatLng(31.5180304, 34.430782);
  LatLng? selectedLatLng;

  // fields.
  late String storeName;
  late String phoneNumber;
  late String website;
  late String socialMediaAccount;
  late bool isInUAE;
  late String businessLicenceNumber;
  late int numberOfBranches;
  late String addressName;
  late dio.MultipartFile licencePDF;

  // submit form.
  void submitForm() async {
    try {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      if (selectedLatLng == null) {
        showSnackBar(context,
            message: 'Please select address on map', error: true);
        return;
      }
      if (licencePDFFile == null) {
        showSnackBar(context, message: 'Licence PDF is required', error: true);
        return;
      }
      showLoadingDialog(context: context, title: 'Submitting');
      final ApiResponse apiResponse = await _submitFormApiController.submitForm(
        phoneNumber: phoneNumber,
        addressLat: selectedLatLng!.latitude.toString(),
        addressLong: selectedLatLng!.longitude.toString(),
        addressName: addressName,
        businessLicenceNumber: businessLicenceNumber,
        isInUAE: isInUAE,
        numberOfBranches: numberOfBranches,
        socialMediaAccount: socialMediaAccount,
        storeName: storeName,
        website: website,
        licencePDF: await dio.MultipartFile.fromFile(licencePDFFile!.path),
      );
      print('object=======================${apiResponse.status}');
      if (apiResponse.status == 200) {
        // success.
        Navigator.pop(context);
        showSnackBar(context, message: apiResponse.message, error: false);
        Navigator.pushReplacementNamed(context, Routes.subscriptionSellerRoute);
      } else if (apiResponse.status == 500) {
        Navigator.pop(context);
        _customDialogProgress(apiResponse.message);
      } else{
        // failed.
        debugPrint('failed : ${apiResponse.message}');
        Navigator.pop(context);
        showSnackBar(context, message: apiResponse.message, error: true);
      }
    } on DioError catch (error) {
      // error.
      debugPrint(error.response?.data.toString());
      Navigator.pop(context);
      showSnackBar(context, message: 'An Error Occurred, Please Try again', error: true);
    } catch (error) {
      // error.
      debugPrint('error : ${'An Error Occurred, Please Try again'}');
      Navigator.pop(context);
      showSnackBar(context, message: 'An Error Occurred, Please Try again', error: true);
    }
  }

  // pick pdf file.
  void pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      licencePDFFile = File(result.files.single.path!);
    }
  }

  void _customDialogProgress(String message) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s306,
              width: AppSize.s306,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s10,
                    ),

                    GestureDetector(
                      onTap: () {
                        _accountViewGetXController.logout(context: context);
                      },
                      child: Container(
                        width: AppSize.s110,
                        height: AppSize.s38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryDark,
                          borderRadius:
                          BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          'Ok',
                          textAlign: TextAlign.center,
                          style:
                          getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }
}
