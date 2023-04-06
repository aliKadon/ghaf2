class PayLaterProduct {
  String? groupId;
  String? productName;
  num? price;
  List<dynamic>? images;
  num? stars;
  num? reviewCount;
  bool? active;

  PayLaterProduct({
    this.price,
    this.stars,
    this.productName,
    this.reviewCount,
    this.active,
    this.groupId,
    this.images,
  });

  factory PayLaterProduct.fromJson(Map<String, dynamic> json) =>
      PayLaterProduct(
        productName: json['productName'],
        reviewCount: json['reviewCount'],
        price: json['price'],
        stars: json['stars'],
        active: json['active'],
        groupId: json['groupId'],
        images: json['images'],
      );

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'reviewCount': reviewCount,
        'price': price,
        'stars': stars,
        'active': active,
        'groupId': groupId,
        'images': images,
      };
}
