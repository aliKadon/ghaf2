import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/orders_api_controller.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/cart_item.dart';
import 'package:ghaf_application/presentation/screens/checkout/checkout_view.dart';

class CartViewGetXController extends GetxController with Helpers {
  // notifiable.
  void notifyMyCart() async {
    cartItems = await _storeApiController.getMyCart();
    notifyBell();
    update();
  }

  void notifyBell() {
    update();
  }

  //controller
  late final CartViewGetXController _cartViewGetXController =
  Get.find<CartViewGetXController>();

  // flags.
  bool isMyCartLoading = true;

  var isLoading = true;

  // vars.
  late BuildContext context;
  late final StoreApiController _storeApiController = StoreApiController();
  late final OrdersApiController _ordersApiController = OrdersApiController();
  List<CartItem> cartItems = [];
  late ApiResponse apiResponse;
  num subTotal = 0;
  num discount = 0;
  num total = 0;
  num subTotal2 = 0;
  num? minOrder;

  // init.
  void init({
    required BuildContext context,
  }) {
    this.context = context;
    if(AppSharedData.currentUser == null) {

      print(AppSharedData.currentUser);
    }else {
      getMyCart(context: context);
    }

  }


  // get my cart.
  void getMyCart({required BuildContext context}) async {

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

  void changeCartAmount(
      {required BuildContext context,
      required String cartItemId,
      required num count}) async {
    if(count > 0) {
      // apiResponse = await _storeApiController.changeCartItemCount(
      //     cartItemId: cartItemId, count: count);
      // _cartViewGetXController.getMyCart(context: context);
      // update();
      try {
        apiResponse = await _storeApiController.changeCartItemCount(
            cartItemId: cartItemId, count: count);
        _cartViewGetXController.getMyCart(context: context);
        update();
      } catch (error) {
        showSnackBar(context, message: error.toString(), error: true);
      }
    }

  }

  // calculate bell.
  void calculateBell({num? minOrder1}) async {
    subTotal = 0;
    discount = 0;
    total = 0;
    subTotal2 = 0;

    // for (CartItem cartItem in cartItems) {
    //
    //
    //   subTotal += ((cartItem.product!.price!) * productCount);
    //
    //   discount += AppSharedData.currentUser!.ghafGold!
    //       ? (double.parse(cartItem.product!.discountValueForGoldenUsers!) / 100)
    //       : (double.parse(cartItem.product!.discountValueForAllUsers!) / 100);
    //
    //
    // }
    for (CartItem cartItem in cartItems) {
      subTotal += (cartItem.product?.discountValueForAllUsers == null
              ? cartItem.product?.price ?? 0
              : ((cartItem.product!.price!))) *
          cartItem.productCount!;
      subTotal2 += (cartItem.product?.discountValueForAllUsers == null
              ? cartItem.product?.price ?? 0
              : AppSharedData.currentUser!.ghafGold!
                  ? ((cartItem.product!.price! -
                      (cartItem.product!.price! *
                          int.parse(
                              cartItem.product!.discountValueForGoldenUsers!) /
                          100)))
                  : ((cartItem.product!.price! -
                      (cartItem.product!.price! *
                          int.parse(
                              cartItem.product!.discountValueForAllUsers!) /
                          100)))) *
          cartItem.productCount!;
    }
    discount = subTotal - subTotal2;
    total = subTotal2;

    if(minOrder1 != null) {
      calculate(subtotal1: subTotal,minOrder1: minOrder1);
    }
    print('you in');
    // cartItems = await _storeApiController.getMyCart();
    update();
    // notifyMyCart();
  }

  void calculate({num? subtotal1,num? minOrder1}) {

    num minOrder2 = 0;
    minOrder = minOrder1;
    minOrder2 = (minOrder1 ?? 0 - subtotal1!);
    print('===============calculate');
    print(minOrder2);
    print(subtotal1);
    if(minOrder2 > 0) {
      minOrder = minOrder2;
      print(minOrder);
    }else {
      minOrder = 0;
    }
  }

  void emptyBasket(BuildContext context) async {
    try {
      await _storeApiController.emptyBasket(context);
      cartItems = [];
      // isMyCartLoading = true;
      notifyMyCart();
    } catch (error) {
      // error.
      print(error.toString());
      // showSnackBar(context, message: error.toString(), error: true);
    }
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
  void createOrder(BuildContext context) async {
    try {
      showLoadingDialog(context: context, title: 'Creating Order');
      final ApiResponse apiResponse = await _ordersApiController.createOrder();
      if (apiResponse.status == 200) {
        // success.
        Navigator.pop(context);
        showSnackBar(context, message: apiResponse.message, error: false);
        notifyBell();
        notifyMyCart();
        // Provider.of<ProductProvider>(context, listen: false).clearCart();
        // Navigator.pushNamed(context, Routes.ordersToPay, arguments: '');
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => CheckOutView(),
        ));
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
