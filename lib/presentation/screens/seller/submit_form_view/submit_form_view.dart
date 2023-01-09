
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/register_view/register_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/seller/submit_form_view/submit_form_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SubmitFormView extends StatefulWidget {

  final Map<String,dynamic> locationData;
  // // const SubmitFormView({Key? key}) : super(key: key);
  SubmitFormView(this.locationData);

  @override
  State<SubmitFormView> createState() => _SubmitFormViewState();
}

class _SubmitFormViewState extends State<SubmitFormView> with Helpers {
  // controller.
  late final SubmitFormViewGetXController _submitFormViewGetXController =
      Get.find<SubmitFormViewGetXController>();


  // Location location = new Location();
  // bool? _serviceEnabled;
  // PermissionStatus? _permissionGranted;
  // LocationData? locationData;
  //
  // var isLoading = true;
  //
  // void getLocation() async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled!) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled!) {
  //       return;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   locationData = await location.getLocation();
  //
  //   if( locationData!.latitude != null) {
  //     isLoading = false;
  //   }
  //   print('===========================location');
  //   print(locationData!.latitude);
  // }
  double? latitude;
  double? longitude;

  Future<void> getLocation () async {
    final prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble('latitude') ?? 24.400661;
    longitude = prefs.getDouble('longitude') ?? 54.635448;
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  // @override
  // Future<void> initState() {
  //   // getLocation();
  //   // Timer(Duration(seconds: 7), () {
  //   //   setState(() {
  //   //     isLoading = false;
  //   //   });
  //   // });
  //
  //
  //
  //   super.initState();
  // }

  // dispose.
  @override
  void dispose() {
    Get.delete<RegisterViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // isLoading ? Center(
      //   child: CircularProgressIndicator(
      //     strokeWidth: 1,
      //   ),
      // ):
      SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _submitFormViewGetXController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppSize.s9,
                ),
                Text(
                  'Submit Form',
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s24),
                ),
                SizedBox(
                  height: AppSize.s31,
                ),
                Image.asset(
                  ImageAssets.logo2,
                  fit: BoxFit.fill,
                  height: AppSize.s92,
                  width: AppSize.s82,
                ),
                SizedBox(
                  height: AppSize.s32,
                ),
                AppTextField(
                  hint: 'Store Name',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Store name is required';
                    return null;
                  },
                  onSaved: (value) {
                    _submitFormViewGetXController.storeName = value!;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p16,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.phone_number,
                      hintStyle: getMediumStyle(
                        color: ColorManager.hintTextFiled,
                      ),
                      filled: false,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: AppPadding.p18, horizontal: AppPadding.p4),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r10),
                        borderSide: BorderSide(
                          width: AppSize.s1,
                          color: ColorManager.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r10),
                        borderSide: BorderSide(
                          width: AppSize.s1,
                          color: ColorManager.grey,
                        ),
                      ),
                      prefixIcon: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: AppSize.s15,
                            ),
                            Image.asset(
                              ImageAssets.uaeFlag,
                              fit: BoxFit.fill,
                              height: AppSize.s34,
                              width: AppSize.s34,
                            ),
                            SizedBox(
                              width: AppSize.s15,
                            ),
                            Container(
                              height: double.infinity,
                              width: AppSize.s1,
                              color: ColorManager.grey,
                            ),
                            SizedBox(
                              width: AppSize.s15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Phone number is required';
                      return null;
                    },
                    onSaved: (value) {
                      _submitFormViewGetXController.phoneNumber = value!;
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                AppTextField(
                  hint: 'Website',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Website is required';
                    return null;
                  },
                  onSaved: (value) {
                    _submitFormViewGetXController.website = value!;
                  },
                ),
                AppTextField(
                  hint: 'Social Media Account',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Social media account is required';
                    return null;
                  },
                  onSaved: (value) {
                    _submitFormViewGetXController.socialMediaAccount = value!;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: AppMargin.m16,
                      right: AppMargin.m16,
                      left: AppMargin.m16),
                  child: DropdownButtonFormField<bool>(
                    items: ['Yes', 'No']
                        .map(
                          (e) => DropdownMenuItem<bool>(
                            child: Text(
                              e.toString(),
                              style: getMediumStyle(
                                color: ColorManager.hintTextFiled,
                              ),
                            ),
                            value: e == 'Yes',
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      _submitFormViewGetXController.isInUAE = value!;
                    },
                    decoration: InputDecoration(
                      hintText: 'Is your company registered in the UAE',
                      hintStyle: getMediumStyle(
                        color: ColorManager.hintTextFiled,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p16, vertical: AppPadding.p16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                        borderSide: BorderSide(
                          width: AppSize.s1,
                          color: ColorManager.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                        borderSide: BorderSide(
                          width: AppSize.s1,
                          color: ColorManager.grey,
                        ),
                      ),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    validator: (value) {
                      if (value == null) return 'This field is required';
                      return null;
                    },
                  ),
                ),
                AppTextField(
                  hint: 'Business License Number',
                  textInputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Business license number is required';
                    return null;
                  },
                  onSaved: (value) {
                    _submitFormViewGetXController.businessLicenceNumber =
                        value!;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: AppMargin.m16,
                      right: AppMargin.m16,
                      left: AppMargin.m16),
                  child: DropdownButtonFormField<int>(
                    items: [1, 2, 3, 4, 5]
                        .map(
                          (e) => DropdownMenuItem<int>(
                            child: Text(
                              e.toString(),
                              style: getMediumStyle(
                                color: ColorManager.hintTextFiled,
                              ),
                            ),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      _submitFormViewGetXController.numberOfBranches = value!;
                    },
                    decoration: InputDecoration(
                      hintText: 'Number Of Branches',
                      hintStyle: getMediumStyle(
                        color: ColorManager.hintTextFiled,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p16, vertical: AppPadding.p16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                        borderSide: BorderSide(
                          width: AppSize.s1,
                          color: ColorManager.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                        borderSide: BorderSide(
                          width: AppSize.s1,
                          color: ColorManager.grey,
                        ),
                      ),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    validator: (value) {
                      if (value == null)
                        return 'Number of branches is required';
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'The branches can be added later aftere gistration is complete',
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                GetBuilder<SubmitFormViewGetXController>(
                  id: 'licencePDFFile',
                  builder: (controller) => Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                onTap:
                                    _submitFormViewGetXController.pickPdfFile,
                                hint: 'Upload PDF',
                              ),
                            ),
                            InkWell(
                              onTap: _submitFormViewGetXController.pickPdfFile,
                              child: Container(
                                height: double.infinity,
                                width: 50.w,
                                margin: EdgeInsets.only(
                                  bottom: AppMargin.m16,
                                  right: AppMargin.m16,
                                ),
                                padding: EdgeInsets.all(8.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: ColorManager.grey,
                                  ),
                                ),
                                child: Icon(
                                  Icons.drive_folder_upload,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (controller.licencePDFFile != null) ...[
                        Row(
                          children: [
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              'Pdf file attached successfully',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                AppTextField(
                  hint: 'Shop Address',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Shop Address is required';
                    return null;
                  },
                  onSaved: (value) {
                    _submitFormViewGetXController.addressName = value!;
                  },
                ),
                Container(
                  height: 200.h,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.locationData['location'].latitude ?? 24.400661, widget.locationData['location'].longitude ?? 54.635448),
                      zoom: 17,
                    ),
                    gestureRecognizers: {
                      Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer()),
                      Factory<ScaleGestureRecognizer>(
                          () => ScaleGestureRecognizer()),
                      Factory<TapGestureRecognizer>(
                          () => TapGestureRecognizer()),
                      Factory<VerticalDragGestureRecognizer>(
                          () => VerticalDragGestureRecognizer())
                    },
                    markers: _submitFormViewGetXController.selectedLatLng ==
                            null
                        ? {}
                        : {
                            Marker(
                              markerId: MarkerId('address'),
                              position:
                                  _submitFormViewGetXController.selectedLatLng!,
                            )
                          },
                    onTap: (latLng) async {
                      setState(() {
                        _submitFormViewGetXController.selectedLatLng = latLng;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s55,
                  child: ElevatedButton(
                    onPressed: _submitFormViewGetXController.submitForm,
                    child: Text(
                      'Submit',
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
