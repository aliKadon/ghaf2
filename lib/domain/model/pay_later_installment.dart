import 'package:ghaf_application/domain/model/product_for_this_operation_pay_later.dart';

class PayLaterInstallment {
  String? id;
  num? quantityItem;
  num? balance;
  String? userCredentialsId;
  String? storeId;
  String? productsId;
  String? cOrderId;
  String? installmentDate;
  String? installmentOrder;
  String? totalInstallment;
  bool? status;
  String? storeName;
  String? productName;
  String? customerName;
  ProductForThisOperationPayLater? productForThisOperation;

  PayLaterInstallment({
    this.id,
    this.quantityItem,
    this.userCredentialsId,
    this.storeId,
    this.status,
    this.storeName,
    this.balance,
    this.cOrderId,
    this.productName,
    this.customerName,
    this.installmentDate,
    this.installmentOrder,
    this.productForThisOperation,
    this.productsId,
    this.totalInstallment,
  });

  factory PayLaterInstallment.fromJson(Map<String,dynamic> json) => PayLaterInstallment(
    id: json['id'],
    quantityItem: json['quantity'],
    productsId: json['productsId'],
    userCredentialsId: json['userCredentialsId'],
    storeName: json['storeName'],
    storeId: json['storeId'],
    balance: json['balance'],
    status: json['status'],
    cOrderId: json['cOrderId'],
    customerName: json['customerName'],
    installmentDate: json['installmentDate'],
    installmentOrder: json['installmentOrder'],
    productForThisOperation: ProductForThisOperationPayLater.FromJson(json['productForThisOperation']),
    productName: json['productName'],
    totalInstallment: json['totalInstallment'],
  );

  Map<String,dynamic> toJson() => {
    'id' : id,
    'quantityItem' : quantityItem,
    'productsId' : productsId,
    'userCredentialsId' : userCredentialsId,
    'storeName' : storeName,
    'storeId' : storeId,
    'balance' : balance,
    'status' : status,
    'cOrderId' : cOrderId,
    'customerName' : customerName,
    'installmentDate' : installmentDate,
    'installmentOrder' : installmentOrder,
    'productForThisOperation' : productForThisOperation,
    'productName' : productName,
    'totalInstallment' : totalInstallment,
  };
}
