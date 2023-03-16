
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/orders_api_controller.dart';
import 'package:ghaf_application/data/api/controllers/payment_method_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:http/http.dart' as http;

import '../../../app/constants.dart';
import '../../../domain/model/address.dart';
import '../../../domain/model/order.dart';
import '../../../domain/model/order_to_pay.dart';
import '../../../domain/model/payment_mathod.dart';
import 'checkout_confirm_view.dart';

class CheckOutGetxController extends GetxController with Helpers {
  List<PaymentMethod> paymentMethod = [];
  List<OrderToPay> orderToPay = [];
  late Order? order;
  var isLoading = true.obs;
  var isLoadingOrderToPay = true;
  var isLoadingOrderById = true;
  var isLoadingForOrderTracking = true;
  late ApiResponse apiResponse;
  var distance = '0';
  var duration = '0';

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
    bool? asap,
    String? OrderNotes,
    String? PromoCode,
    Map<String,dynamic>? SheduleInfo,
    bool? useRedeemPoints = false,
    bool? usePayLater = false,
    required String PaymentMethodId,
  }) async {
    try {
      apiResponse = await _ordersApiController.payForOrder(
          orderId: orderId,
          deliveryMethodId: deliveryMethodId,
          deliveryPoint: deliveryPoint,
          PaymentMethodId: PaymentMethodId,
          desiredDeliveryDate: desiredDeliveryDate,
          usePayLater: usePayLater,
          asap: asap,
          OrderNotes: OrderNotes,
          PromoCode: PromoCode,
          SheduleInfo: SheduleInfo,
          useRedeemPoints: useRedeemPoints);
      Navigator.of(context)
          .push(MaterialPageRoute(
        builder: (context) =>
            CheckOutConfirmView(
                orderId: orderId),
      ));
      showSnackBar(context, message: apiResponse.message);
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
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
      showSnackBar(context, message: apiResponse.message);
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
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
    try {
      orderToPay = await _ordersApiController.getReadyOrdersToPay();
      isLoadingOrderToPay = false;
      update(["orderToPay"]);
    } catch (error) {
      print('===============error in get order to pay');
      print(error.toString());
      // showSnackBar(context, message: error.toString());
    }
  }

  void getOrderById(
      {required BuildContext context, required String orderId}) async {
    try {
      order = await _ordersApiController.getOrderById(orderId: orderId);
      isLoadingOrderById = false;
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString());
    }
  }

  Future<void> getDurationGoogleMap({
    required double LatOne,
    required double LonOne,
    required double LatTow,
    required double LonTow,
  }) async {
    var Url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${LatOne},${LonOne}&destination=${LatTow},${LonTow}&key=${Constants.google_key_map}');
    // var Url = Uri.parse(
    //     'https://maps.googleapis.com/maps/api/distancematrix/json?origin=${LatOne},${LonOne}&destination=${LatTow},${LonTow}&key=${Constants.google_key_map}');
    final response = await http.get(Url);
    final data = jsonDecode(response.body);

    try {
      final response = await http.get(Url);
      final data = jsonDecode(response.body);
      distance = data["routes"][0]["legs"][0]["distance"]["text"];
      duration = data["routes"][0]["legs"][0]["duration"]["text"];

      isLoadingForOrderTracking = false;
      update();
      print('===========================================provider duration');
      // DateFormat format = DateFormat('dd-MM-yyyy HH:mm');
      // var s = format.parse(duration);
      print(duration);
      print(distance);
    } catch (e) {
      print('==============================error in duration');
      print(e);
    }
  }
}
