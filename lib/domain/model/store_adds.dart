class StoreAdds {
  String? id;
  String? storeId;
  String? addImage;
  String? startDate;
  String? expireDate;
  String? addedAt;
  String? addHeader;
  String? addDescription;
  String? addFooter;
  num? minAmountToGetDiscount;
  num? saveValue;
  String? storeName;
  String? imageToShow;

  StoreAdds({
    this.id,
    this.storeName,
    this.addDescription,
    this.addHeader,
    this.startDate,
    this.imageToShow,
    this.expireDate,
    this.addImage,
    this.addFooter,
    this.addedAt,
    this.storeId,
    this.minAmountToGetDiscount,
    this.saveValue,
  });

  factory StoreAdds.fromJson(Map<String, dynamic> json) => StoreAdds(
        storeId: json['storeId'],
        storeName: json['storeName'],
        id: json['id'],
        startDate: json['startDate'],
        imageToShow: json['imageToShow'],
        expireDate: json['expireDate'],
        addImage: json['addImage'],
        addHeader: json['addHeader'],
        addFooter: json['addFooter'],
        addDescription: json['addDescription'],
        addedAt: json['addedAt'],
        minAmountToGetDiscount: json['minAmountToGetDiscount'],
        saveValue: json['saveValue'],
      );

  Map<String, dynamic> toJson() => {
        'storeId': storeId,
        'storeName': storeName,
        'id': id,
        'startDate': startDate,
        'imageToShow': imageToShow,
        'expireDate': expireDate,
        'addImage': addImage,
        'addHeader': addHeader,
        'addFooter': addFooter,
        'addDescription': addDescription,
        'addedAt': addedAt,
        'minAmountToGetDiscount': minAmountToGetDiscount,
        'saveValue': saveValue,
      };
}
