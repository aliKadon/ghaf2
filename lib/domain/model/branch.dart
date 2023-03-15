import 'package:ghaf_application/domain/model/address.dart';
import 'package:ghaf_application/domain/model/store_delivery_cost.dart';

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
  bool? is24Hours;
  bool? hidden;
  String? storeId;
  List<dynamic>? branchTimes;
  String? storeName;
  List<dynamic>? storeDeliveryCost;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        branchName: json["branchName"],
        branchAddress: json["branchAddress"] == null
            ? null
            : Address.fromJson(json["branchAddress"]),
        telephone: json["telephone"],
        email: json["email"],
        details: json["details"],
        branchNumber: json["branchNumber"],
        is24Hours: json["is24Hours"],
        hidden: json["hidden"],
        storeId: json["storeId"],
        branchTimes: json["branchTimes"],
        storeName: json["storeName"],
        whatsApp: json["whatsApp"],
        storeDeliveryCost: json["storeDeliveryCost"],

        // json["storeDeliveryCost"] == null
        //     ? null
        //     : List<StoreDeliveryCost>.from(json["storeDeliveryCost"].map((x) {
        //         StoreDeliveryCost.fromJson(x);
        //       })),
        minOrder: json["minOrder"],
        branchLogoImage: json["branchLogoImage"],
        branchLogo: json["branchLogo"],
        deleted: json["deleted"],
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

        // "storeDeliveryCost": List<dynamic>.from(storeDeliveryCost!.map((x) => x.toJson()))
      };
}
