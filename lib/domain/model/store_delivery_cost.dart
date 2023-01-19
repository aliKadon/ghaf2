class StoreDeliveryCost {
  String id;
  String storeId;
  String deliveryMethodId;
  String isoCurrencySymbol;
  String cost;
  String methodName;
  String methodImage;

  StoreDeliveryCost(
      {required this.id,
      required this.storeId,
      required this.deliveryMethodId,
      required this.isoCurrencySymbol,
      required this.cost,
      required this.methodName,
      required this.methodImage});


  factory StoreDeliveryCost.fromJson(Map<String, dynamic> json) => StoreDeliveryCost(
    id: json["id"],
    storeId: json["storeId"],
    deliveryMethodId: json["deliveryMethodId"],
    isoCurrencySymbol: json["isoCurrencySymbol"],
    cost: json["cost"],
    methodName: json["methodName"],
    methodImage: json["methodImage"]
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "storeId": storeId,
    "deliveryMethodId": deliveryMethodId,
    "isoCurrencySymbol": isoCurrencySymbol,
    "cost": cost,
    "methodName": methodName,
    "methodImage": methodImage,
  };
}
