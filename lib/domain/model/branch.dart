import 'package:ghaf_application/domain/model/address.dart';
import 'package:ghaf_application/domain/model/store_delivery_cost.dart';

import 'meal_times.dart';

class Branch {
  Branch({
    this.id,
    this.branchName,
    this.branchAddress,
    this.telephone,
    this.email,
    this.details,
    this.branchNumber,
    this.is24Hours,
    this.hidden,
    this.storeId,
    this.branchTimes,
    this.storeName,
    this.storeDeliveryCost,
    this.branchLogoImage,
    this.whatsApp,
    this.minOrder,
    this.branchLogo,
    this.deleted,
    this.isOpen,
    this.todayWorkHoursToString,
    this.storeStars,
    this.reviewCount,
    this.isItRestaurant,
    this.mealTimes,
    this.storeLogoImage,
    this.storeCoverImage,
  });

  String? id;
  String? branchName;
  Address? branchAddress;
  String? telephone;
  String? email;
  String? whatsApp;
  String? branchLogo;
  num? minOrder;
  String? details;
  dynamic deleted;
  String? branchLogoImage;
  String? branchNumber;
  String? storeLogoImage;
  bool? is24Hours;
  bool? hidden;
  String? storeId;
  List<dynamic>? branchTimes;
  String? storeName;
  List<StoreDeliveryCost>? storeDeliveryCost;
  bool? isOpen;
  String? todayWorkHoursToString;
  num? storeStars;
  num? reviewCount;
  bool? isItRestaurant;
  String? storeCoverImage;
  List<MealTimes>? mealTimes;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        branchName: json["branchName"],
        branchAddress: json["branchAddress"] == null
            ? null
            : Address.fromJson(json["branchAddress"]),
        telephone: json["telephone"],
        email: json["email"],
        storeCoverImage: json["storeCoverImage"],
        details: json["details"],
        branchNumber: json["branchNumber"],
        is24Hours: json["is24Hours"],
        hidden: json["hidden"],
        storeId: json["storeId"],
        branchTimes: json["branchTimes"],
        storeName: json["storeName"],
        whatsApp: json["whatsApp"],
        storeDeliveryCost: json["storeDeliveryCost"] == null
            ? null
            : List<StoreDeliveryCost>.from(json["storeDeliveryCost"]
                .map((x) => StoreDeliveryCost.fromJson(x))),

        // json["storeDeliveryCost"] == null
        //     ? null
        //     : List<StoreDeliveryCost>.from(json["storeDeliveryCost"].map((x) {
        //         StoreDeliveryCost.fromJson(x);
        //       })),
        minOrder: json["minOrder"],
        branchLogoImage: json["branchLogoImage"],
        branchLogo: json["branchLogo"],
        deleted: json["deleted"],
        isOpen: json["isOpen"],
        storeLogoImage: json["storeLogoImage"],
        todayWorkHoursToString: json["todayWorkHoursToString"],
        storeStars: json['storeStars'],
        reviewCount: json['reviewCount'],
        isItRestaurant: json['isItRestaurant'],
        mealTimes: json['mealTimes'] == null
            ? []
            : List<MealTimes>.from(
                json['mealTimes'].map((x) => MealTimes.fromJson(x))),

        // storeDeliveryCost: List<StoreDeliveryCost>.from(
        //     json["storeDeliveryCost"].map((x) => StoreDeliveryCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branchName": branchName,
        "branchAddress": branchAddress,
        "telephone": telephone,
        "email": email,
        "details": details,
        "storeCoverImage": storeCoverImage,
        "branchNumber": branchNumber,
        "is24Hours": is24Hours,
        "hidden": hidden,
        "storeId": storeId,
        "branchTimes": branchTimes,
        "storeName": storeName,
        "whatsApp": whatsApp,
        "storeDeliveryCost": storeDeliveryCost,
        "minOrder": minOrder,
        "branchLogoImage": branchLogoImage,
        "branchLogo": branchLogo,
        "deleted": deleted,
        "todayWorkHoursToString": todayWorkHoursToString,
        "isOpen": isOpen,
        "storeStars": storeStars,
        "reviewCount": reviewCount,
        'isItRestaurant': isItRestaurant,
        'mealTimes': mealTimes,
        'storeLogoImage': storeLogoImage,

        // "storeDeliveryCost": List<dynamic>.from(storeDeliveryCost!.map((x) => x.toJson()))
      };
}
