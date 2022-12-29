class ProductDiscount {
  ProductDiscount({
    this.id,
    this.name,
    this.productsId,
    this.discount,
    this.startDate,
    this.expireDate,
    this.isExclusive,
    this.discountCode,
    this.description,
    this.points,
  });

  String? id;
  String? name;
  String? productsId;
  num? discount;
  DateTime? startDate;
  DateTime? expireDate;
  bool? isExclusive;
  String? discountCode;
  String? description;
  int? points;

  factory ProductDiscount.fromJson(Map<String, dynamic> json) =>
      ProductDiscount(
        id: json["id"],
        name: json["name"],
        productsId: json["productsId"],
        discount: json["discount"] == null ? null : json["discount"],
        startDate: DateTime.parse(json["startDate"]),
        expireDate: DateTime.parse(json["expireDate"]),
        isExclusive: json["isExclusive"],
        discountCode: json["discountCode"],
        description: json["description"],
        points: json["points"] == null ? null : json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "productsId": productsId,
        "discount": discount == null ? null : discount,
        "startDate": startDate?.toIso8601String(),
        "expireDate": expireDate?.toIso8601String(),
        "isExclusive": isExclusive,
        "discountCode": discountCode,
        "description": description,
        "points": points == null ? null : points,
      };
}
