import 'package:ghaf_application/domain/model/ghaf_image.dart';

class ReadIndividualProducts {
  String id;
  String name;
  int price;
  String stripeId;
  String priceId;
  String description;
  String characteristics;
  String productType;
  String isoCurrencySymbol;
  String addedAt;
  List<dynamic>? ghafImageIndividual;

  ReadIndividualProducts(
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
      this.ghafImageIndividual);
}
