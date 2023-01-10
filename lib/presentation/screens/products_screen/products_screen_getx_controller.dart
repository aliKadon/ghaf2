import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/product.dart';

class ProductsScreenGetXController extends GetxController with Helpers {
  // notifiable.
  bool _isProductsLoading = true;

  bool get isProductsLoading => _isProductsLoading;

  set isProductsLoading(bool value) {
    _isProductsLoading = value;
    update(['products']);
  }

  // vars.
  late BuildContext context;
  late String categoryId;
  late final StoreApiController _storeApiController = StoreApiController();
  List<Product> products = [];

  // init.
  void init({
    required BuildContext context,
    required String categoryId,
  }) {
    this.context = context;
    this.categoryId = categoryId;
    getProducts();
  }

  // get products.
  void getProducts() async {
    try {
      products = await _storeApiController.getProducts(
        cid: categoryId,
      );
      isProductsLoading = false;
    } catch (error) {
      // error.
      showSnackBar(context, message: 'An Error Occurred, Please Try again', error: true);
    }
  }
}
