import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../domain/model/product.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../widgets/my_orders_widget.dart';
import '../../../widgets/product_item_new.dart';
import '../../checkout/check_out_getx_controller.dart';
import '../../checkout/order_tracking_screen.dart';
import '../../home_view/home_view_getx_controller.dart';


class PreOrderOrders extends StatefulWidget {

  final String branchName;
  PreOrderOrders({required this.branchName});

  @override
  State<PreOrderOrders> createState() => _PreOrderOrdersState();
}

class _PreOrderOrdersState extends State<PreOrderOrders> {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
  Get.put(CheckOutGetxController());

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getPreOrder(context: context,branchName: widget.branchName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CheckOutGetxController>(
        builder: (controller) =>  controller.preOrders.isEmpty
            ? Center(
          child: Text(AppLocalizations.of(context)!.no_product_found,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: FontSize.s18,
                  color: ColorManager.primary)),
        )
            : Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.06),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
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
                    AppLocalizations.of(context)!.pre_order,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.01),
            Divider(
              color: ColorManager.greyLight,
              thickness: 1,
            ),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.preOrders.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => OrderTrackingScreen(
                    //       orderId:
                    //       controller.preOrders[index].id!,
                    //       source: controller
                    //           .preOrders[index].deliveryPoint!,
                    //       destination: controller
                    //           .preOrders[index]
                    //           .branch!
                    //           .branchAddress!),
                    // ));
                  },
                  child: Column(
                    children: [
                      MyOrdersWidget(
                          image: controller.preOrders[index].branch!.branchLogoImage!,
                          statusName: controller
                              .preOrders[index].statusName!,
                          date: controller
                              .preOrders[index].createDate!,
                          price: (controller.preOrders[index]
                              .orderCostForCustomer)
                              .toString(),
                          orderSequence: (controller
                              .preOrders[index]
                              .sequenceNumber)
                              .toString(),
                          branchName: controller
                              .preOrders[index]
                              .branch!
                              .storeName!,
                          branchAddress: controller
                              .preOrders[index]
                              .branch!
                              .branchAddress ??
                              null),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 12.0, left: 12.0),
                        child: Divider(
                          thickness: 1,
                          color: ColorManager.greyLight,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.08,
            //   padding: EdgeInsets.all(5),
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     child: Row(
            //       children: [
            //         Text('30 AED'),
            //         Spacer(),
            //         Icon(Icons.shopping_bag_outlined),
            //         Text(AppLocalizations.of(context)!.add_to_cart)
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}