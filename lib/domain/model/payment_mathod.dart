class PaymentMethod {
  String? id;
  String? last4Digits;
  String? brand;
  num? expMonth;
  num? expYear;
  String? image;

  PaymentMethod({
    this.id,
    this.image,
    this.expYear,
    this.expMonth,
    this.last4Digits,
    this.brand,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        image: json['image'],
        id: json['id'],
        brand: json['brand'],
        expMonth: json['expMonth'],
        expYear: json['expYear'],
        last4Digits: json['last4Digits'],
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'id': id,
        'brand': brand,
        'expMonth': expMonth,
        'expYear': expYear,
        'last4Digits': last4Digits,
      };
}
