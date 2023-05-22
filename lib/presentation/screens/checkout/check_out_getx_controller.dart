import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/orders_api_controller.dart';
import 'package:ghaf_application/data/api/controllers/payment_method_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/promo_code.dart';
import 'package:ghaf_application/domain/model/schedualed_order.dart';
import 'package:ghaf_application/presentation/screens/cart_view/cart_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/checkout/checkout_view.dart';
import 'package:ghaf_application/presentation/screens/checkout/payment_method_redeem_point_screen.dart';
import 'package:http/http.dart' as http;

import '../../../app/constants.dart';
import '../../../domain/model/address.dart';
import '../../../domain/model/meal_times.dart';
import '../../../domain/model/order.dart';
import '../../../domain/model/order_to_pay.dart';
import '../../../domain/model/payment_mathod.dart';
import '../my_wallet/add_credit_screen.dart';
import '../my_wallet/top_up_screen.dart';
import 'checkout_confirm_view.dart';

class CheckOutGetxController extends GetxController with Helpers {
  List<PaymentMethod> paymentMethod = [];
  List<OrderToPay> orderToPay = [];
  List<PromoCode> promoCodes = [];
  List<Order> customerOrder = [];
  List<Order> preOrders = [];
  List<Order> doneorder = [];
  List<ScheduledOrder> scheduleOrders = [];
  List<ScheduledOrder> scheduleOrders1 = [];
  ScheduledOrder? scheduleOrderById;
  List<String> storeName = [];
  List<dynamic> imageName = [];
  List<String> storeNamePreOrder = [];
  List<dynamic> imageNamePreOrder = [];
  Order? order;
  var isLoadingScheduleOrderById = true;
  var isLoading = true.obs;
  var isLoadingOrderToPay = true;
  var isLoadingOrderById = true;
  var isLoadingForOrderTracking = true;
  late ApiResponse apiResponse;
  late ApiResponse apiResponse1;
  var distance = '0';
  var duration = '0';
  var isLoadingDistance = true;
  List<String> hours = ['0'];

  late final PaymentMethodApiController _paymentMethodApiController =
      PaymentMethodApiController();

  final OrdersApiController _ordersApiController = OrdersApiController();

  final CartViewGetXController _cartViewGetXController = Get.put(CartViewGetXController());

