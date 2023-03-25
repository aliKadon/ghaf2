class RedeemHistoryItem {
  String? id;
  num? balance;
  String? paymentDate;
  String? userCredentialsId;
  String? storeId;
  String? storeName;
  String? storeLogo;

  RedeemHistoryItem({
    this.id,
    this.balance,
    this.storeName,
    this.storeLogo,
    this.paymentDate,
    this.userCredentialsId,
    this.storeId,
  });

  factory RedeemHistoryItem.fromJson(Map<String, dynamic> json) => RedeemHistoryItem(
        id: json['id'],
        storeName: json['storeName'],
        storeLogo: json['storeLogo'],
        balance: json['balance'],
        paymentDate: json['paymentDate'],
        storeId: json['storeId'],
        userCredentialsId: json['userCredentialsId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeName': storeName,
        'storeLogo': storeLogo,
        'balance': balance,
        'paymentDate': paymentDate,
        'storeId': storeId,
        'userCredentialsId': userCredentialsId,
      };
}
