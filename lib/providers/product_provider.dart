import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghaf_application/domain/model/order.dart';
import 'package:ghaf_application/domain/model/plan_seller_individual.dart';
import 'package:ghaf_application/domain/model/redeem_points.dart';
import 'package:ghaf_application/domain/model/unpaid_order.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app/constants.dart';
import '../app/preferences/shared_pref_controller.dart';
import '../data/api/api_helper.dart';
import '../domain/model/address.dart';
import '../domain/model/api_response.dart';
import '../domain/model/available_delevey_method.dart';
import '../domain/model/delivery_method.dart';
import '../domain/model/product2.dart';
import '../domain/model/product_discount.dart';

class ProductProvider extends ChangeNotifier with ApiHelper {
  num allRedeemPoints = 0;

  num unPaidCount = 0;
  num paidCount = 0;

  num pendingCount = 0;
  num inProgressCount = 0;
  num deliveryCount = 0;

  int statusCode = 0;
  String statusPayment = '';

  String repo = '';

  List<Product2> listPayLater1 = [];

  List<PlanSellerIndividual> _plane = [];

  List<PlanSellerIndividual> get plane {
    return [..._plane];
  }

  List<UnpaidOrder> ordersPay = [];
  List<UnpaidOrder> orderspending = [];
  List<UnpaidOrder> ordersinProgress = [];
  List<UnpaidOrder> ordersdelivery = [];
  List<UnpaidOrder> ordersUnPay = [];

  var referralCode = '';
  List<String> storeName = [];
  List<String> storeId = [];

  var productById = {};

  List<ProductDiscount> _productDiscount = [];

  List<ProductDiscount> get productDiscount {
    return [..._productDiscount];
  }

  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  List<OrderAllInformation> _orderAllInformation = [];

  List<OrderAllInformation> get orderAllInformation {
    return [..._orderAllInformation];
  }

  List<DeliveryMethod> _deliveryMethod = [];

  List<DeliveryMethod> get deliveryMethode {
    return [..._deliveryMethod];
  }

  List<Address> _address = [];

  List<Address> get address {
    return [..._address];
  }

  List<Product2> _product = [];

  List<Product2> get product {
    return [..._product];
  }

  Map<String, dynamic> orderById = {};

  var redeemsPoints;

  // List<RedeemPoints> get redeemsPoints {
  //   return [..._redeemsPoints];
  // }

  List<UnpaidOrder> _unpaidOrder = [];

  List<UnpaidOrder> get unpaidOrder {
    return [..._unpaidOrder];
  }

  num allPointsWallet = 0;

  String message = '';


