import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

import '../resources/font_manager.dart';

class MyOrdersWidget extends StatelessWidget {
  final String date;
  final String price;
  final String orderSequence;

  MyOrdersWidget(
      {required this.price, required this.date, required this.orderSequence});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Row(
          children: [
            Image.asset(
              ImageAssets.groceryOrder,
              height: AppSize.s92,
            ),
            SizedBox(
              width: AppSize.s20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Beauty line baqala',
                        style: TextStyle(
                            color: ColorManager.primaryDark,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.s16)),
                    SizedBox(
                      width: AppSize.s60,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.16,
                      child: Text('${price} ${AppLocalizations.of(context)!.aed}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s16)),
                    )
                  ],
                ),
                Text('${date}',
                    style: TextStyle(
                        color: ColorManager.greyLight,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16)),
                Text('also lila stret,247',
                    style: TextStyle(
                        color: ColorManager.black,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s14)),
                Text('order id :${orderSequence}',
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize.s14)),
                Text('canceled',
                    style: TextStyle(
                        color: ColorManager.red,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
