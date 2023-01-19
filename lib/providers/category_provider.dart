import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/domain/model/product2.dart';
import 'package:http/http.dart' as http;


class CategoryProvider extends ChangeNotifier with ApiHelper {

  List<String> store = [];
  List<String> storeId = [];
 
  List<Product2> _storeByCategory = [];

  List<Product2> get storeByCategory {
    return [..._storeByCategory];
  }

  List<Product2> _productByStore = [];

  List<Product2> get productByStore {
    return [..._productByStore];
  }
  
  Future<void> getStoreForCategory(String categoryId) async{
    var url = Uri.parse('${Constants.urlBase}/Product/read-product?cid=$categoryId');
    var response = await http.get(url,headers: headers);
    List data = jsonDecode(response.body)['data'];

    List<Product2> list = [];
    List<String> storeName = [];
    List<String> storeID = [];
    for(int i = 0 ; i < data.length; i++) {
      list.add(Product2(
        id: data[i]['id'],
        isoCurrencySymbol: data[i]['isoCurrencySymbol'],
        storeStars: data[i]['storeStars'],
        visible: data[i]['visible'],
        stars: data[i]['stars'],
        redeemPoints: data[i]['redeemPoints'],
        redeemDescription: data[i]['redeemDescription'],
        quantity: data[i]['quantity'],
        productType: data[i]['productType'],
        productReview: data[i]['productReview'],
        productDiscount: data[i]['productDiscount'],
        offerDescription: data[i]['offerDescription'],
        offer: data[i]['offer'],
        isInCart: data[i]['isInCart'],
        ghafImage: data[i]['ghafImage'],
        discountDescription: data[i]['discountDescription'],
        deleted: data[i]['deleted'],
        characteristics: data[i]['characteristics'],
        category: data[i]['category'],
        approved: data[i]['approved'],
        addedAt: data[i]['addedAt'],
        price: data[i]['price'],
        isFavorite: data[i]['isFavorite'],
        description: data[i]['description'],
        name: data[i]['name'],
        branch: data[i]['branch'],
        canPayLater: data[i]['canPayLater'],
        canPayLaterDays: data[i]['canPayLaterDays'],
        reviewCount: data[i]['reviewCount']
      ));
      storeName.add(data[i]['branch']['storeName']);
      storeID.add(data[i]['branch']['storeId']);
    }
    _storeByCategory = list;
    store = storeName.toSet().toList();
    storeId = storeID;
    notifyListeners();

  }

  Future<void> getProductForStore(String storeId) async{
    var url = Uri.parse('${Constants.urlBase}/product/read-product?sid=$storeId');
    var response = await http.get(url,headers: headers);
    List data = jsonDecode(response.body)['data'];

    List<Product2> list = [];
    List<String> storeName = [];

    for(int i = 0 ; i < data.length; i++) {
      list.add(Product2(
          id: data[i]['id'],
          isoCurrencySymbol: data[i]['isoCurrencySymbol'],
          storeStars: data[i]['storeStars'],
          visible: data[i]['visible'],
          stars: data[i]['stars'],
          redeemPoints: data[i]['redeemPoints'],
          redeemDescription: data[i]['redeemDescription'],
          quantity: data[i]['quantity'],
          productType: data[i]['productType'],
          productReview: data[i]['productReview'],
          productDiscount: data[i]['productDiscount'],
          offerDescription: data[i]['offerDescription'],
          offer: data[i]['offer'],
          isInCart: data[i]['isInCart'],
          ghafImage: data[i]['ghafImage'],
          discountDescription: data[i]['discountDescription'],
          deleted: data[i]['deleted'],
          characteristics: data[i]['characteristics'],
          category: data[i]['category'],
          approved: data[i]['approved'],
          addedAt: data[i]['addedAt'],
          price: data[i]['price'],
          isFavorite: data[i]['isFavorite'],
          description: data[i]['description'],
          name: data[i]['name'],
          branch: data[i]['branch'],
          canPayLater: data[i]['canPayLater'],
          canPayLaterDays: data[i]['canPayLaterDays'],
          reviewCount: data[i]['reviewCount']
      ));
      storeName.add(data[i]['branch']['storeName']);

    }
    _productByStore = list;
    notifyListeners();

  }
  
}