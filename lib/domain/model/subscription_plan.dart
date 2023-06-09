class SubscriptionPlan {
  String? id;
  String? name;
  String? priceCurrency;
  String? priceRecuencyInterval;
  num? priceAmount;
  String? description;
  String? priceId;
  num? setUpCost;
  String? stripeId;
  num? type;
  num? freeDays;
  String? typeName;
  bool? hide;
  String? descriptionEn;
  String? descriptionAr;

  SubscriptionPlan(
      {this.id,
      this.name,
      this.description,
      this.freeDays,
      this.hide,
      this.priceAmount,
      this.priceCurrency,
      this.priceId,
      this.priceRecuencyInterval,
      this.setUpCost,
      this.stripeId,
      this.type,
      this.typeName,
      this.descriptionAr,
      this.descriptionEn});

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        freeDays: json['freeDays'],
        hide: json['hide'],
        priceAmount: json['priceAmount'],
        priceCurrency: json['priceCurrency'],
        priceId: json['priceId'],
        priceRecuencyInterval: json['priceRecuencyInterval'],
        setUpCost: json['setUpCost'],
        stripeId: json['stripeId'],
        type: json['type'],
        typeName: json['typeName'],
        descriptionAr: json['descriptionAr'],
        descriptionEn: json['descriptionEn'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'freeDays': freeDays,
        'hide': hide,
        'priceAmount': priceAmount,
        'priceCurrency': priceCurrency,
        'priceId': priceId,
        'priceRecuencyInterval': priceRecuencyInterval,
        'setUpCost': setUpCost,
        'stripeId': stripeId,
        'type': type,
        'typeName': typeName,
        'descriptionEn': descriptionEn,
        'descriptionAr': descriptionAr,
      };
}
