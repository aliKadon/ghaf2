import 'package:ghaf_application/domain/model/order_item.dart';

class Order {
  Order({
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
    this.items,
    this.userCredentialsId,
    this.branch,
    this.canPayLaterValue,
    this.redeemPointsForProducts,
    this.redeemPointsForBill,
    this.redeemPointsFactor,
  });

  String? id;
  DateTime? createDate;
  DateTime? estimatedDeliveryDate;
  DateTime? desiredDeliveryDate;
  DateTime? deliverdAt;
  dynamic deliveryPoint;
  dynamic currentLocation;
  int? status;
  bool? payed;
  dynamic deliveryMethod;
  dynamic deleveryCost;
  num? orderCostForCustomer;
  num? totalCostForItems;
  List<OrderItem>? items;
  String? userCredentialsId;
  dynamic branch;
  int? canPayLaterValue;
  int? redeemPointsForProducts;
  int? redeemPointsForBill;
  int? redeemPointsFactor;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        estimatedDeliveryDate: json["estimatedDeliveryDate"] == null
            ? null
            : DateTime.parse(json["estimatedDeliveryDate"]),
        desiredDeliveryDate: json["desiredDeliveryDate"] == null
            ? null
            : DateTime.parse(json["desiredDeliveryDate"]),
        deliverdAt: json["deliverdAt"] == null
            ? null
            : DateTime.parse(json["deliverdAt"]),
        deliveryPoint: json["deliveryPoint"],
        currentLocation: json["currentLocation"],
        status: json["status"],
        payed: json["payed"],
        deliveryMethod: json["deliveryMethod"],
        deleveryCost: json["deleveryCost"],
        orderCostForCustomer: json["orderCostForCustomer"],
        totalCostForItems: json["totalCostForItems"],
        items: json["items"] == null
            ? []
            : List<OrderItem>.from(
                json["items"].map((x) => OrderItem.fromJson(x))),
        userCredentialsId: json["userCredentialsId"],
        branch: json["branch"],
        canPayLaterValue: json["canPayLaterValue"],
        redeemPointsForProducts: json["redeemPointsForProducts"],
        redeemPointsForBill: json["redeemPointsForBill"],
        redeemPointsFactor: json["redeemPointsFactor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createDate": createDate?.toIso8601String(),
        "estimatedDeliveryDate": estimatedDeliveryDate,
        "desiredDeliveryDate": desiredDeliveryDate,
        "deliverdAt": deliverdAt,
        "deliveryPoint": deliveryPoint,
        "currentLocation": currentLocation,
        "status": status,
        "payed": payed,
        "deliveryMethod": deliveryMethod,
        "deleveryCost": deleveryCost,
        "orderCostForCustomer": orderCostForCustomer,
        "totalCostForItems": totalCostForItems,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "userCredentialsId": userCredentialsId,
        "branch": branch,
        "canPayLaterValue": canPayLaterValue,
        "redeemPointsForProducts": redeemPointsForProducts,
        "redeemPointsForBill": redeemPointsForBill,
        "redeemPointsFactor": redeemPointsFactor,
      };
}
