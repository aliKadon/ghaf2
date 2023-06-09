import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/add_or_edit_address_view/add_or_edit_address_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AddOrEditAddressView extends StatefulWidget {
  // const AddOrEditAddressView({Key? key}) : super(key: key);

  // final LocationData locationData;
  // AddOrEditAddressView(this.locationData);

  @override
  State<AddOrEditAddressView> createState() => _AddOrEditAddressViewState();
}

class _AddOrEditAddressViewState extends State<AddOrEditAddressView> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _nameAddressTextController = TextEditingController();
  TextEditingController _phoneNumberTextController = TextEditingController();
  TextEditingController _streetTextController = TextEditingController();
  TextEditingController _buildingTextController = TextEditingController();

  late Placemark place;

  // #############################################
  //get all information from latitude and longitude
  // #############################################
  Future<void> GetAddressFromLatLong(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    print('======================================my address');
    print(placemarks);
    place = placemarks[0];
    _addressTextController.text =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print('================myaddress');
    print(_addressTextController.text);
  }

  // ##############################################
  // ##############################################

  static final CameraPosition _kGoogle = CameraPosition(
    target: LatLng(SharedPrefController().locationLat,
        SharedPrefController().locationLong),
    zoom: 14.4746,
  );

  // late Position _currentPosition;
  //
  //
  // void _getCurrentLocation() async {
  //   Position position = await Geolocator
  //       .getCurrentPosition(desiredAccuracy: );
  //   setState(() {
  //     _currentPosition = position;
  //   });

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(SharedPrefController().locationLat,
            SharedPrefController().locationLong),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  // controller.
  late final AddOrEditAddressViewGetXController _addAddressViewGetXController =
      Get.find<AddOrEditAddressViewGetXController>();

  // var lat = SharedPrefController().locationLat;
  // var long = SharedPrefController().locationLong;

  // dispose.
  @override
  void dispose() {
    Get.delete<AddOrEditAddressViewGetXController>();
    _addressTextController.dispose();
    _nameAddressTextController.dispose();
    _phoneNumberTextController.dispose();
    _streetTextController.dispose();
    _buildingTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (_addAddressViewGetXController.address != null) {
      _nameAddressTextController.text =
          _addAddressViewGetXController.address!.addressName ?? '';
      _phoneNumberTextController.text =
          _addAddressViewGetXController.address!.phone ?? '';
      _streetTextController.text =
          _addAddressViewGetXController.address!.buildingOrStreetName ?? '';
      _buildingTextController.text =
          _addAddressViewGetXController.address!.villaOrApprtmentNumber ?? '';
    }

    // ############################################
    //get all information from latitude and longitude
    // #############################################
    GetAddressFromLatLong(LatLng(SharedPrefController().locationLat,
        SharedPrefController().locationLong));
    // ##############################################
    // ##############################################
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('===============================lat');
    // print(lat);
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
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.038,
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Image.asset(
                        SharedPrefController().lang1 == 'ar'
                            ? IconsAssets.arrow2
                            : IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    _addAddressViewGetXController.address == null
                        ? AppLocalizations.of(context)!.add_address
                        : AppLocalizations.of(context)!.edit_address,
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
                    mapType: MapType.normal,
                    // on below line setting user location enabled.
                    myLocationEnabled: true,
                    // on below line setting compass enabled.
                    compassEnabled: true,
                    // on below line specifying controller on map complete.
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    // onMapCreated: (GoogleMapController controller) {
                    //   _addAddressViewGetXController.googleMapController =
                    //       controller;
                    // },
                    // initialCameraPosition: CameraPosition(
                    //   target: _addAddressViewGetXController.selectedLatLng ??  LatLng(24.400661, 54.635448),
                    //   zoom: 14.5,
                    // ),
                    initialCameraPosition: _kGoogle,
                    markers: {
                      Marker(
                        markerId: MarkerId('address'),
                        position:
                            _addAddressViewGetXController.selectedLatLng ??
                                LatLng(24.400661, 54.635448),
                      )
                    },
                    onTap: (latLng) async {
                      setState(() {
                        _addAddressViewGetXController.selectedLatLng = latLng;
                        GetAddressFromLatLong(latLng);
                        print('=============================');
                        print(latLng);
                      });
                    },
                  ),
                  Positioned(
                    top: 350,
                    left: 290,
                    right: 0,
                    child: FloatingActionButton(
                      backgroundColor: ColorManager.primary,
                      onPressed: () async {
                        getUserCurrentLocation().then((value) async {
                          print(value.latitude.toString() +
                              " " +
                              value.longitude.toString());

                          // marker added for current users location
                          _markers.add(Marker(
                            markerId: MarkerId("2"),
                            position: LatLng(value.latitude, value.longitude),
                            infoWindow: InfoWindow(
                              title: AppLocalizations.of(context)!
                                  .my_current_location,
                            ),
                          ));

                          // specified current users location
                          CameraPosition cameraPosition = new CameraPosition(
                            target: LatLng(value.latitude, value.longitude),
                            zoom: 14,
                          );

                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition));
                          setState(() {});
                        });
                      },
                      child: Icon(Icons.my_location),
                    ),
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
                                _addAddressViewGetXController.address == null ? Text(
                                  AppLocalizations.of(context)!
                                          .add_address,
                                  style: getBoldStyle(
                                      color: ColorManager.primaryDark,
                                      fontSize: FontSize.s16),
                                ) : Container(),
                                SizedBox(
                                  height: 6,
                                ),
                                AppTextField(
                                  textController: _addressTextController,
                                  hint: AppLocalizations.of(context)!.address,
                                  textInputType: TextInputType.phone,
                                  onSaved: (value) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .address_name_required;
                                    }
                                    return null;
                                  },
                                ),
                                AppTextField(
                                  // initialValue:
                                  // _addAddressViewGetXController.addressName,
                                  // hint: 'Address name',
                                  textController: _nameAddressTextController,
                                  hint: AppLocalizations.of(context)!
                                      .name_address,
                                  onSaved: (value) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      // return 'Address name is required';
                                      return AppLocalizations.of(context)!
                                          .address_name_required;
                                    }
                                    return null;
                                  },
                                ),
                                AppTextField(
                                  textController: _phoneNumberTextController,
                                  hint: AppLocalizations.of(context)!
                                      .phone_number,
                                  textInputType: TextInputType.phone,
                                  onSaved: (value) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .phone_number_is_required;
                                    }
                                    return null;
                                  },
                                ),
                                AppTextField(
                                  // initialValue:
                                  // _addAddressViewGetXController.addressName,
                                  // hint: 'Address name',
                                  textController: _streetTextController,
                                  hint: AppLocalizations.of(context)!
                                      .street_address,
                                  onSaved: (value) {},
                                  // validator: (value) {
                                  //   if (value == null ||
                                  //       value.isEmpty) {
                                  //     // return 'Address name is required';
                                  //     return AppLocalizations.of(
                                  //         context)!
                                  //         .address_name_required;
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                AppTextField(
                                  // initialValue:
                                  // _addAddressViewGetXController.addressName,
                                  // hint: 'Address name',
                                  textController: _buildingTextController,
                                  hint: AppLocalizations.of(context)!
                                      .building_address,
                                  onSaved: (value) {},
                                  // validator: (value) {
                                  //   if (value == null ||
                                  //       value.isEmpty) {
                                  //     // return 'Address name is required';
                                  //     return AppLocalizations.of(
                                  //         context)!
                                  //         .address_name_required;
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: AppMargin.m16,
                                  ),
                                  width: double.infinity,
                                  height: AppSize.s55,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _addAddressViewGetXController
                                          .addOrEditAddress(
                                        buildingOrStreetName:
                                            _streetTextController.text,
                                        villaOrApprtmentNumber:
                                            _buildingTextController.text,
                                        countryName: place.country!,
                                        cityName: place.locality!,
                                        addressName:
                                            _nameAddressTextController.text,
                                        lat: (_addAddressViewGetXController
                                                .latLng.latitude)
                                            .toString(),
                                        long: (_addAddressViewGetXController
                                                .latLng.longitude)
                                            .toString(),
                                        phoneNumber:
                                            _phoneNumberTextController.text,
                                      );
                                    },
                                    child: Text(
                                      _addAddressViewGetXController.address ==
                                              null
                                          ? AppLocalizations.of(context)!
                                              .add_address
                                          : AppLocalizations.of(context)!
                                              .confirm,
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
