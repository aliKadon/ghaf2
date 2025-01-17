class UnpaidOrder {
  final String id;
  final String createDate;
  final String? estimatedDeliveryDate;
  final String? desiredDeliveryDate;
  final String? deliverdAt;
  final Map<String, dynamic>? deliveryPoint;
  final Map<String, dynamic>? currentLocation;
  final int? status;
  final bool? payed;
  final Map<String, dynamic>? deliveryMethod;
  final String? deleveryCost;
  final double? orderCostForCustomer;
  final int? totalCostForItems;
  final String? statusName;
  final String? customer;
  final List<dynamic>? items;
  final String? userCredentialsId;
  final Map<String, dynamic>? branch;
  final int? canPayLaterValue;
  final int? redeemPointsForProducts;
  final int? redeemPointsForBill;
  final int? redeemPointsFactor;
  final int? driverId;

  UnpaidOrder(
      this.id,
      this.createDate,
      this.estimatedDeliveryDate,
      this.desiredDeliveryDate,
      this.deliverdAt,
      this.deliveryPoint,
      this.currentLocation,
      this.status,
      this.payed,
      this.deliveryMethod,
      this.deleveryCost,
      this.orderCostForCustomer,
      this.totalCostForItems,
      this.statusName,
      this.customer,
      this.items,
      this.userCredentialsId,
      this.branch,
      this.canPayLaterValue,
      this.redeemPointsForProducts,
      this.redeemPointsForBill,
      this.redeemPointsFactor,
      this.driverId);
}
