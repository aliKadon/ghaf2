import 'package:ghaf_application/domain/model/branch.dart';
import 'package:ghaf_application/domain/model/category.dart';

class Store {
  String? id;
  String? isoCurrencySymbol;
  String? storeName;
  Category? category;
  String? ownerId;
  bool? hidden;
  String? storeLogo;
  bool? subscriptionExpired;
  bool? isDeleted;
  List<Branch>? branches;
  String? addedAt;
  num? stars;
  num? reviewCount;
  String? storeLogoImage;
  num? storeSales;
  num? storeStars;

  Store({
    this.storeName,
    this.storeLogo,
    this.id,
    this.isoCurrencySymbol,
    this.stars,
    this.hidden,
    this.isDeleted,
    this.addedAt,
    this.branches,
    this.category,
    this.ownerId,
    this.reviewCount,
    this.storeLogoImage,
    this.storeSales,
    this.subscriptionExpired,
    this.storeStars,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        storeLogo: json['storeLogo'],
        id: json['id'],
        storeName: json['storeName'],
        isoCurrencySymbol: json['isoCurrencySymbol'],
        hidden: json['hidden'],
        isDeleted: json['isDeleted'],
        stars: json['stars'],
        addedAt: json['addedAt'],
        branches:
            List<Branch>.from(json['branches'].map((x) => Branch.fromJson(x))),
        category: Category.fromJson(json['category']),
        ownerId: json['ownerId'],
        reviewCount: json['reviewCount'],
        storeLogoImage: json['storeLogoImage'],
        storeSales: json['storeSales'],
        subscriptionExpired: json['subscriptionExpired'],
        storeStars: json['storeStars'],
      );

  Map<String, dynamic> toJson() => {
        'storeLogo': storeLogo,
        'id': id,
        'storeName': storeName,
        'isoCurrencySymbol': isoCurrencySymbol,
        'hidden': hidden,
        'isDeleted': isDeleted,
        'stars': stars,
        'addedAt': addedAt,
        'branches': branches,
        'category': category,
        'ownerId': ownerId,
        'reviewCount': reviewCount,
        'storeLogoImage': storeLogoImage,
        'storeSales': storeSales,
        'subscriptionExpired': subscriptionExpired,
        'storeStars': storeStars,
      };
}
