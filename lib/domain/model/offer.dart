class Offer {
  Offer({
    this.id,
    this.name,
    this.productsId,
    this.minProductCount,
    this.giftId,
    this.giftCount,
    this.startDate,
    this.expireDate,
    this.isExclusive,
    this.giftCode,
    this.description,
  });

  String? id;
  String? name;
  String? productsId;
  int? minProductCount;
  String? giftId;
  int? giftCount;
  DateTime? startDate;
  DateTime? expireDate;
  bool? isExclusive;
  String? giftCode;
  String? description;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        name: json["name"],
        productsId: json["productsId"],
        minProductCount: json["minProductCount"],
        giftId: json["giftId"],
        giftCount: json["giftCount"],
        startDate: DateTime.parse(json["startDate"]),
        expireDate: DateTime.parse(json["expireDate"]),
        isExclusive: json["isExclusive"],
        giftCode: json["giftCode"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "productsId": productsId,
        "minProductCount": minProductCount,
        "giftId": giftId,
        "giftCount": giftCount,
        "startDate": startDate?.toIso8601String(),
        "expireDate": expireDate?.toIso8601String(),
        "isExclusive": isExclusive,
        "giftCode": giftCode,
        "description": description,
      };
}
