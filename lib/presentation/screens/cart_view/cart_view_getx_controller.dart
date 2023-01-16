import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/orders_api_controller.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/cart_item.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';

class CartViewGetXController extends GetxController with Helpers {
  // notifiable.
  void notifyMyCart() {
    update(['myCart']);
  }

  void notifyBell() {
    update(['bell']);
  }

  // flags.
  bool isMyCartLoading = true;

  // vars.
  late BuildContext context;
  late final StoreApiController _storeApiController = StoreApiController();
  late final OrdersApiController _ordersApiController = OrdersApiController();
  List<CartItem> cartItems = [];
  num subTotal = 0;
  num discount = 0;
  num total = 0;
  num subTotal2 = 0;

  // init.
  void init({
    required BuildContext context,
  }) {
    this.context = context;
    getMyCart();
  }

  // get my cart.
  void getMyCart() async {
    try {
      cartItems = await _storeApiController.getMyCart();
      calculateBell();
      isMyCartLoading = false;
      notifyMyCart();
    } catch (error) {
      // error.
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  // calculate bell.
  void calculateBell() {
    subTotal = 0;
    discount = 0;
    total = 0;
    subTotal2 = 0;
    for (CartItem cartItem in cartItems) {
      subTotal += (cartItem.product?.productDiscount == null
              ? cartItem.product?.price ?? 0
              : ((cartItem.product!.price!))) *
          cartItem.productCount!;
      subTotal2 += (cartItem.product?.productDiscount == null
          ? cartItem.product?.price ?? 0
          : ((cartItem.product!.price!-(cartItem.product!.price! * cartItem.product!.productDiscount!.discount! / 100)))) *
          cartItem.productCount!;
    }
    discount = subTotal - subTotal2;
    total = subTotal2;


    notifyBell();
  }

  // remove cart item.
  void removeCartItem({
    required int index,
  }) {
    cartItems.removeAt(index);
    calculateBell();
    notifyMyCart();
  }

  // create order.
  void createOrder() async {
    try {
      showLoadingDialog(context: context, title: 'Creating Order');
      final ApiResponse apiResponse = await _ordersApiController.createOrder();
      if (apiResponse.status == 200) {
        // success.
        Navigator.pop(context);
        showSnackBar(context, message: apiResponse.message, error: false);
        notifyBell();
        notifyMyCart();
        Provider.of<ProductProvider>(context,listen: false).clearCart();
        Navigator.pushNamed(context, Routes.ordersToPay,arguments: '');
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
