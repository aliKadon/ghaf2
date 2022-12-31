import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../app/constants.dart';
import '../app/preferences/shared_pref_controller.dart';
import '../domain/model/product_discount.dart';
import 'package:http/http.dart' as http;

import '../services/firebase_messaging_service.dart';


class ProductProvider extends ChangeNotifier {
  List<ProductDiscount> _productDiscount = [];

  List<ProductDiscount> get productDiscount {
    return [..._productDiscount];
  }


  // var x = FirebaseMessagingService.instance.getToken();
  Future<void> getProductDiscount(int discountCount) async {
    print('================================================');
    var y = SharedPrefController().token;
    print(y);
    final response = await http.get(Uri.parse("${Constants.urlBase}/product/read-product?filter=productDiscount.discount~eq~$discountCount"), headers: {
    HttpHeaders.authorizationHeader: y,
    },);
    print('=============================');
    print(response.statusCode);
    List productDiscount = json.decode(response.body)['data'];
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
}
