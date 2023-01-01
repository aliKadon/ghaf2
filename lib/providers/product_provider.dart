import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ghaf_application/domain/model/order.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:http/http.dart' as http;

import '../app/constants.dart';
import '../app/preferences/shared_pref_controller.dart';
import '../domain/model/address.dart';
import '../domain/model/available_delevey_method.dart';
import '../domain/model/delivery_method.dart';
import '../domain/model/product2.dart';
import '../domain/model/product_discount.dart';

class ProductProvider extends ChangeNotifier {
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

  // var x = FirebaseMessagingService.instance.getToken();
  Future<void> getProductDiscount(int discountCount) async {
    print('================================================');
    var y = SharedPrefController().token;
    print(y);
    final response = await http.get(
      Uri.parse(
          "${Constants.urlBase}/product/read-product?filter=productDiscount.discount~eq~$discountCount"),
      headers: {
        HttpHeaders.authorizationHeader: y,
      },
    );
    // print('=============================HIII');
    // print(response.statusCode);
    List productDiscount = json.decode(response.body)['data'];
    // print(productDiscount);
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
    print('================================================');
    var y = SharedPrefController().token;
    print(y);
    final response = await http.get(
      Uri.parse(
          "${Constants.urlBase}/product/read-product"),
      headers: {
        HttpHeaders.authorizationHeader: y,
      },
    );
    // print('=============================HIII');
    // print(response.statusCode);
    List product = json.decode(response.body)['data'];
    // print(productDiscount);
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

    print('=================================ALI ALI');
    print(orders);

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
    }

    _orders = list;
    print('==================alialialaialailai');
    // for(int i = 0; i<= li.length;i++) {
    //   print(_orders[i].toJson());
    // }
    notifyListeners();
  }

  Future<void> getAllDetailsOrder() async {
    var url = Uri.parse("${Constants.urlBase}/orders/get-ready-order-to-pay");

    final response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    });
    List orders = json.decode(response.body)['data'];

    print('=================================ALI ALI');
    print(orders);

    List<OrderAllInformation> list = [];
    for (int i = 0; i < orders.length; i++) {
      list.add(
        OrderAllInformation(
          orders[i]['orderDetails'],
          orders[i]['availableDeliveryMethod'],
          orders[i]['customerPoints'],
        ),
      );
    }

    _orderAllInformation = list;
    print('==================alialialaialailai');
    // for(int i = 0; i<= li.length;i++) {
    //   print(_orders[i].toJson());
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


}
