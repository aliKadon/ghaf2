import 'dart:ffi';

import 'package:flutter_stripe/flutter_stripe.dart';

class CreateOrder {
  final String OrderId;
  final String DeliveryMethodId;
  final DateTime? DesiredDeliveryDate;
  final Address? DeliveryPoint;
  final bool UseRedeemPoints;
  final bool UsePayLater;
  final String paymentMethodType;
  final String CardNumber;
  final Long? CardExpMonth;
  final String? CardExpCvc;
  final Long? CardExpYear;

  CreateOrder(
      {required this.OrderId,
      required this.DeliveryMethodId,
      this.DesiredDeliveryDate,
      this.DeliveryPoint,
      required this.UseRedeemPoints,
      required this.UsePayLater,
      required this.paymentMethodType,
      required this.CardNumber,
      this.CardExpCvc,
      this.CardExpMonth,
      this.CardExpYear});
}
