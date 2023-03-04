import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/notifications/widgets/notifications_widget.dart';
import 'package:ghaf_application/presentation/screens/notifications/widgets/review_notification_widget.dart';
import 'package:ghaf_application/presentation/widgets/most_popular_product_widget.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class NotificationsScreenNew extends StatefulWidget {
  @override
  State<NotificationsScreenNew> createState() => _NotificationsScreenNewState();
}

class _NotificationsScreenNewState extends State<NotificationsScreenNew> {
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    List notificationsType = [
      AppLocalizations.of(context)!.offers,
      AppLocalizations.of(context)!.discount,
      AppLocalizations.of(context)!.pay_later,
      AppLocalizations.of(context)!.review
    ];
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(AppSize.s6),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    IconsAssets.arrow,
                    height: AppSize.s18,
                    width: AppSize.s10,
                    color: ColorManager.primaryDark,
                  ),
                ),
              ),
              Spacer(),
              Text(
                AppLocalizations.of(context)!.notifications,
                style: getSemiBoldStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s18,
                ),
              ),
              Spacer(),
            ],
          ),
          Divider(
            thickness: 1,
            color: ColorManager.greyLight,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: notificationsType.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: AppSize.s10,
                      ),
                      selected == index
                          ? Container(
                              height: AppSize.s38,
                              width: AppSize.s92,
                              // padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: ColorManager.primary,
                                  border:
                                      Border.all(color: ColorManager.primary),
                                  borderRadius: BorderRadius.circular(5),
                                  shape: BoxShape.rectangle),
                              child: Center(
                                child: Text(notificationsType[index],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                            )
                          : Container(
                              height: AppSize.s38,
                              width: AppSize.s92,
                              // padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorManager.greyLight),
                                  borderRadius: BorderRadius.circular(5),
                                  shape: BoxShape.rectangle),
                              child: Center(
                                  child: Text(notificationsType[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600))),
                            ),
                      SizedBox(
                        width: AppSize.s10,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              selected == 0
                  ? AppLocalizations.of(context)!
                      .the_most_important_product_offer
                  : selected == 1
                      ? AppLocalizations.of(context)!
                          .the_most_important_product_discount
                      : selected == 2
                          ? AppLocalizations.of(context)!
                              .newly_added_products_and_pay_later
                          : AppLocalizations.of(context)!
                              .share_your_feedback_about_your_order,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorManager.primaryDark,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSize.s16),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.71,
            child: selected == 2
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisExtent: 300),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return MostPopularProductWidget();
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return selected == 3
                          ? ReviewNotificationWidget()
                          : NotificationsWidget(
                              text:
                                  AppLocalizations.of(context)!.offer_end_soon,
                            );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
