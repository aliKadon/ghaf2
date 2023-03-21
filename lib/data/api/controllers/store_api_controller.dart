import 'dart:convert';

// import 'package:basic_utils/basic_utils.dart';
// import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/branch.dart';
import 'package:ghaf_application/domain/model/cart_item.dart';
import 'package:ghaf_application/domain/model/category.dart';
import 'package:ghaf_application/domain/model/nearby_stores.dart';
import 'package:ghaf_application/domain/model/popular_search.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/store.dart';
import '../api_helper.dart';

class StoreApiController with ApiHelper, Helpers {
  late final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  Future<List<Product>> getMostPopularProduct({String? bid}) async {
    // // print('send request : getProducts');
    Map<String, dynamic> queryParameters = {
      'bid': bid,
      // 'filter':
      // "Name~contains~'$search'~and~${filterBy ?? 'price'}~gte~${minPrice ??
      //     0}~and~${filterBy ?? 'price'}~lte~${maxPrice ?? 500}",
    };
    // // print(queryParameters);
    final Response response = await _dio.get(
      '/product/get-trending-products',
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================PRODUCT');
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return List<Product>.from(
            response.data["data"].map((x) => Product.fromJson(x)));
      }
    }
    return [];
  }

  Future<List<Category>> getCategories() async {
    Uri uri = Uri.parse('${Constants.baseUrl}/Category/GetCategories');
    var response = await http.get(
      uri,
      headers: headers,
    );
    // // print('111');
    // // print('============================================');
    // // print(response.statusCode);
    // // print(response.body);
    if (response.statusCode == 200) {
      // // print('222');
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        var jsonArray = jsonResponse['data'] as List;
        return jsonArray
            .map((jsonObject) => Category.fromJson(jsonObject))
            .toList();
      }
    }
    return [];
  }

  Future<List<String>> getRecentSearches() async {
    final Response response = await _dio.get(
      '/Product/get-old-search?pageIndex=1&pageRows=7',
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================RECENT SEARCHES');
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return List<String>.from(response.data["data"]);
      }
    }
    return [];
  }

  Future<List<NearbyStores>> getNearbyStores(
      {required String lat, required String long, String? distance}) async {
    Map<String, dynamic> queryParameters = {
      'distance': distance,
      'lat': lat,
      'lng': long
    };
    final Response response = await _dio.get(
      '/NearBy/get-nearby-stores',
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================POPULAR SEARCHES');
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return List<NearbyStores>.from(
            response.data["data"].map((x) => NearbyStores.fromJson(x)));
      }
    }
    return [];
  }

  Future<List<PopularSearch>> getPopularSearches() async {
    final Response response = await _dio.get(
      '/Product/get-popular-search',
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================POPULAR SEARCHES');
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return List<PopularSearch>.from(
            response.data["data"].map((x) => PopularSearch.fromJson(x)));
      }
    }
    return [];
  }

  Future<List<Product>> getProducts({
    String? sid,
    String search = '',
    num? minPrice,
    num? maxPrice,
    String? filterBy,
  }) async {
    // // print('send request : getProducts');
    Map<String, dynamic> queryParameters = {
      'sid': sid,
      'filter':
          "Name~contains~'$search'~and~${filterBy ?? 'price'}~gte~${minPrice ?? 0}~and~${filterBy ?? 'price'}~lte~${maxPrice ?? 500}",
    };
    // // print(queryParameters);
    final Response response = await _dio.get(
      '/Product/read-product/',
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================PRODUCT');
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return List<Product>.from(
            response.data["data"].map((x) => Product.fromJson(x)));
      }
    }
    return [];
  }

  Future<List<Product>> getProductsCategory({
    String? cid,
    String search = '',
    num? minPrice,
    num? maxPrice,
    String? filterBy,
  }) async {
    // // print('send request : getProducts');
    Map<String, dynamic> queryParameters = {
      'cid': cid,
      'filter':
          "Name~contains~'$search'~and~${filterBy ?? 'price'}~gte~${minPrice ?? 0}~and~${filterBy ?? 'price'}~lte~${maxPrice ?? 500}",
    };
    // // print(queryParameters);
    final Response response = await _dio.get(
      'Product/read-product',
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    // // print('============================================PRODUCT');
    // // print(response.statusCode);
    // // print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return List<Product>.from(
            response.data["data"].map((x) => Product.fromJson(x)));
      }
    }
    return [];
  }

  // get offers.
  Future<List<Product>> getOffers({
    String? sid,
    String? bid,
    String? cid,
  }) async {
    // print('send request : read-discount');
    Map<String, dynamic> queryParameters = {'sid': sid, 'bid': bid, 'cid': cid};
    final Response response = await _dio.get(
      '/Product/read-offers',
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return List<Product>.from(
            response.data["data"].map((x) => Product.fromJson(x)));
      }
    }
    return [];
  }

  Future<ApiResponse> toggleFavorite({
    required String productId,
  }) async {
    Uri uri = Uri.parse(
        '${Constants.baseUrl}/Product/add-remove-to-favorite?id=$productId');
    var response = await http.post(
      uri,
      headers: headers,
    );
    // print('111');
    // print('============================================');
    // print(productId);
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      // print('222');
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        return ApiResponse(
          message: jsonResponse['message'],
          status: jsonResponse['status'],
        );
      }
    }
    return failedResponse;
  }

  Future<List<Product>> getMyFavorite() async {
    Uri uri = Uri.parse('${Constants.baseUrl}/Product/get-my-favorite');
    var response = await http.get(
      uri,
      headers: headers,
    );
    // print('111');
    // print('============================================');
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      // print('222');
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        var jsonArray = jsonResponse['data'] as List;
        return jsonArray
            .map((jsonObject) => Product.fromJson(jsonObject))
            .toList();
      }
    }
    return [];
  }

  Future<ApiResponse> toggleAddToCart({
    required String productId,
  }) async {
    // print('send request : add-remove-to-basket');
    Map<String, dynamic> queryParameters = {
      'id': productId,
    };
    // print(queryParameters);
    var response = await _dio.post(
      '/Product/add-remove-to-basket',
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return ApiResponse(
          message: response.data['message'],
          status: response.data['status'],
        );
      }
    }
    return failedResponse;
  }

  Future<ApiResponse> emptyBasket(BuildContext context) async {
    // print('send request : add-remove-to-basket');
    // Map<String, dynamic> queryParameters = {
    //   'id': productId,
    // };
    // print(queryParameters);
    var response = await _dio.post(
      '/Product/empty-basket',
      // queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        showSnackBar(context, message: response.data['message']);
        return ApiResponse(
          message: response.data['message'],
          status: response.data['status'],
        );
      }
    }
    return failedResponse;
  }

  Future<List<CartItem>> getMyCart() async {
    // print('send request : get-my-basket');
    var response = await _dio.get(
      '/Product/get-my-basket',
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return List<CartItem>.from(
            response.data["data"].map((x) => CartItem.fromJson(x)));
      }
    }
    return [];
  }

  // change cart item count.
  Future<ApiResponse> changeCartItemCount({
    required String cartItemId,
    required num count,
  }) async {
    var url = Uri.parse(
        '${Constants.baseUrl}/Product/change-basket-item-count?id=$cartItemId&count=$count');
    // print('send request : add-remove-to-basket');
    Map<String, dynamic> queryParameters = {
      'id': '03aa23d5-8f38-4628-f8ee-08db21ee7c75',
      'count': 2,
    };
    // print(queryParameters);
    // var response = await _dio.post(
    //   '/Product/change-basket-item-count',
    //   queryParameters: queryParameters,
    //   options: Options(
    //     headers: headers,
    //   ),
    // );
    var response = await http.post(
      url,
      headers: headers,
    );
    // print('============================================');
    // print(response.statusCode);
    // print(response.body);
    var jsondata = jsonDecode(response.body);
    // print('============================================');
    // print(response.statusCode);
    print(jsondata['data']);
    if (response.statusCode == 200) {
      if (jsondata['status'] == 200) {
        return ApiResponse(
          message: jsondata['message'],
          status: jsondata['status'],
        );
      }
    }
    return failedResponse;
  }

  Future<List<Branch>> getStoreByCategoriy(
      {String? cid,
      String? filterType = '',
      String? filterContent = '',
      String? sortType = ''}) async {
    Map<String, String> queries = {
      filterType== '' ? '' : 'filter': "$filterType~contains~\'$filterContent\'",
      'cid': '$cid',
      'sort': '$sortType-desc'
    };
    var query = Uri(queryParameters: queries).query;
    var url = Uri.parse('${Constants.baseUrl}/Store/read-branch?$query');
    var response = await http.get(url,headers: headers);

    print('=======================store');
    print('${Constants.baseUrl}/Store/read-store?$query');
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 200) {
        return List<Branch>.from(jsonData['data'].map((x) => Branch.fromJson(x)));
      }
    }
    return [];
  }

  Future<Branch?> getBranchById({required String branchId}) async{
    var url = Uri.parse('${Constants.baseUrl}/Store/get-branch-byId?id=$branchId');
    var response = await http.get(url,headers: headers);

    if(response.statusCode == 200 ) {
      var jsonData = jsonDecode(response.body);
      if(jsonData['status'] == 200) {
        return Branch.fromJson(jsonData['data']);
      }
    }
    return null;
  }
}
