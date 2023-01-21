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
  late String storeId;
  late String categoryId;
  late final StoreApiController _storeApiController = StoreApiController();
  List<Product> products = [];

  // init.
  void init({
    required BuildContext context,
    required String categoryId,
    required String storeId,
  }) {
    this.context = context;
    this.storeId = storeId;
    this.categoryId = categoryId;
    if (storeId == 'null') {
      print('==================================it is category');
      getProductsCategory();

    }else {
      print('==================================it is store');

      getProducts();
    }


  }

  // get products.
  void getProducts() async {
    products = await _storeApiController.getProducts(
      sid: storeId,
    );
    isProductsLoading = false;
    // try {
    //
    // } catch (error) {
    //   // error.
    //   showSnackBar(context, message: error.toString(), error: true);
    // }
  }

  void getProductsCategory() async {
    products = await _storeApiController.getProductsCategory(
      cid: categoryId,
    );
    isProductsLoading = false;
    // try {
    //
    // } catch (error) {
    //   // error.
    //   showSnackBar(context, message: error.toString(), error: true);
    // }
  }
}
