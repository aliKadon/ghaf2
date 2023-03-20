import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

class TransactionWidget extends StatefulWidget {
  final String balance;
  final String date;
  final String imageUrl;
  final String storeName;

  TransactionWidget(
      {required this.balance, required this.imageUrl, required this.date,required this.storeName});

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          widget.imageUrl.isEmpty ? Image.asset(
            ImageAssets.brIcon,
            height: AppSize.s60,
          ) : Image.network(
            widget.imageUrl,
            height: AppSize.s60,
          ),
          SizedBox(
            width: AppSize.s30,
          ),
          Column(
            children: [
              Text('${widget.storeName}',
                  style: TextStyle(
                      color: ColorManager.primaryDark,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.s16)),
              Text(
                '${widget.date}',
                style: TextStyle(
                    color: ColorManager.greyLight,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Spacer(),
          Text(
            '-${widget.balance}',
            style: TextStyle(
                color: ColorManager.black,
                fontWeight: FontWeight.w600,
                fontSize: FontSize.s16),
          ),
          SizedBox(
            width: AppSize.s20,
          )
        ],
      ),
    );
  }
}
