class GhafImageIndividual {
  String? id;
  String? data;
  String? productsId;
  String? individualProductsId;

  GhafImageIndividual({
    this.id,
    this.data,
    this.individualProductsId,
    this.productsId,
  });

  factory GhafImageIndividual.fromJson(Map<String,dynamic> json) => GhafImageIndividual(
    id: json['id'],
    data: json['data'],
    individualProductsId: json['individualProductsId'],
    productsId: json['productsId'],
  );

  Map<String,dynamic> toJson() => {
    'id' : id,
    'data' : data,
    'individualProductsId' : individualProductsId,
    'productsId' : productsId,
  };
}
