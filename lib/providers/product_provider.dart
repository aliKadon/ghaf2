import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghaf_application/domain/model/order.dart';
import 'package:ghaf_application/domain/model/redeem_points.dart';
import 'package:ghaf_application/domain/model/unpaid_order.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../app/constants.dart';
import '../app/preferences/shared_pref_controller.dart';
import '../data/api/api_helper.dart';
import '../domain/model/address.dart';
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

  String repo = '';

  List<OrderAllInformation> ordersPay = [];
  List<OrderAllInformation> orderspending = [];
  List<OrderAllInformation> ordersinProgress = [];
  List<OrderAllInformation> ordersdelivery = [];
  List<OrderAllInformation> ordersUnPay = [];

  var referralCode = '';

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

  var redeemsPoints;

  // List<RedeemPoints> get redeemsPoints {
  //   return [..._redeemsPoints];
  // }

  List<UnpaidOrder> _unpaidOrder = [];

  List<UnpaidOrder> get unpaidOrder {
    return [..._unpaidOrder];
  }

  num allPointsWallet = 0;

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
    List productDiscount = json.decode(response.body)['data'];
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

  Future<void> getProducts() async {
    // // print('================================================');
    var y = SharedPrefController().token;
    // // print(y);
    final response = await http.get(
      Uri.parse("${Constants.urlBase}/product/read-product"),
      headers: {
        HttpHeaders.authorizationHeader: y,
      },
    );
    // // print('=============================HIII');
    // // print(response.statusCode);
    List product = json.decode(response.body)['data'];
    // // print(productDiscount);
    List<Product2> list = [];
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
        category: product[i]['category'],
        characteristics: product[i]['characteristics'],
        deleted: product[i]['deleted'],
        discountDescription: product[i]['discountDescription'],
        ghafImage: product[i]['ghafImage'],
        isInCart: product[i]['isInCart'],
        offer: product[i]['offer'],
        offerDescription: product[i]['offerDescription'],
        productDiscount: product[i]['productDiscount'],
        productReview: product[i]['productReview'],
        productType: product[i]['productType'],
        quantity: product[i]['quantity'],
        redeemDescription: product[i]['redeemDescription'],
        redeemPoints: product[i]['redeemPoints'],
        stars: product[i]['stars'],
        visible: product[i]['visible'],
      ));
    }
    _product = list;
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
    ordersdelivery = listDelivery;
    ordersinProgress = listInProgress;
    ordersPay = listPay;
    orderspending = listPending;
    ordersUnPay = listUnPay;
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

  Future<void> addOrderWithoutAddress(
      String orderId,
      String deliveryMethodId,
      String DesiredDeliveryDate,
      String UseRedeemPoints,
      String UsePayLater,
      String CardNumber,
      String CardExpMonth,
      String CardExpCvc,
      String CardExpYear) async {
    var url = Uri.parse('${Constants.urlBase}/Orders/create-order');
    // final response =
    // print('========================addOrder');
    // print(orderId);
    // print(deliveryMethodId);
    // print(DesiredDeliveryDate);
    // print(address);
    // print(UseRedeemPoints.toString());
    // print(UsePayLater.toString());
    // print(CardNumber);
    final response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    }, body: {
      'OrderId': orderId,
      'DeliveryMethodId': deliveryMethodId,
      'DesiredDeliveryDate': DesiredDeliveryDate,
      // DateTime.parse(DesiredDeliveryDate) == null ?? '',
      'DeliveryPoint': '',
      'UseRedeemPoints': UseRedeemPoints,
      'UsePayLater': UsePayLater,
      'paymentMethodType': 'card',
      'CardNumber': CardNumber,
      'CardExpMonth': CardExpMonth,
      'CardExpCvc': CardExpCvc,
      'CardExpYear': CardExpYear,
    });
    // print('======================================statusCode');
    // print(response.statusCode);
  }

  Future<void> giveReviewForProduct(String productId, String point) async {
    var url = Uri.parse('${Constants.urlBase}/product/read-product');
    final response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    }, body: {
      'prodiId': productId,
      'points': point
    });
    // print('======================================statusCode');
    // print(response.statusCode);
  }

  Future<void> addOrder(
      String orderId,
      String deliveryMethodId,
      String DesiredDeliveryDate,
      String address,
      String UseRedeemPoints,
      String UsePayLater,
      String CardNumber,
      String CardExpMonth,
      String CardExpCvc,
      String CardExpYear) async {
    var url = Uri.parse('${Constants.urlBase}/Orders/create-order');
    // final response =
    // print('========================addOrder');
    // print(orderId);
    // print(deliveryMethodId);
    // print(DesiredDeliveryDate);
    // print(address);
    // print(UseRedeemPoints.toString());
    // print(UsePayLater.toString());
    // print(CardNumber);
    final response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    }, body: {
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
    });
    // print('======================================statusCode');
    // print(response.statusCode);
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
    print(redeemsPoints);
    redeemsPoints = redeem;
    // print('=====================redeem');
    // print(_redeemsPoints);
    notifyListeners();
  }

  Future<void> getUnpaidOrder() async {
    var url = Uri.parse('${Constants.urlBase}/orders/get-customer-order');
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    });

    List unpaid = json.decode(response.body)['data'];
    List<UnpaidOrder> list = [];

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
          unpaid[i]['orderCostForCustomer'],
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
        ),
      );
    }

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

  Future<void> updateInfo(String? firstName, String? lastName, String? phone,
      String? birthdate) async {
    var url = Uri.parse('${Constants.urlBase}/Auth/update-user-info');
    try {
      final response =await http.post(url,
          headers: headers,
          body: jsonEncode({
            'firstname': firstName,
            'lastname': lastName,
            'phone': phone,
            'Birthdate': birthdate
          }));

      print('============================update');
      print(response.body);
      repo = jsonDecode(response.body)['message'];
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAccount() async {
    var url = Uri.parse('${Constants.urlBase}/auth/GetUserDetails');

      final response =await http.post(url,
          headers: headers, );

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
