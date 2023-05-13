import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

import '../../domain/model/address.dart';
import '../resources/font_manager.dart';

class MyOrdersWidget extends StatelessWidget {
  final String branchName;
  final String statusName;
  final String date;
  final String price;
  final String orderSequence;
  Address? branchAddress;
  String image;

  MyOrdersWidget(
      {required this.price,
      required this.date,
      required this.image,
      required this.statusName,
      required this.orderSequence,
      required this.branchAddress,
      required this.branchName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Row(
          children: [
            Image.network(
              image,
              height: AppSize.s92,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  ImageAssets.groceryOrder,
                  height: AppSize.s92,
                );
              },
            ),
            SizedBox(
              width: AppSize.s20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: AppSize.s123,
                      child: Text('${branchName}',
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s16)),
                    ),
                    SizedBox(
                      width: AppSize.s60,
                    ),
                    Container(
                      width: AppSize.s82,
                      child: Text(
                          '${price} ${AppLocalizations.of(context)!.aed}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s16)),
                    )
                  ],
                ),
                Text('${date.substring(0, 10)}',
                    style: TextStyle(
                        color: ColorManager.greyLight,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16)),
                Container(
                  width: AppSize.s222,
                  child: Text(
                      '${branchAddress?.addressName},${branchAddress?.buildingOrStreetName}',
                      style: TextStyle(
                          color: ColorManager.black,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.s14)),
                ),
                Text('order id : ${orderSequence == 'null' ? 0 : orderSequence}',
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize.s14)),
                statusName == 'Canceled'
                    ? Text(AppLocalizations.of(context)!.canceled,
                        style: TextStyle(
                            color: ColorManager.red,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.s16)) : statusName == 'Done'
                    ? Text(AppLocalizations.of(context)!.delivered,
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16))
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
