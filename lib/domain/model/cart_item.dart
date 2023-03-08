import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/product.dart';

class CartItem extends GetxController with Helpers {
  // notifiable.

  // increment.
  void increment({
    required String idProduct,
    required num productCount,
    required BuildContext context,
    bool sendRequest = true,
  }) {
    productCount = productCount + 1;
    update(['productCount']);
    if (sendRequest)
      _ChangeCartItemCountRequest(
          context: context,
          type: 1,
          productCount: productCount,
          idProduct: idProduct);
  }

  // decrement.
  void decrement({
    required String idProduct,
    required num productCount,
    required BuildContext context,
    bool sendRequest = true,
  }) {
    productCount = productCount! - 1;
    update(['productCount']);
    if (sendRequest)
      _ChangeCartItemCountRequest(
          context: context,
          type: 2,
          productCount: productCount,
          idProduct: idProduct);
  }

  // vars.
  late final StoreApiController _storeApiController = StoreApiController();

  CartItem({
    this.id,
    this.userId,
    this.product,
    this.productCount,
  });

  String? id;
  String? userId;
  Product? product;
  num? productCount;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        userId: json["userId"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        productCount: json["productCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "product": product?.toJson(),
        "productCount": productCount,
      };

  // change cart item count request.
  void _ChangeCartItemCountRequest({
    required String idProduct,
    required BuildContext context,
    required num productCount,
    required int type,
  }) async {
    try {
      final ApiResponse apiResponse =
          await _storeApiController.changeCartItemCount(
        cartItemId: idProduct,
        count: productCount,
      );
      if (apiResponse.status == 200) {
        // success.
      } else {
        // failed.
        showSnackBar(context, message: apiResponse.message, error: true);
        if (type == 1)
          decrement(
              context: context,
              sendRequest: false,
              productCount: 0,
              idProduct: idProduct);
        else
          increment(
              context: context,
              sendRequest: false,
              productCount: 0,
              idProduct: idProduct);
      }
    } catch (error) {
      // error.
      showSnackBar(context, message: error.toString(), error: true);
      if (type == 1)
        decrement(
            context: context,
            sendRequest: false,
            productCount: 0,
            idProduct: idProduct);
      else
        increment(
            context: context,
            sendRequest: false,
            productCount: 0,
            idProduct: idProduct);
    }
  }

  // toggle add to cart request.
  void toggleAddToCartRequest() async {
    try {
      final ApiResponse apiResponse =
          await _storeApiController.toggleAddToCart(productId: product!.id!);
      if (apiResponse.status == 200) {
        // success.
      } else {
        // failed.
      }
    } catch (error) {
      // error.
    }
  }
}
