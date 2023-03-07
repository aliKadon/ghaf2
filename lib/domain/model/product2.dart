import 'package:ghaf_application/domain/model/product_discount.dart';

import 'branch.dart';
import 'ghaf_image.dart';
import 'offer.dart';

class Product2 {
  String? id;
  String? name;
  String? description;
  String? characteristics;
  String? productType;
  String? timeToPrepareMinutes;
  num? price;
  String? isoCurrencySymbol;
  int? quantity;
  bool? visible;
  bool? subscriptionHide;
  bool? deleted;
  bool? approved;
  bool? onlyOnGhaf;
  bool?canPayLater;
  int?canPayLaterDays;
  String? addedAt;
  List<dynamic>? productImages;
  List<dynamic>? ghafImage;
  String? productReview;
  Map<String,dynamic>? productDiscount;
  Map<String,dynamic>? offer;
  Map<String,dynamic>? redeemPoints;
  Map<String,dynamic>? branch;
  String? offerDescription;
  String? discountDescription;
  String? discountValueForAllUsers;
  String? discountValueForGoldenUsers;
  String? redeemDescription;
  num? stars;
  num? reviewCount;
  bool? isFavorite;
  bool? isInCart;
  Map<String,dynamic>? category;
  int? storeStars;
  int? storeReviewCount;

  Product2({
    this.id,
    this.name,
    this.description,
    this.characteristics,
    this.productType,
    this.timeToPrepareMinutes,
    this.price,
    this.isoCurrencySymbol,
    this.quantity,
    this.visible,
    this.subscriptionHide,
    this.deleted,
    this.approved,
    this.onlyOnGhaf,
    this.canPayLater,
    this.canPayLaterDays,
    this.productImages,
    this.addedAt,
    this.ghafImage,
    this.discountValueForAllUsers,
    this.discountValueForGoldenUsers,
    this.productReview,
    this.productDiscount,
    this.offer,
    this.redeemPoints,
    this.branch,
    this.offerDescription,
    this.discountDescription,
    this.redeemDescription,
    this.stars,
    this.reviewCount,
    this.isFavorite,
    this.isInCart,
    this.category,
    this.storeStars,
    this.storeReviewCount,
  });
}