import 'package:ghaf_application/domain/model/redeem_history_item.dart';

class Redeem {
  List<RedeemHistoryItem>? list;
  num? total;

  Redeem({
    this.total,
    this.list,
  });

  factory Redeem.fromJson(Map<String, dynamic> json) => Redeem(
        list: List<RedeemHistoryItem>.from(
            json['list'].map((x) => RedeemHistoryItem.fromJson(x))),
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'list': list,
        'total': total,
      };
}
