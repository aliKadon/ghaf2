class PlanSellerIndividual {
  String? id;
  String? name;
  String? priceCurrency;
  String? priceRecuencyInterval;
  int? priceAmount;
  String? description;
  String? priceId;
  int? setUpCost;
  String? stripeId;
  int? type;
  int? freeDays;
  String? typeName;
  bool? hide;
  String? generalDescription;
  String? descriptions1;
  String? descriptions2;

  PlanSellerIndividual({
    this.id,
    this.name,
    this.description,
    this.priceId,
    this.stripeId,
    this.type,
    this.freeDays,
    this.hide,
    this.priceAmount,
    this.priceCurrency,
    this.priceRecuencyInterval,
    this.setUpCost,
    this.typeName,
    this.generalDescription,
    this.descriptions1,
    this.descriptions2,
  });
}