  Future<ApiResponse> addOrRemoveFromCard({
    required String productId,
  }) async {
    // print('send request : add-remove-to-basket');
    Map<String, dynamic> queryParameters = {
      'id': productId,
    };
    var url =
    Uri.parse('${Constants.urlBase}/Product/add-remove-to-basket?Id=$productId');
    // print(queryParameters);
    var response = await http.post(url,
        headers: headers,);
    var jsonResponse = jsonDecode(response.body);
    print('============================================');
    print(response.statusCode);
    print(jsonResponse);
    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 200) {
        message = jsonResponse['message'];
        return ApiResponse(
          message: jsonResponse['message'],
          status: jsonResponse['status'],
        );
      }
    }
    return failedResponse;
  }

  // var x = FirebaseMessagingService.instance.getToken();
  Future<void> getProductDiscount(int discountCount) async {
    // print('================================================');
    var y = SharedPrefController().token;
    // print(y);
    final response = await http.get(
      Uri.parse(
          "${Constants.urlBase}/product/read-product?filter=productDiscount.discount~eq~$discountCount"),
      headers: {
        HttpHeaders.authorizationHeader: y,
      },
    );
    // // print('=============================HIII');
    // // print(response.statusCode);
    List productDiscount = jsonDecode(response.body)['data'];
    // // print(productDiscount);
    List<ProductDiscount> prDs = [];
    for (int i = 0; i < productDiscount.length; i++) {
      prDs.add(ProductDiscount(
        id: productDiscount[i]['id'],
        description: productDiscount[i]['description'],
        name: productDiscount[i]['name'],
        discount: productDiscount[i]['discount'],
        discountCode: productDiscount[i]['discountCode'],
        expireDate: productDiscount[i]['expireDate'],
        isExclusive: productDiscount[i]['isExclusive'],
        points: productDiscount[i]['points'],
        productsId: productDiscount[i]['productsId'],
        startDate: productDiscount[i]['startDate'],
      ));
    }
    _productDiscount = prDs;
    notifyListeners();
  }

  Future<void> customerSubscribe(String cardNumber, String cvv,
      int expiredMonth, int expiredYear, String PlanId) async {
    var url =
        Uri.parse('${Constants.urlBase}/Auth/customer-subscripe-as-ghafgold');
    try {
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            'paymentMethodType': 'card',
            'cardNumber': cardNumber,
            'cardExpMonth': expiredMonth,
            'cardExpCvc': cvv,
            'cardExpYear': expiredYear,
            'PlanId': PlanId,
          }));

      repo = json.decode(response.body)['message'];
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getProducts() async {
    // // print('================================================');
    var y = SharedPrefController().token;
    // // print(y);
    final response = await http.get(
      Uri.parse("${Constants.urlBase}/Product/read-product/"),
      headers: headers
    );

    List product = json.decode(response.body)['data'];
    // // print(productDiscount);
    List<Product2> list = [];

    List<Product2> listPayLater = [];
    List<String> store = [];
    List<String> storeID = [];
    for (int i = 0; i < product.length; i++) {
      list.add(Product2(
          id: product[i]['id'],
          isoCurrencySymbol: product[i]['isoCurrencySymbol'],
          branch: product[i]['branch'],
          name: product[i]['name'],
          description: product[i]['description'],
          isFavorite: product[i]['isFavorite'],
          price: product[i]['price'],
          addedAt: product[i]['addedAt'],
          approved: product[i]['approved'],
          canPayLater: product[i]['canPayLater'],
          canPayLaterDays: product[i]['canPayLaterDays'],
          category: product[i]['category'],
          characteristics: product[i]['characteristics'],
          deleted: product[i]['deleted'],
          discountDescription: product[i]['discountDescription'],
          ghafImage: product[i]['ghafImage'],
          isInCart: product[i]['isInCart'],
          offer: product[i]['offer'],
          discountValueForGoldenUsers: product[i]['discountValueForGoldenUsers'],
          discountValueForAllUsers: product[i]['discountValueForAllUsers'],
          productImages: product[i]['productImages'],
          onlyOnGhaf: product[i]['onlyOnGhaf'],
          subscriptionHide: product[i]['subscriptionHide'],
          reviewCount: product[i]['reviewCount'],
          storeReviewCount: product[i]['storeReviewCount'],
          timeToPrepareMinutes: product[i]['timeToPrepareMinutes'],
          offerDescription: product[i]['offerDescription'],
          productDiscount: product[i]['productDiscount'],
          productReview: product[i]['productReview'],
          productType: product[i]['productType'],
          quantity: product[i]['quantity'],
          redeemDescription: product[i]['redeemDescription'],
          redeemPoints: product[i]['redeemPoints'],
          stars: product[i]['stars'],
          visible: product[i]['visible'],
          storeStars: product[i]['storeStars'] ?? 0));
      
      
      // if (product[i]['canPayLater'] == true) {
      //   listPayLater.add(Product2(
      //       id: product[i]['id'],
      //       isoCurrencySymbol: product[i]['isoCurrencySymbol'],
      //       branch: product[i]['branch'],
      //       name: product[i]['name'],
      //       description: product[i]['description'],
      //       isFavorite: product[i]['isFavorite'],
      //       price: product[i]['price'],
      //       addedAt: product[i]['addedAt'],
      //       approved: product[i]['approved'],
      //       canPayLater: product[i]['canPayLater'],
      //       canPayLaterDays: product[i]['canPayLaterDays'],
      //       category: product[i]['category'],
      //       characteristics: product[i]['characteristics'],
      //       deleted: product[i]['deleted'],
      //       discountDescription: product[i]['discountDescription'],
      //       ghafImage: product[i]['ghafImage'],
      //       isInCart: product[i]['isInCart'],
      //       offer: product[i]['offer'],
      //       offerDescription: product[i]['offerDescription'],
      //       productDiscount: product[i]['productDiscount'],
      //       productReview: product[i]['productReview'],
      //       productType: product[i]['productType'],
      //       quantity: product[i]['quantity'],
      //       redeemDescription: product[i]['redeemDescription'],
      //       redeemPoints: product[i]['redeemPoints'],
      //       stars: product[i]['stars'],
      //       visible: product[i]['visible'],
      //       storeStars: product[i]['storeStars'] ?? 0));
      // }
      // store.add(product[i]['branch']['branchName']);
      // storeID.add(product[i]['branch']['id']);
    }
    // listPayLater1 = listPayLater;
    _product = list;
    // storeName = store.toSet().toList();
    // storeId = storeID.toSet().toList();
    // print('================================products');
    // print(list);
    notifyListeners();
  }

  Future<void> getOrderById(String id) async {
    var url = Uri.parse("${Constants.urlBase}/orders/get-order-by-id?id=$id");
    final response = await http.get(url, headers: headers);

    Map<String, dynamic> data = jsonDecode(response.body)['data'];

    print('=====================================orderById');
    print(data);

    orderById = data;
    notifyListeners();
  }

  Future<void> getOrders() async {
    var url = Uri.parse("${Constants.urlBase}/orders/get-ready-order-to-pay");

    final response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    });
    List orders = json.decode(response.body)['data'];

    // print('=================================ALI ALI');
    // print(orders);

    num pay = 0;
    num unPay = 0;
    num pending = 0;
    num inProgress = 0;
    num delivery = 0;

    List<Order> list = [];
    for (int i = 0; i < orders.length; i++) {
      list.add(Order(
        userCredentialsId: orders[i]['orderDetails']['userCredentialsId'],
        totalCostForItems: orders[i]['orderDetails']['totalCostForItems'],
        status: orders[i]['orderDetails']['status'],
        redeemPointsForProducts: orders[i]['orderDetails']
            ['redeemPointsForProducts'],
        redeemPointsForBill: orders[i]['orderDetails']['redeemPointsForBill'],
        redeemPointsFactor: orders[i]['orderDetails']['redeemPointsFactor'],
        payed: orders[i]['orderDetails']['payed'],
        orderCostForCustomer: orders[i]['orderDetails']['orderCostForCustomer'],
        items: orders[i]['orderDetails']['items'],
        estimatedDeliveryDate: orders[i]['orderDetails']
            ['estimatedDeliveryDate'],
        desiredDeliveryDate: orders[i]['orderDetails']['desiredDeliveryDate'],
        deliveryPoint: orders[i]['orderDetails']['deliveryPoint'],
        deliveryMethod: orders[i]['orderDetails']['deliveryMethod'],
        deliverdAt: orders[i]['orderDetails']['deliverdAt'],
        deleveryCost: orders[i]['orderDetails']['deleveryCost'],
        currentLocation: orders[i]['orderDetails']['currentLocation'],
        createDate: orders[i]['orderDetails']['createDate'],
        canPayLaterValue: orders[i]['orderDetails']['canPayLaterValue'],
        branch: orders[i]['orderDetails']['branch'],
        id: orders[i]['orderDetails']['id'],
      ));
      if (orders[i]['orderDetails']['statusName'] == 'Paid') {
        pay++;
      } else if (orders[i]['orderDetails']['statusName'] == 'UnPaid') {
        unPay++;
      } else if (orders[i]['orderDetails']['statusName'] == 'Intialized' ||
          orders[i]['orderDetails']['statusName'] == 'NotAssignedToEmployee') {
        pending++;
      } else if (orders[i]['orderDetails']['statusName'] ==
          'AssignedToEmployee') {
        inProgress++;
      } else if (orders[i]['orderDetails']['statusName'] ==
              'AssignedToDriver' ||
          orders[i]['orderDetails']['statusName'] == 'ReadyForDriver') {
        delivery++;
      }
    }

    unPaidCount = unPay;
    paidCount = pay;
    pendingCount = pending;
    inProgressCount = inProgress;
    deliveryCount = delivery;
    _orders = list;

    // print('==================alialialaialailai');
    // for(int i = 0; i<= li.length;i++) {
    //   // print(_orders[i].toJson());
    // }
    notifyListeners();
  }

  Future<void> getAllDetailsOrder() async {
    var url = Uri.parse("${Constants.urlBase}/orders/get-ready-order-to-pay");

    final response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    });
    List orders = json.decode(response.body)['data'];

    // print('=================================ALI ALI');
    // print(orders);
    num wallet = 0;

    List<OrderAllInformation> listPay = [];
    List<OrderAllInformation> listUnPay = [];
    List<OrderAllInformation> listDelivery = [];
    List<OrderAllInformation> listPending = [];
    List<OrderAllInformation> listInProgress = [];

    List<OrderAllInformation> list = [];
    for (int i = 0; i < orders.length; i++) {
      list.add(
        OrderAllInformation(
          orders[i]['orderDetails'],
          orders[i]['availableDeliveryMethod'],
          orders[i]['customerPoints'],
        ),
      );
      if (orders[i]['orderDetails']['statusName'] == 'Paid') {
        listPay.add(OrderAllInformation(
          orders[i]['orderDetails'],
          orders[i]['availableDeliveryMethod'],
          orders[i]['customerPoints'],
        ));
      } else if (orders[i]['orderDetails']['statusName'] == 'UnPaid') {
        listUnPay.add(OrderAllInformation(
          orders[i]['orderDetails'],
          orders[i]['availableDeliveryMethod'],
          orders[i]['customerPoints'],
        ));
      } else if (orders[i]['orderDetails']['statusName'] == 'Intialized' ||
          orders[i]['orderDetails']['statusName'] == 'NotAssignedToEmployee') {
        listPending.add(OrderAllInformation(
          orders[i]['orderDetails'],
          orders[i]['availableDeliveryMethod'],
          orders[i]['customerPoints'],
        ));
      } else if (orders[i]['orderDetails']['statusName'] ==
          'AssignedToEmployee') {
        listInProgress.add(OrderAllInformation(
          orders[i]['orderDetails'],
          orders[i]['availableDeliveryMethod'],
          orders[i]['customerPoints'],
        ));
      } else if (orders[i]['orderDetails']['statusName'] ==
              'AssignedToDriver' ||
          orders[i]['orderDetails']['statusName'] == 'ReadyForDriver') {
        listDelivery.add(OrderAllInformation(
          orders[i]['orderDetails'],
          orders[i]['availableDeliveryMethod'],
          orders[i]['customerPoints'],
        ));
      }

      wallet = wallet + orders[i]['customerPoints'];
    }
    allPointsWallet = wallet;
    _orderAllInformation = list;
    // ordersdelivery = listDelivery;
    // ordersinProgress = listInProgress;
    // ordersPay = listPay;
    // orderspending = listPending;
    // ordersUnPay = listUnPay;
    // print('==================alialialaialailai');
    // for(int i = 0; i<= li.length;i++) {
    //   // print(_orders[i].toJson());
    // }
    notifyListeners();
  }

  Future<void> getAddress() async {
    var url = Uri.parse('${Constants.urlBase}/Auth/get-user-address');
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    });
    List addresses = json.decode(response.body)['data'];
    List<Address> list = [];
    for (int i = 0; i < addresses.length; i++) {
      list.add(
        Address(
          id: addresses[i]['id'],
          addressName: addresses[i]['addressName'],
          altitude: addresses[i]['altitude'],
          longitude: addresses[i]['longitude'],
          phone: addresses[i]['phone'],
        ),
      );
    }
    _address = list;
    notifyListeners();
  }

  // Future<void> payForOrder(String orderId, String deliveryId,)

  Future<void> getProductById(String id) async{
    var url = Uri.parse('${Constants.urlBase}/Product/get-product-by-id?prodId=$id');
    final response = await http.get(url, headers: headers);
    var data = json.decode(response.body)['data'];
    List<Address> list = [];
    // for (int i = 0; i < addresses.length; i++) {
    //   list.add(
    //     Address(
    //       id: addresses[i]['id'],
    //       addressName: addresses[i]['addressName'],
    //       altitude: addresses[i]['altitude'],
    //       longitude: addresses[i]['longitude'],
    //       phone: addresses[i]['phone'],
    //     ),
    //   );
    // }
    // print('====================================productByid');
    // print(data);
    productById = data;
    notifyListeners();
  }

  Future<void> addOrderWithoutAddress(
      {required String orderId,
      required String deliveryMethodId,
      required String DesiredDeliveryDate,
      required bool UseRedeemPoints,
      required bool UsePayLater,
      required String CardNumber,
      required int CardExpMonth,
      required String CardExpCvc,
      required int CardExpYear}) async {
    var url = Uri.parse('${Constants.urlBase}/Orders/pay-for-order');
    // final response =
    // print('========================addOrder');
    // print(orderId);
    // print(deliveryMethodId);
    // print(DesiredDeliveryDate);
    // print(address);
    // print(UseRedeemPoints.toString());
    // print(UsePayLater.toString());
    // print(CardNumber);
    final response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "orderId": orderId,
          "deliveryMethodId": deliveryMethodId,
          "desiredDeliveryDate": DesiredDeliveryDate,
          "deliveryPoint": null,
          "useRedeemPoints": UseRedeemPoints,
          "usePayLater": UsePayLater,
          "paymentMethodType": "card",
          "cardNumber": CardNumber,
          "cardExpMonth": CardExpMonth,
          "cardExpCvc": CardExpCvc,
          "cardExpYear": CardExpYear
        }));
    print('======================================statusCode');
    print(response.statusCode);
    print(response.body);
  }

  Future<void> giveReviewForProduct(String productId, String point) async {
    var url = Uri.parse(
        '${Constants.urlBase}/product/read-product?prodiId=$productId&points=$point');
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPrefController().token,
      },
    );
    // print('======================================statusCode');
    // print(response.statusCode);
  }

  Future<void> addOrder(
      String orderId,
      String deliveryMethodId,
      String DesiredDeliveryDate,
      Address address,
      bool UseRedeemPoints,
      bool UsePayLater,
      String CardNumber,
      int CardExpMonth,
      String CardExpCvc,
      int CardExpYear) async {
    var url = Uri.parse('${Constants.urlBase}/Orders/pay-for-order');
    // final response =
    // print('========================addOrder');
    // print(orderId);
    // print(deliveryMethodId);
    // print(DesiredDeliveryDate);
    // print(address);
    // print(UseRedeemPoints.toString());
    // print(UsePayLater.toString());
    // print(CardNumber);
    final response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          'OrderId': orderId,
          'DeliveryMethodId': deliveryMethodId,
          'DesiredDeliveryDate': DesiredDeliveryDate,
          // DateTime.parse(DesiredDeliveryDate) == null ?? '',
          'DeliveryPoint': address,
          'UseRedeemPoints': UseRedeemPoints,
          'UsePayLater': UsePayLater,
          'paymentMethodType': 'card',
          'CardNumber': CardNumber,
          'CardExpMonth': CardExpMonth,
          'CardExpCvc': CardExpCvc,
          'CardExpYear': CardExpYear,
        }));
    statusCode = jsonDecode((response.body))['status'];
    if (jsonDecode(response.body)['status'] == 500) {
      var data = jsonDecode((response.body))['data'];
      var s = data.indexOf(':');
      var l = data.indexOf('.',s+ '.'.length);
      var g = data.substring(s+1,l);
      statusPayment = g;
    }else if (jsonDecode(response.body)['status'] == 400) {
      statusPayment = jsonDecode((response.body))['message'];
    }else {
      statusPayment = jsonDecode((response.body))['data'];
    }


    print('======================================statusCode');
    print(response.statusCode);
    print(response.body);
    print('=====================================myStatusCode');
    print(statusCode);
    print('======================================dataPayment');
    print(statusPayment);




    // try {
    //   final response = await http.post(url, headers: {
    //     HttpHeaders.authorizationHeader: SharedPrefController().token,
    //   }, body: {
    //     'OrderId': orderId,
    //     'DeliveryMethodId': deliveryMethodId,
    //     'DesiredDeliveryDate': DesiredDeliveryDate,
    //         // DateTime.parse(DesiredDeliveryDate) == null ?? '',
    //     'DeliveryPoint': address == null ?? '',
    //     'UseRedeemPoints': UseRedeemPoints.toString(),
    //     'UsePayLater': UsePayLater.toString(),
    //     'paymentMethodType': 'card',
    //     'CardNumber': CardNumber,
    //     'CardExpMonth': CardExpMonth,
    //     'CardExpCvc': CardExpCvc,
    //     'CardExpYear': CardExpYear,
    //   });
    //   // print(response.statusCode);
    // } catch (e) {
    //   // // print(response.statusCode);
    //   // print(e.toString());
    // }
  }

  Future<void> getPlane() async {
    var url = Uri.parse('${Constants.urlBase}/auth/get-customer-plans');
    final response = await http.get(url, headers: headers);
    List plane = jsonDecode(response.body)['data'];
    List<PlanSellerIndividual> data = [];

    for (int i = 0; i < plane.length; i++) {
      data.add(PlanSellerIndividual(
          id: plane[i]['id'],
          name: plane[i]['name'],
          description: plane[i]['description'],
          priceId: plane[i]['priceId'],
          stripeId: plane[i]['stripeId'],
          type: plane[i]['type'],
          freeDays: plane[i]['freeDays'],
          hide: plane[i]['hide'],
          priceAmount: plane[i]['priceAmount'],
          priceCurrency: plane[i]['priceCurrency'],
          priceRecuencyInterval: plane[i]['priceRecuencyInterval'],
          setUpCost: plane[i]['setUpCost'],
          typeName: plane[i]['typeName']));
    }

    print('=================================plane');
    print(jsonDecode(response.body));

    _plane = data;

    print('=================================data');
    print(data);
    notifyListeners();
  }

  Future<void> getRedeemPoints() async {
    var url =
        Uri.parse('${Constants.urlBase}/GiftAndReward/get-customer-redeem');
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    });
    var redeem = jsonDecode(response.body)['data'];
    List<RedeemPoints> list = [];

    // for (int i = 0; i < redeem.length; i++) {
    //   list.add(
    //     RedeemPoints(
    //       redeem[i]['list'],
    //       redeem[i]['total'],
    //     ),
    //   );
    //   allRedeemPoints = allRedeemPoints + redeem[i]['points'];
    // }
    print('===========================redeemsPoints');

    redeemsPoints = redeem;
    print(redeemsPoints.length);
    print('=====================redeem');
    print(redeemsPoints);
    print(redeem);
    notifyListeners();
  }

  Future<void> getUnpaidOrder() async {
    var url = Uri.parse('${Constants.urlBase}/orders/get-customer-order');
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    });

    List unpaid = json.decode(response.body)['data'];
    List<UnpaidOrder> list = [];

    num pay = 0;
    num unPay = 0;
    num pending = 0;
    num inProgress = 0;
    num delivery = 0;

    List<UnpaidOrder> listPay = [];
    List<UnpaidOrder> listUnPay = [];
    List<UnpaidOrder> listDelivery = [];
    List<UnpaidOrder> listPending = [];
    List<UnpaidOrder> listInProgress = [];

    for (int i = 0; i < unpaid.length; i++) {
      list.add(
        UnpaidOrder(
            unpaid[i]['id'],
            unpaid[i]['createDate'],
            unpaid[i]['estimatedDeliveryDate'],
            unpaid[i]['desiredDeliveryDate'],
            unpaid[i]['deliverdAt'],
            unpaid[i]['deliveryPoint'],
            unpaid[i]['currentLocation'],
            unpaid[i]['status'],
            unpaid[i]['payed'],
            unpaid[i]['deliveryMethod'],
            unpaid[i]['deleveryCost'],
            (unpaid[i]['orderCostForCustomer']).toDouble(),
            unpaid[i]['totalCostForItems'],
            unpaid[i]['statusName'],
            unpaid[i]['customer'],
            unpaid[i]['items'],
            unpaid[i]['userCredentialsId'],
            unpaid[i]['branch'],
            unpaid[i]['canPayLaterValue'],
            unpaid[i]['redeemPointsForProducts'],
            unpaid[i]['redeemPointsForBill'],
            unpaid[i]['redeemPointsFactor'],
            unpaid[i]['driverId']),
      );
      if (unpaid[i]['statusName'] == 'Done') {
        pay++;
        listPay.add(
          UnpaidOrder(
              unpaid[i]['id'],
              unpaid[i]['createDate'],
              unpaid[i]['estimatedDeliveryDate'],
              unpaid[i]['desiredDeliveryDate'],
              unpaid[i]['deliverdAt'],
              unpaid[i]['deliveryPoint'],
              unpaid[i]['currentLocation'],
              unpaid[i]['status'],
              unpaid[i]['payed'],
              unpaid[i]['deliveryMethod'],
              unpaid[i]['deleveryCost'],
              (unpaid[i]['orderCostForCustomer']).toDouble(),
              unpaid[i]['totalCostForItems'],
              unpaid[i]['statusName'],
              unpaid[i]['customer'],
              unpaid[i]['items'],
              unpaid[i]['userCredentialsId'],
              unpaid[i]['branch'],
              unpaid[i]['canPayLaterValue'],
              unpaid[i]['redeemPointsForProducts'],
              unpaid[i]['redeemPointsForBill'],
              unpaid[i]['redeemPointsFactor'],
              unpaid[i]['driverId']),
        );
      } else if (unpaid[i]['statusName'] == 'UnPaid') {
        unPay++;
        listUnPay.add(
          UnpaidOrder(
              unpaid[i]['id'],
              unpaid[i]['createDate'],
              unpaid[i]['estimatedDeliveryDate'],
              unpaid[i]['desiredDeliveryDate'],
              unpaid[i]['deliverdAt'],
              unpaid[i]['deliveryPoint'],
              unpaid[i]['currentLocation'],
              unpaid[i]['status'],
              unpaid[i]['payed'],
              unpaid[i]['deliveryMethod'],
              unpaid[i]['deleveryCost'],
              (unpaid[i]['orderCostForCustomer']).toDouble(),
              unpaid[i]['totalCostForItems'],
              unpaid[i]['statusName'],
              unpaid[i]['customer'],
              unpaid[i]['items'],
              unpaid[i]['userCredentialsId'],
              unpaid[i]['branch'],
              unpaid[i]['canPayLaterValue'],
              unpaid[i]['redeemPointsForProducts'],
              unpaid[i]['redeemPointsForBill'],
              unpaid[i]['redeemPointsFactor'],
              unpaid[i]['driverId']),
        );
      } else if (unpaid[i]['statusName'] == 'Intialized' ||
          unpaid[i]['statusName'] == 'NotAssignedToEmployee' || unpaid[i]['statusName'] == 'Paid') {
        pending++;
        listPending.add(
          UnpaidOrder(
              unpaid[i]['id'],
              unpaid[i]['createDate'],
              unpaid[i]['estimatedDeliveryDate'],
              unpaid[i]['desiredDeliveryDate'],
              unpaid[i]['deliverdAt'],
              unpaid[i]['deliveryPoint'],
              unpaid[i]['currentLocation'],
              unpaid[i]['status'],
              unpaid[i]['payed'],
              unpaid[i]['deliveryMethod'],
              unpaid[i]['deleveryCost'],
              (unpaid[i]['orderCostForCustomer']).toDouble(),
              unpaid[i]['totalCostForItems'],
              unpaid[i]['statusName'],
              unpaid[i]['customer'],
              unpaid[i]['items'],
              unpaid[i]['userCredentialsId'],
              unpaid[i]['branch'],
              unpaid[i]['canPayLaterValue'],
              unpaid[i]['redeemPointsForProducts'],
              unpaid[i]['redeemPointsForBill'],
              unpaid[i]['redeemPointsFactor'],
              unpaid[i]['driverId']),
        );
      } else if (unpaid[i]['statusName'] == 'AssignedToEmployee') {
        inProgress++;
        listInProgress.add(
          UnpaidOrder(
              unpaid[i]['id'],
              unpaid[i]['createDate'],
              unpaid[i]['estimatedDeliveryDate'],
              unpaid[i]['desiredDeliveryDate'],
              unpaid[i]['deliverdAt'],
              unpaid[i]['deliveryPoint'],
              unpaid[i]['currentLocation'],
              unpaid[i]['status'],
              unpaid[i]['payed'],
              unpaid[i]['deliveryMethod'],
              unpaid[i]['deleveryCost'],
              (unpaid[i]['orderCostForCustomer']).toDouble(),
              unpaid[i]['totalCostForItems'],
              unpaid[i]['statusName'],
              unpaid[i]['customer'],
              unpaid[i]['items'],
              unpaid[i]['userCredentialsId'],
              unpaid[i]['branch'],
              unpaid[i]['canPayLaterValue'],
              unpaid[i]['redeemPointsForProducts'],
              unpaid[i]['redeemPointsForBill'],
              unpaid[i]['redeemPointsFactor'],
              unpaid[i]['driverId']),
        );
      } else if (unpaid[i]['statusName'] == 'AssignedToDriver' ||
          unpaid[i]['statusName'] == 'ReadyForDriver' || unpaid[i]['statusName'] =='OnWay') {
        delivery++;
        listDelivery.add(
          UnpaidOrder(
              unpaid[i]['id'],
              unpaid[i]['createDate'],
              unpaid[i]['estimatedDeliveryDate'],
              unpaid[i]['desiredDeliveryDate'],
              unpaid[i]['deliverdAt'],
              unpaid[i]['deliveryPoint'],
              unpaid[i]['currentLocation'],
              unpaid[i]['status'],
              unpaid[i]['payed'],
              unpaid[i]['deliveryMethod'],
              unpaid[i]['deleveryCost'],
              (unpaid[i]['orderCostForCustomer']).toDouble(),
              unpaid[i]['totalCostForItems'],
              unpaid[i]['statusName'],
              unpaid[i]['customer'],
              unpaid[i]['items'],
              unpaid[i]['userCredentialsId'],
              unpaid[i]['branch'],
              unpaid[i]['canPayLaterValue'],
              unpaid[i]['redeemPointsForProducts'],
              unpaid[i]['redeemPointsForBill'],
              unpaid[i]['redeemPointsFactor'],
              unpaid[i]['driverId']),
        );
      }
    }

    unPaidCount = unPay;
    paidCount = pay;
    pendingCount = pending;
    inProgressCount = inProgress;
    deliveryCount = delivery;

    ordersdelivery = listDelivery;
    ordersinProgress = listInProgress;
    ordersPay = listPay;
    orderspending = listPending;
    ordersUnPay = listUnPay;

    _unpaidOrder = list;
    // print('=======================unpaid');
    // print(_unpaidOrder);
    notifyListeners();
  }

  Future<void> addToCart(String id) async {
    var Url =
        Uri.parse('${Constants.urlBase}/Product/add-remove-to-basket?id=$id');
    try {
      final response = await http.post(Url, headers: {
        HttpHeaders.authorizationHeader: SharedPrefController().token,
      });
      // print('=======================addTocart');
      // print(response);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> getReferralCode() async {
    var Url = Uri.parse('${Constants.urlBase}/Auth/get-my-referral');
    try {
      final response = await http.get(Url, headers: {
        HttpHeaders.authorizationHeader: SharedPrefController().token,
      });
      final referralCode1 = json.decode(response.body)['data'];
      referralCode = referralCode1;
      // print('=======================referral');
      // print(response);
    } catch (e) {
      // print(e);
    }
  }

  var distance = '0';
  var duration = '0';

  Future<void> getDurationGoogleMap({
    required double LatOne,
    required double LonOne,
    required double LatTow,
    required double LonTow,
  }) async {
    var Url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${LatOne},${LonOne}&destination=${LatTow},${LonTow}&key=${Constants.google_key_map}');
    try {
      final response = await http.get(Url);
      final data = json.decode(response.body);
      distance = data["routes"][0]["legs"][0]["distance"]["text"];
      duration = data["routes"][0]["legs"][0]["duration"]["text"];

      print('===========================================provider duration');
      // DateFormat format = DateFormat('dd-MM-yyyy HH:mm');
      // var s = format.parse(duration);
      print(duration);
      print(distance);
      notifyListeners();



    } catch (e) {
       print(e);

    }
  }

  Future<void> updateInfo(String? firstName, String? lastName, String? phone,
      String? birthdate) async {
    var url = Uri.parse(
        '${Constants.urlBase}/Auth/update-user-info?firstname=$firstName&lastname=$lastName&phone=$phone&Birthdate=$birthdate');
    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      print('============================update');
      print(response.body);
      repo = jsonDecode(response.body)['message'];
    } catch (e) {
      print(e);
    }
  }

  Future<void> changeUserInfo(
    String? oldPassword,
    String? newPassword,
    String? confirmNewPassword,
  ) async {
    var url = Uri.parse(
        '${Constants.urlBase}oldPassword?oldPassword=$oldPassword&newPassword=$newPassword&confirmNewPassword=$confirmNewPassword');
    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      print('============================update');
      print(response.body);
      repo = jsonDecode(response.body)['message'];
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAccount() async {
    var url = Uri.parse('${Constants.urlBase}/Auth/delete-user-account');

    final response = await http.post(
      url,
      headers: headers,
    );

    print('============================delete-user-account');
    print(response.body);
    repo = jsonDecode(response.body)['message'];
  }

  String messageReviewStore = '';

  Future<void> postReviewStore(
      String storeId, String opinion, int points) async {
    var url = Uri.parse(
        '${Constants.urlBase}/auth/create-store-review?storeId=${storeId}&opinion=$opinion&points=$points');
    try {
      final response = await http.post(
        url,
        headers: headers,
      );
      // print(response);
      messageReviewStore = jsonDecode(response.body)['message'];
      print(messageReviewStore);
      print('===================================store');

      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> postReviewEmployee(
      String storeId, String opinion, int points) async {
    var url = Uri.parse(
        '${Constants.urlBase}/Employee/create-review?storeId=$storeId&opinion=$opinion&points=$points');
    try {
      final response = await http.post(
        url,
        headers: headers,
      );
      print('===================================employee');
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> clearCart() async {
    var url = Uri.parse('${Constants.urlBase}/Product/empty-basket');

    final response = await http.post(
      url,
      headers: headers,
    );

    print('============================update');
    print(response.body);
    repo = jsonDecode(response.body)['message'];
  }

  int getTotalPoints() {
    num totla = 0;
    for (int i = 0; i < _orders.length; i++) {
      totla = totla + _orders[i].totalCostForItems!;
    }

    return int.parse(totla.toString());
  }

  getWebpage(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'an error occurred';
    }
  }
}
