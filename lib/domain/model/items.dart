class Items {
  String? id;
  String? name;
  num? price;
  num? quanity;
  String? isoCurrencySymbol;
  String? cOrderId;
  String? storeId;
  String? productId;
  bool? paid;

  Items({
    this.isoCurrencySymbol,
    this.id,
    this.name,
    this.price,
    this.storeId,
    this.productId,
    this.cOrderId,
    this.paid,
    this.quanity,
  });

  factory Items.fromJson(Map<String,dynamic> json) => Items(
      id: json['id'],
      isoCurrencySymbol: json['isoCurrencySymbol'],
      name: json['name'],
      storeId: json['storeId'],
      productId: json['productId'],
      price: json['price'],
      paid: json['paid'],
      cOrderId: json['cOrderId'],
      quanity: json['quanity'],
    );


  Map<String,dynamic> toJson() => {
    'id' : id,
    'isoCurrencySymbol' : isoCurrencySymbol,
    'name' : name,
    'storeId' : storeId,
    'productId' : productId,
    'price' : price,
    'paid' : paid,
    'cOrderId' : cOrderId,
    'quanity' : quanity,
  };
}
