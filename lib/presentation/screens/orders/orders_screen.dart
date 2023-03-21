import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/pre_order_widget.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/my_orders_widget.dart';

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
                  child: Image.asset(
                    IconsAssets.arrow,
                    height: AppSize.s18,
                    width: AppSize.s10,
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
                padding: EdgeInsets.only(right: 8, left: 8),
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
              padding: const EdgeInsets.all(3.0),
              child: Divider(thickness: 1, color: ColorManager.greyLight),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: controller.customerOrder == 0
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
                        return selected == 0
                            ? Column(
                                children: [
                                  MyOrdersWidget(
                                      date: controller
                                          .customerOrder[index].createDate!,
                                      price: (controller.customerOrder[index]
                                              .orderCostForCustomer)
                                          .toString(),
                                      orderSequence: (controller
                                              .customerOrder[index]
                                              .sequenceNumber)
                                          .toString()),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12.0, left: 12.0),
                                    child: Divider(
                                      thickness: 1,
                                      color: ColorManager.greyLight,
                                    ),
                                  )
                                ],
                              )
                            : selected == 1
                                ? PreOrderWidget()
                                : PreOrderWidget();
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
