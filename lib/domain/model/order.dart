import 'package:ghaf_application/domain/model/address.dart';
import 'package:ghaf_application/domain/model/branch.dart';
import 'package:ghaf_application/domain/model/items.dart';
import 'package:ghaf_application/domain/model/order_item.dart';

import 'meal_times.dart';



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
    this.statusName,
    this.customer,
    this.items,
    this.userCredentialsId,
    this.branch,
    this.canPayLaterValue,
    this.redeemPointsForProducts,
    this.redeemPointsForBill,
    this.redeemPointsFactor,
    this.sequenceNumber,
    this.driverId,

  });

  String? id;
  String? createDate;
  String? estimatedDeliveryDate;
  String? desiredDeliveryDate;
  String? deliverdAt;
  Address? deliveryPoint;
  dynamic currentLocation;
  int? status;
  bool? payed;
  String? statusName;
  String? customer;
  dynamic deliveryMethod;
  dynamic deleveryCost;
  num? orderCostForCustomer;
  num? totalCostForItems;
  List<Items>? items;
  String? userCredentialsId;
  Branch? branch;
  int? canPayLaterValue;
  int? redeemPointsForProducts;
  int? redeemPointsForBill;
  int? redeemPointsFactor;
  num? sequenceNumber;
  String? driverId;


  factory Order.fromJson(Map<String,dynamic> json) {
    return Order(
      id: json['id'],
      userCredentialsId: json['userCredentialsId'],
      sequenceNumber: json['sequenceNumber'],
      driverId: json['driverId'],
      redeemPointsForProducts: json['redeemPointsForProducts'],
      redeemPointsFactor: json['redeemPointsFactor'],
      createDate: json['createDate'],
      deliverdAt: json['deliverdAt'],
      desiredDeliveryDate: json['desiredDeliveryDate'],
      estimatedDeliveryDate: json['estimatedDeliveryDate'],
      items: json['items'] == null ? [] : List<Items>.from(
          json['items'].map((x) => Items.fromJson(x))),
      orderCostForCustomer: json['orderCostForCustomer'],
      status: json['status'],
      totalCostForItems: json['totalCostForItems'],
      customer: json['customer'],
      statusName: json['statusName'],
      branch:json['branch'] == null ? null : Branch.fromJson(json['branch']),
      canPayLaterValue: json['canPayLaterValue'],
      currentLocation: json['currentLocation'],
      deleveryCost: json['deleveryCost'],
      deliveryMethod: json['deliveryMethod'],
      deliveryPoint:json['deliveryPoint'] == null ? null :  Address.fromJson(json['deliveryPoint']),
      payed: json['payed'],
      redeemPointsForBill: json['redeemPointsForBill'],

    );
  }

  Map<String,dynamic> toJson() => {
    'id' : id,
    'userCredentialsId' : userCredentialsId,
    'sequenceNumber' : sequenceNumber,
    'driverId' : driverId,
    'redeemPointsForProducts' : redeemPointsForProducts,
    'redeemPointsFactor' : redeemPointsFactor,
    'createDate' : createDate,
    'deliverdAt' : deliverdAt,
    'desiredDeliveryDate' : desiredDeliveryDate,
    'estimatedDeliveryDate' : estimatedDeliveryDate,
    'items' : items,
    'orderCostForCustomer' : orderCostForCustomer,
    'status' : status,
    'totalCostForItems' : totalCostForItems,
    'customer' : customer,
    'statusName' : statusName,
    'branch' : branch,
    'canPayLaterValue' : canPayLaterValue,
    'currentLocation' : currentLocation,
    'deleveryCost' : deleveryCost,
    'deliveryMethod' : deliveryMethod,
    'deliveryPoint' : deliveryPoint,
    'payed' : payed,
    'redeemPointsForBill' : redeemPointsForBill,

  };

  // factory Order.fromJson(Map<String, dynamic> json) => Order(
  //       id: json["id"],
  //       createDate: json["createDate"] == null
  //           ? null
  //           : DateTime.parse(json["createDate"]),
  //       estimatedDeliveryDate: json["estimatedDeliveryDate"] == null
  //           ? null
  //           : DateTime.parse(json["estimatedDeliveryDate"]),
  //       desiredDeliveryDate: json["desiredDeliveryDate"] == null
  //           ? null
  //           : DateTime.parse(json["desiredDeliveryDate"]),
  //       deliverdAt: json["deliverdAt"] == null
  //           ? null
  //           : DateTime.parse(json["deliverdAt"]),
  //       deliveryPoint: json["deliveryPoint"],
  //       currentLocation: json["currentLocation"],
  //       status: json["status"],
  //       payed: json["payed"],
  //       deliveryMethod: json["deliveryMethod"],
  //       deleveryCost: json["deleveryCost"],
  //       orderCostForCustomer: json["orderCostForCustomer"],
  //       totalCostForItems: json["totalCostForItems"],
  //       items: json["items"] == null
  //           ? []
  //           : List<OrderItem>.from(
  //               json["items"].map((x) => OrderItem.fromJson(x))),
  //       userCredentialsId: json["userCredentialsId"],
  //       branch: json["branch"],
  //       canPayLaterValue: json["canPayLaterValue"],
  //       redeemPointsForProducts: json["redeemPointsForProducts"],
  //       redeemPointsForBill: json["redeemPointsForBill"],
  //       redeemPointsFactor: json["redeemPointsFactor"],
  //     );
  //
  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "createDate": createDate?.toIso8601String(),
  //       "estimatedDeliveryDate": estimatedDeliveryDate,
  //       "desiredDeliveryDate": desiredDeliveryDate,
  //       "deliverdAt": deliverdAt,
  //       "deliveryPoint": deliveryPoint,
  //       "currentLocation": currentLocation,
  //       "status": status,
  //       "payed": payed,
  //       "deliveryMethod": deliveryMethod,
  //       "deleveryCost": deleveryCost,
  //       "orderCostForCustomer": orderCostForCustomer,
  //       "totalCostForItems": totalCostForItems,
  //       "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  //       "userCredentialsId": userCredentialsId,
  //       "branch": branch,
  //       "canPayLaterValue": canPayLaterValue,
  //       "redeemPointsForProducts": redeemPointsForProducts,
  //       "redeemPointsForBill": redeemPointsForBill,
  //       "redeemPointsFactor": redeemPointsFactor,
  //     };
}
