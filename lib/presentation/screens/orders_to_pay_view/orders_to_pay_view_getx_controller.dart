import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/orders_api_controller.dart';
import 'package:ghaf_application/domain/model/order.dart';

class OrdersToPayViewGetXController extends GetxController with Helpers {
  // notifiable.
  bool _isOrdersLoading = true;

  bool get isOrdersLoading => _isOrdersLoading;

  set isOrdersLoading(bool value) {
    _isOrdersLoading = value;
    update(['isOrdersLoading']);
  }

  // vars.
  late final OrdersApiController _ordersApiController = OrdersApiController();
  List<Order> orders = [];

  // constructor fields.
  final BuildContext context;

  // constructor.
  OrdersToPayViewGetXController({
    required this.context,
  });

  // init.
  @override
  void onInit() {
    // getReadyOrdersToPay();
    super.onInit();
  }

  // // get orders to pay.
  // void getReadyOrdersToPay() async {
  //   try {
  //     orders = await _ordersApiController.getReadyOrdersToPay();
  //     isOrdersLoading = false;
  //   } catch (error) {
  //     // error.
  //     showSnackBar(context, message: error.toString(), error: true);
  //   }
  // }
}
