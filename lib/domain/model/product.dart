import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/branch.dart';
import 'package:ghaf_application/domain/model/category.dart';
import 'package:ghaf_application/domain/model/ghaf_image.dart';
import 'package:ghaf_application/domain/model/offer.dart';
import 'package:ghaf_application/domain/model/product_discount.dart';

import '../../presentation/screens/home_view/home_view_getx_controller.dart';

class Product extends GetxController with Helpers {

  // var isFavorite1 = true;
  HomeViewGetXController _homeViewGetXController =
  Get.put<HomeViewGetXController>(HomeViewGetXController());

  // notifiable.
  void toggleIsFavorite({
    required String id,
    // required bool isFavorite,
    required BuildContext context,
    bool sendRequest = true,
  }) {

    if (sendRequest) _toggleFavoriteRequest(context: context,id: id);

     _homeViewGetXController.getProducts();
    //
    // isFavorite = !isFavorite!;

    update(['isFavorite']);

  }

  void init () {
    // _homeViewGetXController.getProducts();
  }

  // notifiable.
  void toggleIsAddToCart({
    required BuildContext context,
    bool sendRequest = true,
  }) {
    isInCart = !isInCart!;
    update(['isInCart']);
    if (sendRequest) _toggleAddToCartRequest(context: context);
  }

  // vars.
  late final StoreApiController _storeApiController = StoreApiController();

  Product(
      {this.id,
      this.name,
      this.description,
      this.characteristics,
      this.productType,
      this.price,
      this.isoCurrencySymbol,
      this.quantity,
      this.visible,
      this.deleted,
      this.approved,
      this.addedAt,
      this.ghafImage,
      this.productReview,
      this.productDiscount,
      this.offer,
      this.redeemPoints,
      this.branch,
      this.timeToPrepareMinutes,
      this.offerDescription,
      this.discountDescription,
      this.redeemDescription,
      this.subscriptionHide,
      this.onlyOnGhaf,
      this.discountValueForAllUsers,
      this.discountValueForGoldenUsers,
      this.stars,
      this.productImages,
      this.isFavorite,
      this.isInCart,
      this.category,
      this.storeStars});

  String? id;
  String? name;
  String? description;
  String? characteristics;
  String? productType;
  num? price;
  bool? subscriptionHide;

  String? isoCurrencySymbol;
  int? quantity;
  bool? visible;
  bool? deleted;
  bool? onlyOnGhaf;

  bool? approved;
  DateTime? addedAt;
  List<GhafImage>? ghafImage;
  String? productReview;
  ProductDiscount? productDiscount;
  Offer? offer;
  ProductDiscount? redeemPoints;
  String? timeToPrepareMinutes;
  Branch? branch;
  String? offerDescription;
  String? discountValueForAllUsers;
  String? discountValueForGoldenUsers;
  String? discountDescription;
  String? redeemDescription;
  num? stars;
  List<dynamic>? productImages;

  bool? isFavorite;
  bool? isInCart;
  Category? category;
  int? storeStars;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        characteristics: json["characteristics"],
        productType: json["productType"],
        price: json["price"],
        isoCurrencySymbol: json["isoCurrencySymbol"],
        quantity: json["quantity"],
        visible: json["visible"],
        subscriptionHide: json["subscriptionHide"],
        deleted: json["deleted"],
        productImages: json["productImages"],
        discountValueForAllUsers: json["discountValueForAllUsers"],
        discountValueForGoldenUsers: json["discountValueForGoldenUsers"],
        approved: json["approved"],
        addedAt: DateTime.parse(json["addedAt"]),
        ghafImage: json["ghafImage"] == null
            ? []
            : List<GhafImage>.from(
                json["ghafImage"].map((x) => GhafImage.fromJson(x))),
        productReview: json["productReview"],
        productDiscount: json["productDiscount"] == null
            ? null
            : ProductDiscount.fromJson(json["productDiscount"]),
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        redeemPoints: json["redeemPoints"] == null
            ? null
            : ProductDiscount.fromJson(json["redeemPoints"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        offerDescription: json["offerDescription"],
        discountDescription: json["discountDescription"],
        redeemDescription: json["redeemDescription"],
        stars: json["stars"],
        isFavorite: json["isFavourite"] ?? false,
        isInCart: json["isInCart"] ?? false,
        timeToPrepareMinutes: json["timeToPrepareMinutes"],
        onlyOnGhaf: json["onlyOnGhaf"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        storeStars: json["storeStars"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "characteristics": characteristics,
        "productType": productType,
        "price": price,
        "isoCurrencySymbol": isoCurrencySymbol,
        "quantity": quantity,
        "visible": visible,
        "deleted": deleted,
        "approved": approved,
        "addedAt": addedAt?.toIso8601String(),
        "ghafImage": List<dynamic>.from(ghafImage!.map((x) => x.toJson())),
        "productReview": productReview,
        "productDiscount": productDiscount?.toJson(),
        "offer": offer,
        "redeemPoints": redeemPoints?.toJson(),
        "branch": branch?.toJson(),
        "offerDescription": offerDescription,
        "discountDescription": discountDescription,
        "redeemDescription": redeemDescription,
        "stars": stars,
        "isFavourite": isFavorite,
        "isInCart": isInCart,
        "category": category?.toJson(),
      };

  // toggle favorite request.
  void _toggleFavoriteRequest({
    required String id,
    required BuildContext context,
  }) async {
    try {
      final ApiResponse apiResponse =
          await _storeApiController.toggleFavorite(productId: id);
      if (apiResponse.status == 200) {
        // success.
        showSnackBar(context, message: apiResponse.message, error: false);
      } else {
        // failed.
        showSnackBar(context, message: apiResponse.message, error: true);
        toggleIsFavorite(context: context, sendRequest: false,id: id);
      }
    } catch (error) {
      // error.
      showSnackBar(context, message: error.toString(), error: true);
      toggleIsFavorite(context: context, sendRequest: false,id: id);
    }
  }

  // toggle add to cart request.
  void _toggleAddToCartRequest({
    required BuildContext context,
  }) async {
    try {
      final ApiResponse apiResponse =
          await _storeApiController.toggleAddToCart(productId: id!);
      if (apiResponse.status == 200) {
        // success.
        showSnackBar(context, message: apiResponse.message, error: false);
      } else {
        // failed.
        showSnackBar(context, message: apiResponse.message, error: true);
        toggleIsAddToCart(context: context, sendRequest: false);
      }
    } catch (error) {
      // error.
      showSnackBar(context, message: error.toString(), error: true);
      toggleIsAddToCart(context: context, sendRequest: false);
    }
  }
}
