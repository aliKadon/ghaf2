import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/product.dart';

class MyFavoriteScreenGetXController extends GetxController with Helpers {
  // notifiable.
  bool _isMyFavoriteLoading = true;

  bool get isMyFavoriteLoading => _isMyFavoriteLoading;

  set isMyFavoriteLoading(bool value) {
    _isMyFavoriteLoading = value;
    getMyFavorite();
    update();
  }

  // vars.
  late BuildContext context;
  late final StoreApiController _storeApiController = StoreApiController();
  List<Product> products = [];

  // init.
  void init({
    required BuildContext context,
  }) {
    this.context = context;
    getMyFavorite();
    update(['myFavorite']);
  }

  // get my favorite.
  void getMyFavorite() async {
    try {
      products = await _storeApiController.getMyFavorite();

      isMyFavoriteLoading = false;

    } catch (error) {
      // error.
      showSnackBar(context, message: 'An Error Occurred, Please Try again', error: true);
    }
  }
}
