class DeliveryMethod {
  DeliveryMethod({
    this.id,
    this.storeId,
    this.deliveryMethodId,
    this.isoCurrencySymbol,
    this.cost,
    this.methodName,
  });

  String? id;
  String? storeId;
  String? deliveryMethodId;
  String? isoCurrencySymbol;
  int? cost;
  String? methodName;

  factory DeliveryMethod.fromJson(Map<String, dynamic> json) => DeliveryMethod(
        id: json["id"],
        storeId: json["storeId"],
        deliveryMethodId: json["deliveryMethodId"],
        isoCurrencySymbol: json["isoCurrencySymbol"],
        cost: json["cost"],
        methodName: json["methodName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "storeId": storeId,
        "deliveryMethodId": deliveryMethodId,
        "isoCurrencySymbol": isoCurrencySymbol,
        "cost": cost,
        "methodName": methodName,
      };
}
