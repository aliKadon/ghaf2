import 'package:ghaf_application/domain/model/branch.dart';
import 'package:ghaf_application/domain/model/delivery_method.dart';
import 'package:ghaf_application/domain/model/items.dart';

import 'address.dart';

class ScheduleOrder {
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
  String? mealType;

  ScheduleOrder({
    this.deliveryPoint,
    this.branch,
    this.id,
    this.deliveryMethod,
    this.hourNumber,
    this.mealType,
    this.items,
    this.sequenceNumber,
    this.createDate,
    this.paymentMethodId,
    this.userCredentialsId,
    this.minuteNumber,
    this.dayNumber,
    this.branchDeliveryCostId,
    this.customer,
    this.totalCostForItems,
    this.branchId,
    this.weeklyOrMonthly,
  });

  factory ScheduleOrder.fromJson(Map<String, dynamic> json) => ScheduleOrder(
        id: json['id'],
        mealType: json['mealType'],
        items: json['items'] == null
            ? null
            : List<Items>.from(
                json['items'].map((x) => Items.fromJson(json['items']))),
        createDate: json['createDate'],
        userCredentialsId: json['userCredentialsId'],
        branch: json['branch'] == null ? null : Branch.fromJson(json['branch']),
        branchId: json['branchId'],
        weeklyOrMonthly: json['weeklyOrMonthly'],
        minuteNumber: json['minuteNumber'],
        hourNumber: json['hourNumber'],
        dayNumber: json['dayNumber'],
        branchDeliveryCostId: json['branchDeliveryCostId'],
        sequenceNumber: json['sequenceNumber'],
        totalCostForItems: json['totalCostForItems'],
        customer: json['customer'],
        deliveryMethod: json['deliveryMethod'] == null
            ? null
            : DeliveryMethod.fromJson(json['deliveryMethod']),
        deliveryPoint: json['deliveryPoint'] == null
            ? null
            : Address.fromJson(json['deliveryPoint']),
        paymentMethodId: json['paymentMethodId'],
      );
}
