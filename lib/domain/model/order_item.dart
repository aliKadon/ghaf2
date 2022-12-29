class OrderItem {
  OrderItem({
    this.id,
    this.name,
    this.price,
    this.quanity,
    this.isoCurrencySymbol,
    this.cOrderId,
    this.storeId,
    this.productId,
  });

  String? id;
  String? name;
  num? price;
  int? quanity;
  String? isoCurrencySymbol;
  String? cOrderId;
  String? storeId;
  String? productId;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        quanity: json["quanity"],
        isoCurrencySymbol: json["isoCurrencySymbol"],
        cOrderId: json["cOrderId"],
        storeId: json["storeId"],
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quanity": quanity,
        "isoCurrencySymbol": isoCurrencySymbol,
        "cOrderId": cOrderId,
        "storeId": storeId,
        "productId": productId,
      };
}
