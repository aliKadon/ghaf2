import 'package:ghaf_application/domain/model/available_delivery_method.dart';
import 'package:ghaf_application/domain/model/order.dart';

class OrderToPay {
  Order? orderDetails;
  List<AvailableDeliveryMethod>? availableDeliveryMethod;
  num? customerPoints;
  num? costWithPromoCode;
  String? costWithStoreAdd;

  OrderToPay({
    this.orderDetails,
    this.availableDeliveryMethod,
    this.customerPoints,
    this.costWithPromoCode,
    this.costWithStoreAdd,
  });

  factory OrderToPay.fromJson(Map<String, dynamic> json) => OrderToPay(
        customerPoints: json['customerPoints'],
        costWithPromoCode: json['costWithPromoCode'],
        costWithStoreAdd: json['costWithStoreAdd'],
        orderDetails: Order.fromJson(json['orderDetails']),
        availableDeliveryMethod: List<AvailableDeliveryMethod>.from(
            json['availableDeliveryMethod']
                .map((x) => AvailableDeliveryMethod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'availableDeliveryMethod': availableDeliveryMethod,
        'customerPoints': customerPoints,
        'orderDetails': orderDetails,
        'costWithPromoCode': costWithPromoCode,
        'costWithStoreAdd': costWithStoreAdd,
      };
}
