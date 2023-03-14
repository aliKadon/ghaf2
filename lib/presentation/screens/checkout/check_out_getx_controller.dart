import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/orders_api_controller.dart';
import 'package:ghaf_application/data/api/controllers/payment_method_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

import '../../../domain/model/address.dart';
import '../../../domain/model/order_to_pay.dart';
import '../../../domain/model/payment_mathod.dart';

class CheckOutGetxController extends GetxController with Helpers {
  List<PaymentMethod> paymentMethod = [];
  List<OrderToPay> orderToPay = [];
  var isLoading = true.obs;
  var isLoadingOrderToPay = true;
  late ApiResponse apiResponse;

  late final PaymentMethodApiController _paymentMethodApiController =
  PaymentMethodApiController();

  final OrdersApiController _ordersApiController = OrdersApiController();

  void getPaymentMethod({required BuildContext context}) async {
    try {
      paymentMethod = await _paymentMethodApiController.getPaymentMethod();
      isLoading.value = false;
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void deletePaymentMethod(
      {required BuildContext context, required String id}) async {
    try {
      apiResponse =
      await _paymentMethodApiController.deletePaymentMethod(id: id);
      paymentMethod = await _paymentMethodApiController.getPaymentMethod();
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString());
    }
  }

  void payForOrder({
    required BuildContext context,
    required String orderId,
    required String deliveryMethodId,
    String? desiredDeliveryDate,
    required Address deliveryPoint,
    bool? useRedeemPoints = false,
    bool? usePayLater = false,
    required String PaymentMethodId,
  }) async {
    try {
      apiResponse = await _ordersApiController.payForOrder(orderId: orderId,
          deliveryMethodId: deliveryMethodId,
          deliveryPoint: deliveryPoint,
          PaymentMethodId: PaymentMethodId,
          desiredDeliveryDate: desiredDeliveryDate,
          usePayLater: usePayLater,
          useRedeemPoints: useRedeemPoints);
    }catch (error) {
      showSnackBar(context, message: error.toString());
    }
  }

  void addPaymentMethod({
    required BuildContext context,
    required String cardNumber,
    required num cardExpMonth,
    required String cardExpCvc,
    required num cardExpYear,
  }) async {
    try {
      apiResponse = await _paymentMethodApiController.addPaymentMethod(
          cardNumber: cardNumber,
          cardExpMonth: cardExpMonth,
          cardExpCvc: cardExpCvc,
          cardExpYear: cardExpYear);
      paymentMethod = await _paymentMethodApiController.getPaymentMethod();
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString());
    }
  }

  void deleteUnpaidOrder(
      {required BuildContext context, required String orderId}) async {
    try {
      apiResponse =
      await _ordersApiController.deleteUnpaidOrderById(orderId: orderId);
    } catch (error) {
      showSnackBar(context, message: error.toString());
    }
  }

  void getOrderToPay({required BuildContext context}) async {
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
