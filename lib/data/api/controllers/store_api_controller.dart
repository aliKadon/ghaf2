import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/cart_item.dart';
import 'package:ghaf_application/domain/model/category.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:http/http.dart' as http;

import '../api_helper.dart';
import '../api_settings.dart';

class StoreApiController with ApiHelper {
  late final Dio _dio = Dio(BaseOptions(baseUrl: ApiSettings.baseUrl));

  Future<List<Category>> getCategories() async {
    Uri uri = Uri.parse(ApiSettings.category);
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

  Future<List<Product>> getProducts({
    String? cid,
    String search = '',
    num? minPrice,
    num? maxPrice,
    String? filterBy,
  }) async {
    // // print('send request : getProducts');
    Map<String, dynamic> queryParameters = {
      'sid': cid,
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
  Future<List<Product>> getOffers() async {
    // print('send request : read-discount');
    final Response response = await _dio.get(
      'GiftAndReward/read-discount',
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
            response.data["data"].map((x) => Product.fromJson(x['products'])));
      }
    }
    return [];
  }

  Future<ApiResponse> toggleFavorite({
    required String productId,
  }) async {
    Uri uri = Uri.parse('${ApiSettings.addOrRemoveFromFavorite}?id=$productId');
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
    Uri uri = Uri.parse('${ApiSettings.getMyFavorite}');
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
      'Product/add-remove-to-basket',
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

  Future<List<CartItem>> getMyCart() async {
    // print('send request : get-my-basket');
    var response = await _dio.get(
      'Product/get-my-basket',
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
    required int count,
  }) async {
    // print('send request : add-remove-to-basket');
    Map<String, dynamic> queryParameters = {
      'id': cartItemId,
      'count': count,
    };
    // print(queryParameters);
    var response = await _dio.post(
      'Product/change-basket-item-count',
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    // print('============================================');
    // // print(response.statusCode);
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
}
