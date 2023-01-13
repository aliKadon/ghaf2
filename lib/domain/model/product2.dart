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
  num? price;
  String? isoCurrencySymbol;
  int? quantity;
  bool? visible;
  bool? deleted;
  bool? approved;
  bool?canPayLater;
  int?canPayLaterDays;
  String? addedAt;
  List<dynamic>? ghafImage;
  String? productReview;
  Map<String,dynamic>? productDiscount;
  Map<String,dynamic>? offer;
  Map<String,dynamic>? redeemPoints;
  Map<String,dynamic>? branch;
  String? offerDescription;
  String? discountDescription;
  String? redeemDescription;
  num? stars;
  bool? isFavorite;
  bool? isInCart;
  Map<String,dynamic>? category;

  Product2({
    this.id,
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
    this.canPayLater,
    this.canPayLaterDays,
    this.addedAt,
    this.ghafImage,
    this.productReview,
    this.productDiscount,
    this.offer,
    this.redeemPoints,
    this.branch,
    this.offerDescription,
    this.discountDescription,
    this.redeemDescription,
    this.stars,
    this.isFavorite,
    this.isInCart,
    this.category,
  });
}