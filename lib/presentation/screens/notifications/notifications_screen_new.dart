import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/notifications/widgets/notifications_widget.dart';
import 'package:ghaf_application/presentation/screens/notifications/widgets/review_notification_widget.dart';
import 'package:ghaf_application/presentation/screens/offers_view/offers_screen_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/product_item_new.dart';

import '../../../domain/model/product.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../home_view/home_view_getx_controller.dart';
import '../pay_later/pay_later_getx_controller.dart';

class NotificationsScreenNew extends StatefulWidget {
  @override
  State<NotificationsScreenNew> createState() => _NotificationsScreenNewState();
}

class _NotificationsScreenNewState extends State<NotificationsScreenNew> {
  //controller
  final OffersScreenGetXController _offersScreenGetXController =
      Get.put(OffersScreenGetXController());
  late final PayLaterGetxController _payLaterGetxController =
      Get.put(PayLaterGetxController());
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());
  HomeViewGetXController _homeViewGetXController =
      Get.put<HomeViewGetXController>(HomeViewGetXController());
  var selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    _homeViewGetXController.getProducts(context: context);
    _checkOutGetxController.getCustomerOrder(context: context);
    _offersScreenGetXController.getOffers(context: context);
    _offersScreenGetXController.getGifts(context: context);
    super.initState();
  }

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
                  ? GetBuilder<HomeViewGetXController>(
                      builder: (controller) => controller
                                  .payLaterProduct.length ==
                              0
                          ? Center(
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .no_product_found,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppSize.s14,
                                      color: ColorManager.primary)),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, mainAxisExtent: 300),
                              shrinkWrap: true,
                              itemCount: controller.payLaterProduct.length,
                              itemBuilder: (context, index) {
                                return controller.payLaterProduct.length == 0
                                    ? Center(
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .no_product_found,
                                            style: TextStyle(
                                                color: ColorManager.primary,
                                                fontWeight: FontWeight.w500,
                                                fontSize: FontSize.s16)),
                                      )
                                    : Builder(builder: (context) {
                                        Get.put<Product>(
                                          controller.payLaterProduct[index],
                                          tag:
                                              '${controller.payLaterProduct[index].id}',
                                        );
                                        return ProductItemNew(
                                          index: index,
                                          isFavorite: controller
                                              .payLaterProduct[index]
                                              .isFavorite!,
                                          tag:
                                              '${controller.payLaterProduct[index].id!}',
                                          idProduct: controller
                                              .payLaterProduct[index].id!,
                                          stars: controller
                                              .payLaterProduct[index].stars!,
                                          image: controller
                                                      .payLaterProduct[index]
                                                      .productImages!
                                                      .length ==
                                                  0
                                              ? ''
                                              : controller
                                                  .payLaterProduct[index]
                                                  .productImages![0],
                                          price: controller
                                              .payLaterProduct[index].price!,
                                          name: controller
                                              .payLaterProduct[index].name!,
                                        );
                                      });
                              },
                            ),
                    )
                  : selected == 3
                      ? _checkOutGetxController.doneorder.length == 0
                          ? Center(
                              child: Text(
                                  AppLocalizations.of(context)!.no_order_found,
                                  style: TextStyle(
                                      color: ColorManager.primary,
                                      fontSize: FontSize.s16,
                                      fontWeight: FontWeight.w600)),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  _checkOutGetxController.doneorder.length,
                              itemBuilder: (context, index) {
                                return ReviewNotificationWidget(
                                  deliveryId: _checkOutGetxController
                                      .doneorder[index].driverId,
                                  orderId: _checkOutGetxController
                                      .doneorder[index].branch!.storeId,
                                  deliveryDate: _checkOutGetxController
                                              .doneorder[index].deliverdAt ==
                                          null
                                      ? null
                                      : _checkOutGetxController
                                          .doneorder[index].deliverdAt!
                                          .substring(0, 10),
                                  items: _checkOutGetxController
                                      .doneorder[index].items!,
                                  orderCostForCustomer: _checkOutGetxController
                                      .doneorder[index].orderCostForCustomer!,
                                  branchLogoImage: _checkOutGetxController
                                      .doneorder[index].branch!.branchLogoImage,
                                  createDate: _checkOutGetxController
                                      .doneorder[index].createDate!
                                      .substring(0, 10),
                                  sequenceNumber: _checkOutGetxController
                                          .doneorder[index].sequenceNumber ??
                                      0,
                                );
                              },
                            )
                      : selected == 1
                          ? _offersScreenGetXController.offers.length == 0
                              ? Center(
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .no_product_found,
                                      style: TextStyle(
                                          color: ColorManager.primary,
                                          fontSize: FontSize.s16,
                                          fontWeight: FontWeight.w600)),
                                )
                              : ListView.builder(
                                  itemCount:
                                      _offersScreenGetXController.offers.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return NotificationsWidget(
                                      imageUrl: _offersScreenGetXController
                                          .offers[index]
                                          .branch!
                                          .branchLogoImage,
                                      storeName: _offersScreenGetXController
                                          .offers[index].branch!.storeName!,
                                      text:
                                          '${_offersScreenGetXController.offers[index].discountDescription}\n${_offersScreenGetXController.offers[index].redeemDescription}',
                                    );
                                  },
                                )
                          : selected == 0
                              ? _offersScreenGetXController.gifts.length == 0
                                  ? Center(
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .no_product_found,
                                          style: TextStyle(
                                              color: ColorManager.primary,
                                              fontSize: FontSize.s16,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  : ListView.builder(
                                      itemCount: _offersScreenGetXController
                                          .gifts.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return NotificationsWidget(
                                          imageUrl: _offersScreenGetXController
                                              .gifts[index]
                                              .branch!
                                              .branchLogoImage,
                                          storeName: _offersScreenGetXController
                                              .gifts[index].branch!.storeName!,
                                          text:
                                              '${_offersScreenGetXController.gifts[index].discountDescription}\n${_offersScreenGetXController.gifts[index].redeemDescription}',
                                        );
                                      },
                                    )
                              : Container()),
        ],
      ),
    );
  }
}
