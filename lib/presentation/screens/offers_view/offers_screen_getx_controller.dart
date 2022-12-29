import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/product.dart';

class OffersScreenGetXController extends GetxController with Helpers {
  // notifiable.
  bool _isOffersLoading = true;

  bool get isOffersLoading => _isOffersLoading;

  set isOffersLoading(bool value) {
    _isOffersLoading = value;
    update(['isOffersLoading']);
  }

  // vars.
  late final StoreApiController _storeApiController = StoreApiController();
  List<Product> offers = [];

  // constructor fields.
  final BuildContext context;

  // constructor.
  OffersScreenGetXController({
    required this.context,
  });

  // init.
  @override
  void onInit() {
    getOffers();
    super.onInit();
  }

  // get offers.
  void getOffers() async {
    try {
      offers = await _storeApiController.getOffers();
      isOffersLoading = false;
    } catch (error) {
      // error.
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
