class StoreDeliveryCost {
  String? id;
  String? branchId;
  String? deliveryMethodId;
  String? isoCurrencySymbol;
  int? cost;
  String? methodName;
  String? methodImage;

  StoreDeliveryCost(
      {this.id,
      this.branchId,
      this.deliveryMethodId,
      this.isoCurrencySymbol,
      this.cost,
      this.methodName,
      this.methodImage});

  factory StoreDeliveryCost.fromJson(Map<String, dynamic> json) =>
      StoreDeliveryCost(
          id: json["id"],
          branchId: json["branchId"],
          deliveryMethodId: json["deliveryMethodId"],
          isoCurrencySymbol: json["isoCurrencySymbol"],
          cost: json["cost"],
          methodName: json["methodName"],
          methodImage: json["methodImage"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "branchId": branchId,
        "deliveryMethodId": deliveryMethodId,
        "isoCurrencySymbol": isoCurrencySymbol,
        "cost": cost,
        "methodName": methodName,
        "methodImage": methodImage,
      };
}
