import 'package:ghaf_application/domain/model/product.dart';

class ItemsToReturn {
  String? productId;
  String? orderId;
  Product? product;

  ItemsToReturn({
    this.orderId,
    this.productId,
    this.product,
  });

  factory ItemsToReturn.fromJson(Map<String,dynamic> json) => ItemsToReturn(
    product: Product.fromJson(json['product']),
    productId: json['productId'],
    orderId: json['orderId'],
  );

  Map<String,dynamic> toJson() => {
    'product' : product,
    'productId' : productId,
    'orderId' : orderId,
  };
}
