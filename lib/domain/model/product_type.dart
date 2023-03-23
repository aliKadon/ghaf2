class ProductType {
  String? id;
  String? branchId;
  String? productType;
  String? productTypeAr;
  bool? isDeleted;

  ProductType({
    this.id,
    this.branchId,
    this.isDeleted,
    this.productType,
    this.productTypeAr,
  });

  factory ProductType.fromJson(Map<String,dynamic> json) => ProductType(
    branchId: json['branchId'],
    isDeleted: json['isDeleted'],
    id: json['id'],
    productType: json['productType'],
    productTypeAr: json['productTypeAr'],
  );

  Map<String,dynamic> toJson() => {
    'branchId' : branchId,
    'isDeleted' : isDeleted,
    'id' : id,
    'productType' : productType,
    'productTypeAr' : productTypeAr,
  };
}