  void getPaymentMethod({required BuildContext context}) async {
    try {
      List<PaymentMethod> paymentMethods = [];
      paymentMethods = await _paymentMethodApiController.getPaymentMethod();
      isLoading.value = false;
    paymentMethod = paymentMethods.reversed.toList();
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

  void getPreOrder1(
      {required BuildContext context, String? branchName = ''}) async {

    try {

      preOrders =
      await _ordersApiController.getPreOrder(branchName: branchName);

      update();
    } catch (e) {
      print(e);
      // showSnackBar(context, message: e.toString(), error: true);
    }
  }

  void getPreOrder(
      {required BuildContext context, String? branchName = ''}) async {

    try {
      List<String> names = [];
      List<dynamic> image = [];
      preOrders =
          await _ordersApiController.getPreOrder(branchName: branchName);
      for (int i = 0; i < preOrders.length ; i++) {
        print('====================branch name');
        names.add(preOrders[i].branch!.branchName!);

        image.removeWhere((element) =>
        element['storeName'] == names[i]);
        image.add({
          'storeName' : preOrders[i].branch!.branchName!,
          'image' : preOrders[i].branch!.branchLogoImage!,
        });
        print(image);
      }
      storeNamePreOrder = names.toSet().toList();
      imageNamePreOrder = image;
      print('========================list of store name');
      print(storeNamePreOrder);
      update();
    } catch (e) {
      print(e);
      // showSnackBar(context, message: e.toString(), error: true);
    }
  }

  void payForOrder({
    required BuildContext context,
    required String orderId,
    required String deliveryMethodId,
    String? desiredDeliveryDate,
    Address? deliveryPoint,
    bool? asap,
    bool? useWallet = false,
    String? OrderNotes,
    String? PromoCode,
    Map<String, dynamic>? SheduleInfo,
    bool? useRedeemPoints = false,
    bool? usePayLater = false,
    required String PaymentMethodId,
  }) async {
    try {
      showLoadingDialog(context: context, title: 'loading...');
      apiResponse = await _ordersApiController.payForOrder(
          orderId: orderId,
          deliveryMethodId: deliveryMethodId,
          deliveryPoint: deliveryPoint,
          PaymentMethodId: PaymentMethodId,
          desiredDeliveryDate: desiredDeliveryDate,
          usePayLater: usePayLater,
          asap: asap,
          useWallet: useWallet,
          OrderNotes: OrderNotes,
          PromoCode: PromoCode,
          SheduleInfo: SheduleInfo,
          useRedeemPoints: useRedeemPoints);
      if (apiResponse.status == 200) {

        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CheckOutConfirmView(orderId: orderId),
        ));
        _cartViewGetXController.emptyBasket(context);
        // showSnackBar(context, message: apiResponse.message);
      } else {
        Navigator.of(context).pop();
        showSnackBar(context, message: apiResponse.message, error: true);
      }
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
    String? lastPage,
  }) async {
    showLoadingDialog(context: context, title: 'adding...');
    try {
      apiResponse = await _paymentMethodApiController.addPaymentMethod(
          cardNumber: cardNumber,
          cardExpMonth: cardExpMonth,
          cardExpCvc: cardExpCvc,
          cardExpYear: cardExpYear);
      paymentMethod = await _paymentMethodApiController.getPaymentMethod();
      update();
      Navigator.of(context).pop();
      if (lastPage == 'topUp') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => TopUpScreen(screenName: 'topUp'),
        ));
      }

      if (lastPage == 'addCredit') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AddCreditScreen(),
        ));
      }
      if (lastPage == 'manage') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => TopUpScreen(screenName: 'manage'),
        ));
      }
      if (lastPage == 'payLater') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => TopUpScreen(screenName: 'payLater'),
        ));
      }
      if (lastPage == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PaymentMethodRedeemPointScreen()));
      }
      showSnackBar(context, message: apiResponse.message);
    } catch (error) {
      Navigator.of(context).pop();
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void addItems(
      {required BuildContext context,
      required String orderId,
      required String productId}) async {
    try {
      showLoadingDialog(context: context, title: 'loading...');
      apiResponse1 = await _ordersApiController.addItems(
          orderId: orderId, productId: productId);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => CheckOutView(),
      ));
      showSnackBar(context, message: apiResponse1.message);
      update();
    } catch (e) {
      showSnackBar(context, message: e.toString(), error: true);
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
      for (MealTimes meal in orderToPay[orderToPay.length - 1].orderDetails!.branch!.mealTimes! ) {
        var startTime = int.parse(meal.startTime!);
        var endTime = int.parse(meal.endTime!);
        print('==========================hours hours1');
        print(startTime);
        print(endTime);
        while(startTime < endTime) {
          hours.add(startTime.toString());
          startTime = startTime + 1;
        }
      }
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

  void getCustomerOrder({required BuildContext context}) async {
    try {
      List<Order> orders = [];
      orders = await _ordersApiController.getCustomerOrder();
      for (Order order in customerOrder) {
        if (order.statusName == 'Done') {
          doneorder.removeWhere((element) => element.id == order.id);
          doneorder.add(order);
        }
      }
    customerOrder = orders;
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
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

    print('=====================response duration');
    print(response.body);
    try {
      // final response = await http.get(Url);
      final data = jsonDecode(response.body);
      distance = data["routes"][0]["legs"][0]["distance"]["text"];
      duration = data["routes"][0]["legs"][0]["duration"]["text"];

      print('=====================response duration1');
      print(response.body);
      isLoadingDistance = false;
      isLoadingForOrderTracking = false;
      update();
      // print('===========================================provider duration');
      // DateFormat format = DateFormat('dd-MM-yyyy HH:mm');
      // var s = format.parse(duration);
      print(duration);
      print(distance);
    } catch (e) {
      print('==============================error in duration');
      print(e);
    }
  }

  void getPromoCode(
      {required BuildContext context, required int status}) async {
    try {
      promoCodes =
          await _paymentMethodApiController.getPromoCode(status: status);
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString());
    }
  }

  void getSchedualOrder1({required BuildContext context, String? store = ''}) async{
    try {
      scheduleOrders1 =
      await _ordersApiController.getScheduleOrder(storeName: store);
      update();
    }catch(e) {
      showSnackBar(context, message: e.toString(),error: true);
    }
  }


  void getSchedualOrderById({required BuildContext context, String? id}) async{
    try {
      scheduleOrderById =
      await _ordersApiController.getScheduleOrderById(id: id);
      isLoadingScheduleOrderById = false;
      update();
    }catch(e) {
      showSnackBar(context, message: e.toString(),error: true);
    }
  }

  void getScheduleOrder(
      {required BuildContext context, String? store = ''}) async {
    List<String> names = [];
    List<dynamic> imageList = [];
    try {
      scheduleOrders =
          await _ordersApiController.getScheduleOrder(storeName: store);
      for (int i = 0; i < scheduleOrders.length ; i++) {
        // print('====================branch name');
        names.add(scheduleOrders[i].branch!.storeName!);
        
        imageList.removeWhere((element) =>
        element['storeName'] == names[i]);
        imageList.add({
          'storeName' : scheduleOrders[i].branch!.storeName!,
          'image' : scheduleOrders[i].branch!.branchLogoImage!,
        });
        // print(imageList);
      }
      storeName = names.toSet().toList();
      imageName = imageList;
      // print('==========================image name');
      // print(imageName);
      // print(storeName);
      // print(imageList);
      // print(names);
      update();
    } catch (error) {
      print(error);
      // showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
