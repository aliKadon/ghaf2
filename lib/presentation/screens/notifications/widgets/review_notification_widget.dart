import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/rate_and_reviews/rate_delivery/rate_delivery.dart';
import 'package:ghaf_application/presentation/screens/rate_and_reviews/rate_shop/rate_shop.dart';

import '../../../resources/font_manager.dart';

class ReviewNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Image.asset(ImageAssets.brStore),
        title: Text('baskin robbins',
            style: TextStyle(
                color: ColorManager.primaryDark, fontWeight: FontWeight.w600)),
        subtitle: Text('20 dec 2022',
            style: TextStyle(color: ColorManager.greyLight)),
        trailing: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ColorManager.primaryDark)),
            onPressed: () {
              _customDialogRate(context);
            },
            child: Text(AppLocalizations.of(context)!.rate)),
      ),
    );
  }

  void _customDialogRate(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.order_details,
                              style: TextStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorManager.greyLight),
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(14),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Text(
                                        '1 x coffee',
                                        style: TextStyle(
                                            color: ColorManager.primaryDark,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Text('20 AED'),
                                      SizedBox(
                                        height: AppSize.s24,
                                      )
                                    ],
                                  );
                                },
                              ),
                              Divider(
                                thickness: 1,
                                color: ColorManager.greyLight,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.total,
                                    style: TextStyle(
                                        color: ColorManager.primaryDark,
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  Text('40 AED',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.s14,
                                          color: ColorManager.primaryDark)),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.order_date,
                              style: TextStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text('10\\3\\2023',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSize.s12,
                                    color: ColorManager.grey)),
                          ],
                        ),
                        SizedBox(
                          height: AppSize.s14,
                        ),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.delivery_date,
                              style: TextStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text('10\\3\\2023',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSize.s12,
                                    color: ColorManager.grey)),
                          ],
                        ),
                        SizedBox(
                          height: AppSize.s35,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Container(
                              height: AppSize.s46,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          ColorManager.primaryDark),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RateShop(),
                                        ));
                                  },
                                  child: Text(AppLocalizations.of(context)!
                                      .rate_shop1)),
                            ),
                            Spacer(),
                            Container(
                              height: AppSize.s46,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          ColorManager.primaryDark),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RateDelivery(),
                                        ));
                                  },
                                  child: Text(AppLocalizations.of(context)!
                                      .rate_delivery1)),
                            ),
                            Spacer(),
                          ],
                        ),
                      ]),
                ),
              );
            },
          );
        });
  }
}
