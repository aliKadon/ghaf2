class PaymentHistory {
  String? id;
  num? balance;
  String? paymentDate;
  String? userCredentialsId;
  String? storeId;
  String? storeName;
  String? storeLogo;

  PaymentHistory({
    this.id,
    this.balance,
    this.storeId,
    this.paymentDate,
    this.storeLogo,
    this.storeName,
    this.userCredentialsId,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
        userCredentialsId: json['userCredentialsId'],
        id: json['id'],
        storeId: json['storeId'],
        balance: json['balance'],
        paymentDate: json['paymentDate'],
        storeLogo: json['storeLogo'],
        storeName: json['storeName'],
      );

  Map<String, dynamic> toJson() => {
        'userCredentialsId': userCredentialsId,
        'id': id,
        'storeId': storeId,
        'balance': balance,
        'paymentDate': paymentDate,
        'storeLogo': storeLogo,
        'storeName': storeName,
      };
}
