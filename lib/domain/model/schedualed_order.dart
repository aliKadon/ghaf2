import 'package:ghaf_application/domain/model/address.dart';
import 'package:ghaf_application/domain/model/branch.dart';
import 'package:ghaf_application/domain/model/delivery_method.dart';

import 'items.dart';

class ScheduledOrder {
  String? id;
  String? createDate;
  Address? deliveryPoint;
  String? branchDeliveryCostId;
  num? totalCostForItems;
  String? customer;
  List<Items>? items;
  String? userCredentialsId;
  String? branchId;
  num? sequenceNumber;
  String? paymentMethodId;
  num? weeklyOrMonthly;
  num? dayNumber;
  num? hourNumber;
  num? minuteNumber;
  DeliveryMethod? deliveryMethod;
  Branch? branch;

  ScheduledOrder({
    this.id,
    this.branchId,
    this.userCredentialsId,
    this.branch,
    this.deliveryPoint,
    this.paymentMethodId,
    this.totalCostForItems,
    this.sequenceNumber,
    this.items,
    this.customer,
    this.branchDeliveryCostId,
    this.createDate,
    this.dayNumber,
    this.deliveryMethod,
    this.hourNumber,
    this.minuteNumber,
    this.weeklyOrMonthly,
  });

  factory ScheduledOrder.fromJson(Map<String, dynamic> json) => ScheduledOrder(
        id: json['id'],
        userCredentialsId: json['userCredentialsId'],
        branchId: json['branchId'],
        paymentMethodId: json['paymentMethodId'],
        deliveryPoint: Address.fromJson(json['deliveryPoint']),
        deliveryMethod: DeliveryMethod.fromJson(json['deliveryMethod']),
        branch: Branch.fromJson(json['branch']),
        customer: json['customer'],
        totalCostForItems: json['totalCostForItems'],
        items: List<Items>.from(json['items'].map((x) => Items.fromJson(x))),
        createDate: json['createDate'],
        sequenceNumber: json['sequenceNumber'],
        branchDeliveryCostId: json['branchDeliveryCostId'],
        dayNumber: json['dayNumber'],
        hourNumber: json['hourNumber'],
        minuteNumber: json['minuteNumber'],
        weeklyOrMonthly: json['weeklyOrMonthly'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userCredentialsId': userCredentialsId,
        'branchId': branchId,
        'paymentMethodId': paymentMethodId,
        'deliveryPoint': deliveryPoint,
        'deliveryMethod': deliveryMethod,
        'branch': branch,
        'customer': customer,
        'totalCostForItems': totalCostForItems,
        'items': items,
        'createDate': createDate,
        'sequenceNumber': sequenceNumber,
        'branchDeliveryCostId': branchDeliveryCostId,
        'branchDeliveryCostId': branchDeliveryCostId,
        'dayNumber': dayNumber,
        'hourNumber': hourNumber,
        'minuteNumber': minuteNumber,
        'weeklyOrMonthly': weeklyOrMonthly,
      };
}
