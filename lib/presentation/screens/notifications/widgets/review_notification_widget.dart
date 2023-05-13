import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/domain/model/items.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/rate_and_reviews/rate_delivery/rate_delivery.dart';
import 'package:ghaf_application/presentation/screens/rate_and_reviews/rate_shop/rate_shop.dart';

import '../../../resources/font_manager.dart';

class ReviewNotificationWidget extends StatelessWidget {
  final num sequenceNumber;
  final String createDate;
  String? branchLogoImage;
  String? deliveryDate;
  String? orderId;
  String? deliveryId;
  final List<Items> items;
  final num orderCostForCustomer;

  ReviewNotificationWidget(
      {required this.branchLogoImage,
      required this.createDate,
      required this.items,
        this.orderId,
        this.deliveryId,
      required this.deliveryDate,
      required this.orderCostForCustomer,
      required this.sequenceNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: branchLogoImage == null
            ? Image.asset(ImageAssets.brStore)
            : Image.network(
                branchLogoImage!,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset(ImageAssets.x, color: ColorManager.red),
              ),
        title: Text('# $sequenceNumber',
            style: TextStyle(
                color: ColorManager.primaryDark, fontWeight: FontWeight.w600)),
        subtitle:
            Text(createDate, style: TextStyle(color: ColorManager.greyLight)),
        trailing: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ColorManager.primaryDark)),
            onPressed: () {
              _customDialogRate(
                  context: context,
                  orderId: orderId!,
                  createDate: createDate,
                  items: items,
                  orderCostForCustomer: orderCostForCustomer,
                  deliveryDate: deliveryDate);
            },
            child: Text(AppLocalizations.of(context)!.rate)),
      ),
    );
  }

  void _customDialogRate({
    required BuildContext context,
    required List<Items> items,
    required String createDate,
    required String? deliveryDate,
    required num orderCostForCustomer,
    required String orderId,
  }) async {
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
                    borderRadius: BorderRadius.circular(AppRadius.r8),
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
                              borderRadius: BorderRadius.circular(AppSize.s15)),
                          padding: EdgeInsets.all(AppSize.s14),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Text(
                                        '${items[index].quanity} x ${items[index].name}',
                                        style: TextStyle(
                                            color: ColorManager.primaryDark,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Text(
                                          '${items[index].price} ${items[index].isoCurrencySymbol}'),
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
                                  Text(
                                      '${orderCostForCustomer} ${items[0].isoCurrencySymbol}',
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
                            Text('${createDate}',
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
                            Text('${deliveryDate}',
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
                                                  BorderRadius.circular(AppSize.s10)))),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RateShop(storeId: orderId),
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
                                                  BorderRadius.circular(AppSize.s10)))),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RateDelivery(deliveryId: deliveryId! ),
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
