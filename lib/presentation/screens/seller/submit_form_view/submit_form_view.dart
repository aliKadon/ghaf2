import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import '../../account_view/account_view_getx_controller.dart';
import '../../main_view.dart';

class SubmitFormView extends StatefulWidget {
  late final Map<String, dynamic> locationData;

  // // const SubmitFormView({Key? key}) : super(key: key);
  SubmitFormView(this.locationData);

  @override
  State<SubmitFormView> createState() => _SubmitFormViewState();
}

class _SubmitFormViewState extends State<SubmitFormView> with Helpers {
  // controller.
  late final SubmitFormViewGetXController _submitFormViewGetXController =
      Get.find<SubmitFormViewGetXController>();

  late final AccountViewGetXController _accountViewGetXController =
      Get.put(AccountViewGetXController());

  late Placemark place;
  String city = '';
  String country = '';
  var agree = false;
  var agree1 = false;
  var option1 = '';
  var option2 = '';


  // #############################################
  //get all information from latitude and longitude
  // #############################################
  Future<void> GetAddressFromLatLong(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    print('======================================my address');
    print(placemarks);
    place = placemarks[0];
    city = '${place.locality}';
    country = '${place.country}';
    // _addressTextController.text =
    // '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print('================myaddress');
    print(place.country);
  }

  // ##############################################
  // ##############################################
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

