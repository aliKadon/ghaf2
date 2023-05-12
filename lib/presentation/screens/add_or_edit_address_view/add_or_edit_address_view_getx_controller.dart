import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/addresses_api_controller.dart';
import 'package:ghaf_application/domain/model/address.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddOrEditAddressViewGetXController extends GetxController with Helpers {
  // final LocationData locationData;
  // AddOrEditAddressViewGetXController(this.locationData);
  // vars.
  late final AddressesApiController _addressesApiController =
      AddressesApiController();
  late final GlobalKey<FormState> formKey = GlobalKey();
  late final GoogleMapController googleMapController;
  late final LatLng latLng =
      selectedLatLng ?? const LatLng(24.400661, 54.635448);

  // constructor fields.
  final BuildContext context;
  Address? address;

  // fields.
  late String? addressName = address?.addressName;
  late String? phoneNumber = address?.phone;
  late LatLng? selectedLatLng = address != null
      ? LatLng(
          double.parse(address!.altitude!), double.parse(address!.longitude!))
      : null;

  // constructor.
  AddOrEditAddressViewGetXController({
    required this.context,
    this.address,
  });

  // add or edit address.
  void addOrEditAddress({
    required String addressName,
    required String lat,
    required String long,
    required String phoneNumber,
    required String villaOrApprtmentNumber,
    required String buildingOrStreetName,
    required String cityName,
    required String countryName,
  }) async {
    try {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      if (selectedLatLng == null) {
        showSnackBar(context,
            message: 'Please select an address on map', error: true);
        return;
      }
      showLoadingDialog(
          context: context,
          title: address == null ? 'Adding Address' : 'Editing Address');
      final ApiResponse apiResponse = address == null
          ? await _addressesApiController.addAddress(
              addressName: addressName,
              lat: lat,
              long: long,
              phoneNumber: phoneNumber,
              cityName: cityName,
              countryName: countryName,
              villaOrApprtmentNumber: villaOrApprtmentNumber,
              buildingOrStreetName: buildingOrStreetName,
            )
          : await _addressesApiController.editAddress(
              addressId: address!.id,
              addressName: addressName,
              lat: selectedLatLng!.latitude.toString(),
              long: selectedLatLng!.longitude.toString(),
              phoneNumber: phoneNumber,
            );
      if (apiResponse.status == 200) {
        // success.
        showSnackBar(context, message: apiResponse.message, error: false);
        Navigator.pop(context);
        Navigator.pop(context, true);
      } else {
        // failed.
        Navigator.pop(context);
        showSnackBar(context, message: apiResponse.message, error: true);
      }
    } catch (error) {
      // error.
      Navigator.pop(context);
      showSnackBar(context,
          message: 'An Error Occurred, Please Try again', error: true);
    }
  }
}
