import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/add_or_edit_address_view/add_or_edit_address_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AddOrEditAddressView extends StatefulWidget {
  const AddOrEditAddressView({Key? key}) : super(key: key);

  @override
  State<AddOrEditAddressView> createState() => _AddOrEditAddressViewState();
}

class _AddOrEditAddressViewState extends State<AddOrEditAddressView> {
  // controller.
  late final AddOrEditAddressViewGetXController _addAddressViewGetXController =
      Get.find<AddOrEditAddressViewGetXController>();

  // dispose.
  @override
  void dispose() {
    Get.delete<AddOrEditAddressViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    _addAddressViewGetXController.address == null
                        ? AppLocalizations.of(context)!.add_address
                        : 'Edit Address',
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s12,
            ),
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _addAddressViewGetXController.googleMapController =
                          controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: _addAddressViewGetXController.latLng,
                      zoom: 17,
                    ),
                    markers: _addAddressViewGetXController.selectedLatLng ==
                            null
                        ? {}
                        : {
                            Marker(
                              markerId: MarkerId('address'),
                              position:
                                  _addAddressViewGetXController.selectedLatLng!,
                            )
                          },
                    onTap: (latLng) async {
                      setState(() {
                        _addAddressViewGetXController.selectedLatLng = latLng;
                      });
                    },
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: AppPadding.p16, vertical: AppPadding.p18),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.only(bottom: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppPadding.p12,
                              vertical: AppPadding.p16),
                          child: Form(
                            key: _addAddressViewGetXController.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.add_address,
                                  style: getBoldStyle(
                                      color: ColorManager.primaryDark,
                                      fontSize: FontSize.s16),
                                ),
                                SizedBox(
                                  height: AppSize.s6,
                                ),
                                AppTextField(
                                  initialValue:
                                      _addAddressViewGetXController.addressName,
                                  hint: 'Address name',
                                  onSaved: (value) =>
                                      _addAddressViewGetXController
                                          .addressName = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Address name is required';
                                    }
                                    return null;
                                  },
                                ),
                                AppTextField(
                                  initialValue:
                                      _addAddressViewGetXController.phoneNumber,
                                  hint: 'Phone Number',
                                  textInputType: TextInputType.phone,
                                  onSaved: (value) =>
                                      _addAddressViewGetXController
                                          .phoneNumber = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Phone number is required';
                                    }
                                    return null;
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: AppMargin.m16,
                                  ),
                                  width: double.infinity,
                                  height: AppSize.s55,
                                  child: ElevatedButton(
                                    onPressed: _addAddressViewGetXController
                                        .addOrEditAddress,
                                    child: Text(
                                      _addAddressViewGetXController.address ==
                                              null
                                          ? 'Add Address'
                                          : 'Edit Address',
                                      style: getSemiBoldStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSize.s18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
