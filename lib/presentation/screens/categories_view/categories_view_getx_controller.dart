import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/product.dart';

class CategoriesViewGetXController extends GetxController with Helpers {
  // notifiable.
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update(['isLoading']);
  }

  // vars.
  late BuildContext context;
  late final StoreApiController _storeApiController = StoreApiController();
  List data = [];

  // init.
  void init({
    required BuildContext context,
  }) {
    this.context = context;
    getProducts();
  }

  // get products.
  void getProducts({
    bool notifyLoading = false,
  }) async {
    try {
      if (notifyLoading) isLoading = true;
      List<Product> products = await _storeApiController.getProducts();
      for (int i = 0; i < products.length; i++) {
        if (!data.any((element) => element['id'] == products[i].category!.id)) {
          data.add(
            {
              'id': products[i].category!.id,
              'category': products[i].category,
              'products': [products[i]],
            },
          );
        } else {
          data
              .firstWhere((element) =>
                  element['id'] == products[i].category!.id)['products']
              .add(products[i]);
        }
      }
      isLoading = false;
    } catch (error) {
      // error.
      debugPrint(error.toString());
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
