class PromoCode {
  String? id;
  String? userCredentialsId;
  String? storeId;
  num? discount;
  String? code;
  String? storeName;

  PromoCode(
      {this.id,
      this.storeId,
      this.storeName,
      this.discount,
      this.code,
      this.userCredentialsId});

  factory PromoCode.fromJson(Map<String,dynamic> json) => PromoCode(
    storeId: json['storeId'],
    id: json['id'],
    userCredentialsId: json['userCredentialsId'],
    storeName: json['storeName'],
    discount: json['discount'],
    code: json['code'],
  );

  Map<String,dynamic> toJson() => {
    'storeId' : storeId,
    'id' : id,
    'userCredentialsId' : userCredentialsId,
    'storeName' :storeName,
    'discount' : discount,
    'code' : code,
  };
}
