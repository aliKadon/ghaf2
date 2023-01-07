class PlanSellerIndividual {
  String id;
  String name;
  String priceCurrency;
  String priceRecuencyInterval;
  int priceAmount;
  String description;
  String priceId;
  int setUpCost;
  String stripeId;
  int type;
  int freeDays;
  String typeName;
  bool hide;

  PlanSellerIndividual({
    required this.id,
    required this.name,
    required this.description,
    required this.priceId,
    required this.stripeId,
    required this.type,
    required this.freeDays,
    required this.hide,
    required this.priceAmount,
    required this.priceCurrency,
    required this.priceRecuencyInterval,
    required this.setUpCost,
    required this.typeName,


});
}