  Future<void> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble('latitude') ?? 24.400661;
    longitude = prefs.getDouble('longitude') ?? 54.635448;
  }

  @override
  void initState() {
    getLocation();
    print('====================================location');
    print('location : ${widget.locationData['locationLat']}');
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

  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SharedPrefController().logout();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainView(),
        ));
        return false;
      },
      child: Scaffold(
        body: SafeArea(
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
                    AppLocalizations.of(context)!.submit_form,
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
                    width: AppSize.s92,
                  ),
                  SizedBox(
                    height: AppSize.s32,
                  ),
                  AppTextField(
                    hint: AppLocalizations.of(context)!.store_name,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return AppLocalizations.of(context)!
                            .store_name_is_required;
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
                            vertical: AppPadding.p18, horizontal: AppPadding
                            .p4),
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
                              Text('+971', style: TextStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                              // Image.asset(
                              //   ImageAssets.uaeFlag,
                              //   fit: BoxFit.fill,
                              //   height: AppSize.s34,
                              //   width: AppSize.s34,
                              // ),
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
                          return AppLocalizations.of(context)!
                              .phone_number_is_required;
                        else if (value[0] == '0' && (value.length > 10 || value.length < 10)){
                          return AppLocalizations.of(context)!.wrong_phone_number;
                        }

                        else if (value[0] != '0'  && (value.length < 9 || value.length > 9)){

                          return AppLocalizations.of(context)!.wrong_phone_number;
                        }

                        return null;
                      },
                      onSaved: (value) {
                        if(value![0] == '0') {
                          var number = value.substring(1,value.length);
                          _submitFormViewGetXController.phoneNumber = '00971${number}';
                        }else {
                          _submitFormViewGetXController.phoneNumber = '00971${value}';
                        }
                      },
                    ),

                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: AppPadding.p16,
                  //   ),
                  //   child: TextFormField(
                  //     keyboardType: TextInputType.number,
                  //     textInputAction: TextInputAction.next,
                  //     textAlign: TextAlign.start,
                  //     style: getMediumStyle(
                  //       color: ColorManager.black,
                  //       fontSize: FontSize.s14,
                  //     ),
                  //     decoration: InputDecoration(
                  //       hintText: AppLocalizations.of(context)!.phone_number,
                  //       hintStyle: getMediumStyle(
                  //         color: ColorManager.hintTextFiled,
                  //       ),
                  //       filled: false,
                  //       contentPadding: EdgeInsets.symmetric(
                  //           vertical: AppPadding.p18, horizontal: AppPadding.p4),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(AppRadius.r10),
                  //         borderSide: BorderSide(
                  //           width: AppSize.s1,
                  //           color: ColorManager.grey,
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(AppRadius.r10),
                  //         borderSide: BorderSide(
                  //           width: AppSize.s1,
                  //           color: ColorManager.grey,
                  //         ),
                  //       ),
                  //       prefixIcon: IntrinsicHeight(
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             SizedBox(
                  //               width: AppSize.s15,
                  //             ),
                  //             Image.asset(
                  //               ImageAssets.uaeFlag,
                  //               fit: BoxFit.fill,
                  //               height: AppSize.s34,
                  //               width: AppSize.s34,
                  //             ),
                  //             SizedBox(
                  //               width: AppSize.s15,
                  //             ),
                  //             Container(
                  //               height: double.infinity,
                  //               width: AppSize.s1,
                  //               color: ColorManager.grey,
                  //             ),
                  //             SizedBox(
                  //               width: AppSize.s15,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty)
                  //         return AppLocalizations.of(context)!
                  //             .phone_number_is_required;
                  //       return null;
                  //     },
                  //     onSaved: (value) {
                  //       _submitFormViewGetXController.phoneNumber = value!;
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    height: AppSize.s16,
                  ),
                  AppTextField(
                    hint: AppLocalizations.of(context)!.website,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return AppLocalizations.of(context)!.website_is_required;
                      return null;
                    },
                    onSaved: (value) {
                      _submitFormViewGetXController.website = value!;
                    },
                  ),
                  AppTextField(
                    hint: AppLocalizations.of(context)!.social_media_account,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return AppLocalizations.of(context)!
                            .social_media_is_required;
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
                      items: [
                        AppLocalizations.of(context)!.yes,
                        AppLocalizations.of(context)!.no
                      ]
                          .map(
                            (e) => DropdownMenuItem<bool>(
                              child: Text(
                                e.toString(),
                                style: getMediumStyle(
                                  color: ColorManager.hintTextFiled,
                                ),
                              ),
                              value: e == AppLocalizations.of(context)!.yes,
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        _submitFormViewGetXController.isInUAE = value!;
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!
                            .is_company_registered_in_uae,
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
                          return AppLocalizations.of(context)!.field_required;
                        return null;
                      },
                    ),
                  ),
                  AppTextField(
                    hint: AppLocalizations.of(context)!.business_license_number,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return AppLocalizations.of(context)!
                            .busniss_number_required;
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
                        hintText: AppLocalizations.of(context)!.number_branch,
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
                          return AppLocalizations.of(context)!.number_of_branches;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      AppLocalizations.of(context)!.branch_can_added,
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
                                  hint: AppLocalizations.of(context)!.upload_pdf,
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
                                  padding: EdgeInsets.all(AppSize.s8.h),
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
                                AppLocalizations.of(context)!.pdf_attach_success,
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
                    hint: AppLocalizations.of(context)!.shop_address,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return AppLocalizations.of(context)!
                            .shop_address_is_required;
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
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          SharedPrefController().locationLat,
                          SharedPrefController().locationLong,
                        ),
                        zoom: 13,
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
                      markers: {
                        Marker(
                            visible: true,
                            markerId: MarkerId('source'),
                            flat: true,
                            position:
                                _submitFormViewGetXController.selectedLatLng ??
                                    LatLng(SharedPrefController().locationLat,
                                        SharedPrefController().locationLong))
                      },
                      onTap: (latLng) {
                        setState(() {
                          print(
                              '================================================latLng');
                          print(latLng);
                          _submitFormViewGetXController.selectedLatLng = latLng;
                          GetAddressFromLatLong(latLng);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(
                    // onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            activeColor: ColorManager.primary,
                            value: 'Agree',
                            onChanged: (n) {
                              setState(() {
                                agree = !agree;
                                option1 = n!;
                              });
                              print('--------------------------------agree');
                              print(agree);
                            },
                            groupValue: option1),
                        // Text(
                        //   AppLocalizations.of(context)!
                        //       .i_agree_to_the_terms_of_service,
                        //   style: getRegularStyle(
                        //       color: ColorManager.grey, fontSize: FontSize.s16),
                        // ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Text(
                                AppLocalizations.of(context)!.text1_submit_form_seller,
                                overflow: TextOverflow.clip,
                                style: getRegularStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s12),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.s18,),
                  GestureDetector(
                    // onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            activeColor: ColorManager.primary,
                            value: 'Agree1',
                            onChanged: (n) {
                              setState(() {
                                agree1 = !agree1;
                                option2 = n!;
                              });
                              print('--------------------------------agree');
                              print(agree1);
                            },
                            groupValue: option2),
                        // Text(
                        //   AppLocalizations.of(context)!
                        //       .i_agree_to_the_terms_of_service,
                        //   style: getRegularStyle(
                        //       color: ColorManager.grey, fontSize: FontSize.s16),
                        // ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Text(
                                AppLocalizations.of(context)!.text2_submit_form_seller,
                                overflow: TextOverflow.clip,
                                style: getRegularStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s12),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.s18,),

                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppMargin.m16,
                    ),
                    width: double.infinity,
                    height: AppSize.s55,
                    child: ElevatedButton(
                      onPressed: () {
                        _submitFormViewGetXController.submitForm(
                            city: city, country: country);
                        if(agree && agree1) {

                        }else {

                        }

                      },
                      child: Text(
                        AppLocalizations.of(context)!.next,
                        style: getSemiBoldStyle(
                            color: ColorManager.white, fontSize: FontSize.s18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s16,
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(
                  //     horizontal: 110,
                  //   ),
                  //   child: ElevatedButton(
                  //       onPressed: () {
                  //         _customDialogSubscriptionExit(context);
                  //       },
                  //       child: Text(AppLocalizations.of(context)!.cancel)),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _customDialogSubscriptionExit(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s280,
              width: AppSize.s360,
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
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.submit_as_seller,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s20),
                      ),
                    ),

                    // Text('Delicious food near you',style: TextStyle(fontSize: AppSize.s24),),
                    // Text('Your favorites food\ndelivered at your doorstep',style: TextStyle(fontSize: AppSize.s14),),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Text('We deliver grocery at your door step',style: TextStyle(fontSize: AppSize.s18),),
                    // ),
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.are_you_sur_process}',
                      style: TextStyle(fontSize: AppSize.s20),
                    ),
                    // Text('Schedule your food order in advance',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for breakfast ',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('What do you like for dinner ',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for lunch ',style: TextStyle(fontSize: AppSize.s14),),
                    SizedBox(
                      height: AppSize.s28,
                    ),

                    // SizedBox(
                    //   height: AppSize.s20,
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.yes,
                              textAlign: TextAlign.center,
                              style: getMediumStyle(color: ColorManager.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: AppSize.s110,
                            height: AppSize.s38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.primaryDark,
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.no,
                              textAlign: TextAlign.center,
                              style: getMediumStyle(color: ColorManager.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          );
        });
  }
}
