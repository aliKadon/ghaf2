class ReadIndividualProducts {
  String? id;
  String? name;
  num? price;
  String? stripeId;
  String? priceId;
  String? description;
  String? characteristics;
  String? productType;
  String? isoCurrencySymbol;
  String? addedAt;
  List<dynamic>? ghafImageIndividual;
  String? userCredentialsId;

  ReadIndividualProducts({
    this.id,
    this.name,
    this.price,
    this.stripeId,
    this.priceId,
    this.description,
    this.characteristics,
    this.productType,
    this.isoCurrencySymbol,
    this.addedAt,
    this.ghafImageIndividual,
    this.userCredentialsId,
  });

  factory ReadIndividualProducts.fromJson(Map<String, dynamic> json) =>
      ReadIndividualProducts(
        userCredentialsId: json['userCredentialsId'],
        id: json['id'],
        addedAt: json['addedAt'],
        productType: json['productType'],
        price: json['price'],
        isoCurrencySymbol: json['isoCurrencySymbol'],
        name: json['name'],
        stripeId: json['stripeId'],
        priceId: json['priceId'],
        description: json['description'],
        characteristics: json['characteristics'],
        ghafImageIndividual: json['ghafImageIndividual'],
      );

  Map<String, dynamic> toJson() => {
        'userCredentialsId': userCredentialsId,
        'id': id,
        'addedAt': addedAt,
        'productType': productType,
        'price': price,
        'isoCurrencySymbol': isoCurrencySymbol,
        'name': name,
        'stripeId': stripeId,
        'priceId': priceId,
        'description': description,
        'characteristics': characteristics,
        'ghafImageIndividual': ghafImageIndividual,
      };
}
