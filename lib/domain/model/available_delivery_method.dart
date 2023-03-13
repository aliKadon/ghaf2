class AvailableDeliveryMethod {
  String? id;
  String? branchId;
  String? deliveryMethodId;
  String? isoCurrencySymbol;
  num? cost;
  String? methodName;
  String? methodImage;

  AvailableDeliveryMethod({
    this.id,
    this.isoCurrencySymbol,
    this.cost,
    this.methodName,
    this.branchId,
    this.deliveryMethodId,
    this.methodImage,
  });

  factory AvailableDeliveryMethod.fromJson(Map<String, dynamic> json) =>
      AvailableDeliveryMethod(
        id: json['id'],
        branchId: json['branchId'],
        deliveryMethodId: json['deliveryMethodId'],
        cost: json['cost'],
        methodName: json['methodName'],
        isoCurrencySymbol: json['isoCurrencySymbol'],
        methodImage: json['methodImage'],
      );

  Map<String,dynamic> toJson() => {
    'id' : id,
    'branchId' : branchId,
    'deliveryMethodId' : deliveryMethodId,
    'cost' : cost,
    'methodName' : methodName,
    'isoCurrencySymbol' :isoCurrencySymbol,
    'methodImage' : methodImage,
  };
}
