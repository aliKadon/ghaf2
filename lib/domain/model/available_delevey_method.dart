class OrderAllInformation {
  // final String id;
  // final String storeId;
  // final String deliveryMethodId;
  // final String isoCurrencySymbol;
  // final String cost;
  // final String methodName;

  final dynamic orderDetails;
  final List<dynamic> availableDeliveryMethod;
  final dynamic customerPoints;

  OrderAllInformation(this.orderDetails, this.availableDeliveryMethod, this.customerPoints);
}
