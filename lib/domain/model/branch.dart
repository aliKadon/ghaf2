import 'package:ghaf_application/domain/model/store_delivery_cost.dart';

class Branch {
  Branch(
      {this.id,
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
      this.storeDeliveryCost});

  String? id;
  String? branchName;
  String? branchAddress;
  String? telephone;
  String? email;
  String? details;
  String? branchNumber;
  bool? is24Hours;
  bool? hidden;
  String? storeId;
  String? branchTimes;
  String? storeName;
  List<StoreDeliveryCost>? storeDeliveryCost;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        branchName: json["branchName"],
        branchAddress: json["branchAddress"],
        telephone: json["telephone"],
        email: json["email"],
        details: json["details"],
        branchNumber: json["branchNumber"],
        is24Hours: json["is24Hours"],
        hidden: json["hidden"],
        storeId: json["storeId"],
        branchTimes: json["branchTimes"],
        storeName: json["storeName"],
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
        // "storeDeliveryCost": List<dynamic>.from(storeDeliveryCost!.map((x) => x.toJson()))
      };
}
