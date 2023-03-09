import 'package:ghaf_application/domain/model/address.dart';

class NearbyStores {
  String? id;
  String? branchName;
  Address? branchAddress;
  String? branchLogo;
  String? telephone;
  String? whatsApp;
  String? email;
  String? details;
  String? branchNumber;
  bool? is24Hours;
  num? minOrder;
  bool? hidden;
  String? storeId;
  String? branchTimes;
  String? storeName;
  String? storeDeliveryCost;
  String? branchLogoImage;

  NearbyStores({
    this.id,
    this.telephone,
    this.email,
    this.details,
    this.branchAddress,
    this.branchLogo,
    this.branchLogoImage,
    this.branchName,
    this.branchNumber,
    this.branchTimes,
    this.hidden,
    this.is24Hours,
    this.minOrder,
    this.storeDeliveryCost,
    this.storeId,
    this.storeName,
    this.whatsApp,
  });

  factory NearbyStores.fromJson(Map<String, dynamic> json) => NearbyStores(
        details: json['details'],
        id: json['id'],
        branchAddress: Address.fromJson(json['branchAddress']),
        branchLogo: json['branchLogo'],
        branchLogoImage: json['branchLogoImage'],
        branchName: json['branchName'],
        branchNumber: json['branchNumber'],
        branchTimes: json['branchTimes'],
        email: json['email'],
        hidden: json['hidden'],
        is24Hours: json['is24Hours'],
        minOrder: json['minOrder'],
        storeDeliveryCost: json['storeDeliveryCost'],
        storeId: json['storeId'],
        storeName: json['storeName'],
        telephone: json['telephone'],
        whatsApp: json['whatsApp'],
      );

  Map<String, dynamic> toJson() => {
        "details": details,
        "id": id,
        "branchAddress": branchAddress!.toJson(),
        "branchLogo": branchLogo,
        "branchLogoImage": branchLogoImage,
        "branchName": branchName,
        "branchNumber": branchNumber,
        "branchTimes": branchTimes,
        "email": email,
        "hidden": hidden,
        "is24Hours": is24Hours,
        "minOrder": minOrder,
        "storeDeliveryCost": storeDeliveryCost,
        "storeId": storeId,
        "storeName": storeName,
        "telephone": telephone,
        "whatsApp": whatsApp,
      };
}
