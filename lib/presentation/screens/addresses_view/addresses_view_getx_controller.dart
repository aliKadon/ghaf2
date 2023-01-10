import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/addresses_api_controller.dart';
import 'package:ghaf_application/domain/model/address.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

class AddressesViewGetXController extends GetxController with Helpers {
  // notifiable.
  bool _isAddressesLoading = true;

  bool get isAddressesLoading => _isAddressesLoading;

  set isAddressesLoading(bool value) {
    _isAddressesLoading = value;
    update(['isAddressesLoading']);
  }

  // constructor fields.
  final BuildContext context;

  // vars.
  late final AddressesApiController _addressesApiController =
      AddressesApiController();
  List<Address> addresses = [];

  // constructor.
  AddressesViewGetXController({
    required this.context,
  });

  // on init.
  @override
  void onInit() {
    getMyAddresses();
    super.onInit();
  }

  // get my addresses.
  void getMyAddresses({
    bool notifyLoading = false,
  }) async {
    try {
      if (notifyLoading) isAddressesLoading = true;
      addresses = await _addressesApiController.getMyAddresses();
      isAddressesLoading = false;
    } catch (error) {
      // error.
      debugPrint('error : ${error.toString()}');
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  // on edit finished.
  void onEditFinished() async {
    getMyAddresses(notifyLoading: true);
  }

  // on delete tapped.
  void onDeleteTapped({
    required String addressId,
  }) async {
    try {
      showLoadingDialog(context: context, title: 'Deleting Address');
      final ApiResponse apiResponse =
          await _addressesApiController.deleteAddress(
        addressId: addressId,
      );
      if (apiResponse.status == 200) {
        // success.
        showSnackBar(context, message: apiResponse.message, error: false);
        Navigator.pop(context);
        getMyAddresses(notifyLoading: true);
      } else {
        // failed.
        Navigator.pop(context);
        showSnackBar(context, message: apiResponse.message, error: true);
      }
    } catch (error) {
      // error.
      Navigator.pop(context);
      showSnackBar(context, message: 'An Error Occurred, Please Try again', error: true);
    }
  }
}
