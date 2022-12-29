import 'package:ghaf_application/domain/model/product.dart';

class Gift {
  Gift({
    this.id,
    this.name,
    this.products,
    this.minProductCount,
    this.gift,
    this.giftCount,
    this.startDate,
    this.expireDate,
    this.isExclusive,
    this.giftCode,
  });

  String? id;
  String? name;
  Product? products;
  int? minProductCount;
  Product? gift;
  int? giftCount;
  DateTime? startDate;
  DateTime? expireDate;
  bool? isExclusive;
  String? giftCode;

  factory Gift.fromJson(Map<String, dynamic> json) => Gift(
        id: json["id"],
        name: json["name"],
        products: json["products"] == null
            ? null
            : Product.fromJson(json["products"]),
        minProductCount: json["minProductCount"],
        gift: json["gift"] == null ? null : Product.fromJson(json["gift"]),
        giftCount: json["giftCount"],
        startDate: DateTime.parse(json["startDate"]),
        expireDate: DateTime.parse(json["expireDate"]),
        isExclusive: json["isExclusive"],
        giftCode: json["giftCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "products": products?.toJson(),
        "minProductCount": minProductCount,
        "gift": gift?.toJson(),
        "giftCount": giftCount,
        "startDate": startDate?.toIso8601String(),
        "expireDate": expireDate?.toIso8601String(),
        "isExclusive": isExclusive,
        "giftCode": giftCode,
      };
}
