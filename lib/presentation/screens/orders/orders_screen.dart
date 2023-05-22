import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/checkout/order_tracking_screen.dart';
import 'package:ghaf_application/presentation/screens/orders/pre_order_orders/pre_orde_orders.dart';
import 'package:ghaf_application/presentation/widgets/pre_order_widget.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/my_orders_widget.dart';
import '../../widgets/pre_order_widget_2.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());
  var selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getCustomerOrder(context: context);
    _checkOutGetxController.getScheduleOrder(context: context);
    _checkOutGetxController.getPreOrder(context: context);
    super.initState();
  }

  var a = 1;

  @override
  Widget build(BuildContext context) {
    List orderType = [
      AppLocalizations.of(context)!.my_orders,
      AppLocalizations.of(context)!.pre_order,
      AppLocalizations.of(context)!.scheduled_orders
    ];
    return Scaffold(
      body: GetBuilder<CheckOutGetxController>(
        builder: (controller) => Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: AppSize.s16,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // paidOrders = 0;
                      // unpaidOrders = 0;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.038,
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Image.asset(
                      SharedPrefController().lang1 == 'ar'
                          ? IconsAssets.arrow2
                          : IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  AppLocalizations.of(context)!.orders,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: AppSize.s12,
            ),
            Divider(thickness: 1, color: ColorManager.greyLight),
            SizedBox(
              height: AppSize.s10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(right: AppSize.s8, left: AppSize.s8),
                scrollDirection: Axis.horizontal,
                itemCount: orderType.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = index;
                      });
                    },
                    child: Row(
                      children: [
                        selected == index
                            ? Text(orderType[index],
                                style: TextStyle(
                                    fontSize: FontSize.s14,
                                    color: ColorManager.primaryDark,
                                    fontWeight: FontWeight.bold))
                            : Text(orderType[index],
                                style: TextStyle(fontSize: FontSize.s14)),
                        SizedBox(
                          width: AppSize.s60,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppSize.s3),
              child: Divider(thickness: 1, color: ColorManager.greyLight),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: selected == 0
                  ? controller.customerOrder.length == 0
                      ? Column(
                          children: [
                            SizedBox(
                              height: AppSize.s60,
                            ),
                            Image.asset(
                              ImageAssets.emptyBasket,
                              height: AppSize.s258,
                            ),
                            SizedBox(
                              height: AppSize.s30,
                            ),
                            Text(
                              AppLocalizations.of(context)!.no_order_found,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.s20,
                                  color: ColorManager.primaryDark),
                            ),
                            Text(
                              AppLocalizations.of(context)!.order_placed,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize.s16,
                                  color: ColorManager.greyLight),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.customerOrder.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrderTrackingScreen(
                                      orderId:
                                          controller.customerOrder[index].id!,
                                      source: controller.customerOrder[index]
                                                  .deliveryPoint ==
                                              null
                                          ? controller.customerOrder[index]
                                              .branch!.branchAddress!
                                          : controller.customerOrder[index]
                                              .deliveryPoint!,
                                      destination: controller
                                          .customerOrder[index]
                                          .branch!
                                          .branchAddress!),
                                ));
                              },
                              child: Column(
                                children: [
                                  MyOrdersWidget(
                                      image: controller.customerOrder[index]
                                          .branch!.branchLogoImage!,
                                      statusName: controller
                                          .customerOrder[index].statusName!,
                                      date: controller
                                          .customerOrder[index].createDate!,
                                      price: (controller.customerOrder[index]
                                              .orderCostForCustomer)
                                          .toString(),
                                      orderSequence: (controller
                                              .customerOrder[index]
                                              .sequenceNumber)
                                          .toString(),
                                      branchName: controller
                                          .customerOrder[index]
                                          .branch!
                                          .storeName!,
                                      branchAddress: controller
                                              .customerOrder[index]
                                              .branch!
                                              .branchAddress ??
                                          null),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: AppSize.s12, left: AppSize.s12),
                                    child: Divider(
                                      thickness: 1,
                                      color: ColorManager.greyLight,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                  : selected == 1
                      // ? PreOrderWidget(storeName: 'Albike',)
                      ? _checkOutGetxController.storeNamePreOrder.length == 0
                          ? Column(
                              children: [
                                SizedBox(
                                  height: AppSize.s60,
                                ),
                                Image.asset(
                                  ImageAssets.emptyBasket,
                                  height: AppSize.s258,
                                ),
                                SizedBox(
                                  height: AppSize.s30,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.no_order_found,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize.s20,
                                      color: ColorManager.primaryDark),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.order_placed,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: FontSize.s16,
                                      color: ColorManager.greyLight),
                                ),
                              ],
                            )
                          : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: _checkOutGetxController
                                  .storeNamePreOrder.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => PreOrderOrders(
                                          branchName: _checkOutGetxController
                                              .storeNamePreOrder[index]),
                                    ));
                                  },
                                  child: PreOrderWidget(
                                    image: _checkOutGetxController
                                        .imageNamePreOrder[index]['image'],
                                    storeName: _checkOutGetxController
                                        .storeNamePreOrder[index],
                                  ),
                                );
                              },
                            )
                      : selected == 2
                          ? _checkOutGetxController.storeName.length == 0
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: AppSize.s60,
                                    ),
                                    Image.asset(
                                      ImageAssets.emptyBasket,
                                      height: AppSize.s258,
                                    ),
                                    SizedBox(
                                      height: AppSize.s30,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .no_order_found,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.s20,
                                          color: ColorManager.primaryDark),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .order_placed,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: FontSize.s16,
                                          color: ColorManager.greyLight),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount:
                                      _checkOutGetxController.storeName.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return PreOrderWidget2(
                                      image: _checkOutGetxController
                                          .imageName[index]['image'],
                                      storeName: _checkOutGetxController
                                          .storeName[index],
                                    );
                                  },
                                )
                          : Container(),
            )
          ],
        ),
      ),
    );
  }
}
