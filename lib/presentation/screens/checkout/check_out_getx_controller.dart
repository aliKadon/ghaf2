import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/orders_api_controller.dart';
import 'package:ghaf_application/data/api/controllers/payment_method_api_controller.dart';
import 'package:ghaf_application/domain/model/order.dart';

import '../../../domain/model/order_to_pay.dart';
import '../../../domain/model/payment_mathod.dart';

class CheckOutGetxController extends GetxController with Helpers {
  List<PaymentMethod> paymentMethod = [];
  List<OrderToPay> orderToPay = [];
  var isLoading = true.obs;
  var isLoadingOrderToPay = true;

  late final PaymentMethodApiController _paymentMethodApiController =
      PaymentMethodApiController();

  final OrdersApiController _ordersApiController = OrdersApiController();

  void getPaymentMethod({required BuildContext context}) async {
    try {
      paymentMethod = await _paymentMethodApiController.getPaymentMethod();
      isLoading.value = false;
    }catch (error) {
      showSnackBar(context, message: error.toString(),error: true);
    }
  }

  void getOrderToPay({required BuildContext context}) async{
    orderToPay = await _ordersApiController.getReadyOrdersToPay();
    isLoadingOrderToPay = false;
    update(["orderToPay"]);
    // try {
    //   orderToPay = await _ordersApiController.getReadyOrdersToPay();
    //   isLoadingOrderToPay = false;
    //   update(["orderToPay"]);
    // }catch(error) {
    //   print('===============error in get order to pay');
    //   print(error.toString());
    //   // showSnackBar(context, message: error.toString());
    // }
  }
}
