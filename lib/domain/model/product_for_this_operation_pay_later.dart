import 'package:ghaf_application/domain/model/product_type.dart';

class ProductForThisOperationPayLater {
  String? id;
  String? name;
  String? description;
  String? characteristics;
  ProductType? productType;
  num? timeToPrepareMinutes;
  num? price;
  String? isoCurrencySymbol;
  num? quantity;
  bool? visible;
  bool? subscriptionHide;
  bool? deleted;
  bool? approved;
  bool? onlyOnGhaf;
  String? addedAt;
  List<dynamic>? ghafImage;
  List<dynamic>? productImages;
  bool? canPayLater;
  dynamic producstInstallments;
  dynamic branch;
  dynamic offerDescription;
  dynamic discountDescription;
  dynamic discountValueForAllUsers;
  dynamic discountValueForGoldenUsers;
  dynamic redeemDescription;
  num? stars;
  num? reviewCount;
  bool? isFavourite;
  bool? isInCart;
  dynamic category;
  num? storeStars;
  num? storeReviewCount;
  String? nameAr;

  ProductForThisOperationPayLater({
    this.stars,
    this.id,
    this.name,
    this.price,
    this.isoCurrencySymbol,
    this.branch,
    this.addedAt,
    this.productType,
    this.productImages,
    this.discountValueForGoldenUsers,
    this.discountValueForAllUsers,
    this.reviewCount,
    this.storeStars,
    this.category,
    this.discountDescription,
    this.description,
    this.onlyOnGhaf,
    this.subscriptionHide,
    this.timeToPrepareMinutes,
    this.approved,
    this.canPayLater,
    this.characteristics,
    this.deleted,
    this.ghafImage,
    this.isFavourite,
    this.isInCart,
    this.nameAr,
    this.offerDescription,
    this.producstInstallments,
    this.quantity,
    this.redeemDescription,
    this.storeReviewCount,
    this.visible,
  });

  factory ProductForThisOperationPayLater.FromJson(Map<String, dynamic> json) =>
      ProductForThisOperationPayLater(
        stars: json['stars'],
        id: json['id'],
        characteristics: json['characteristics'],
        description: json['description'],
        name: json['name'],
        isoCurrencySymbol: json['isoCurrencySymbol'],
        price: json['price'],
        productType: ProductType.fromJson(json['productType']),
        addedAt: json['addedAt'],
        branch: json['branch'],
        reviewCount: json['reviewCount'],
        storeStars: json['storeStars'],
        category: json['category'],
        deleted: json['deleted'],
        discountDescription: json['discountDescription'],
        productImages: json['productImages'],
        approved: json['approved'],
        canPayLater: json['canPayLater'],
        discountValueForAllUsers: json['discountValueForAllUsers'],
        discountValueForGoldenUsers: json['discountValueForGoldenUsers'],
        ghafImage: json['ghafImage'],
        isFavourite: json['isFavourite'],
        isInCart: json['isInCart'],
        nameAr: json['nameAr'],
        offerDescription: json['offerDescription'],
        onlyOnGhaf: json['onlyOnGhaf'],
        producstInstallments: json['producstInstallments'],
        quantity: json['quantity'],
        redeemDescription: json['redeemDescription'],
        storeReviewCount: json['storeReviewCount'],
        subscriptionHide: json['subscriptionHide'],
        timeToPrepareMinutes: json['timeToPrepareMinutes'],
        visible: json['visible'],
      );

  Map<String,dynamic> toJson() => {
    'stars' : stars,
    'id' : id,
    'characteristics' : characteristics,
    'description' : description,
    'name' : name,
    'isoCurrencySymbol' : isoCurrencySymbol,
    'price' : price,
    'productType' : productType,
    'addedAt' : addedAt,
    'branch' : branch,
    'reviewCount' : reviewCount,
    'storeStars' : storeStars,
    'category' : category,
    'deleted' : deleted,
    'discountDescription' : discountDescription,
    'productImages' : productImages,
    'approved' : approved,
    'canPayLater' : canPayLater,
    'discountValueForAllUsers' : discountValueForAllUsers,
    'discountValueForGoldenUsers' : discountValueForGoldenUsers,
    'ghafImage' : ghafImage,
    'isFavourite' : isFavourite,
    'isInCart' : isInCart,
    'nameAr' : nameAr,
    'offerDescription' : offerDescription,
    'onlyOnGhaf' : onlyOnGhaf,
    'producstInstallments' : producstInstallments,
    'quantity' : quantity,
    'redeemDescription' :redeemDescription,
    'storeReviewCount' : storeReviewCount,
    'subscriptionHide' : subscriptionHide,
    'timeToPrepareMinutes' : timeToPrepareMinutes,
    'visible' : visible,
  };
}
