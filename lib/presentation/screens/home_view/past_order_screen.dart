import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/my_orders_widget.dart';
import '../../widgets/product_item_new.dart';
import '../checkout/check_out_getx_controller.dart';
import '../checkout/order_tracking_screen.dart';

class PastOrderScreen extends StatefulWidget {

  @override
  State<PastOrderScreen> createState() => _PastOrderScreenState();
}

class _PastOrderScreenState extends State<PastOrderScreen> {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
  Get.put(CheckOutGetxController());

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getCustomerOrder(context: context);
    super.initState();
  }

  var selected = 0;

  @override
  Widget build(BuildContext context) {
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
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.038,
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                AppLocalizations.of(context)!.past_order,
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

          GetBuilder<CheckOutGetxController>(
            builder: (controller) => controller.customerOrder.length == 0
                ? Center(
              child: Text(
                  AppLocalizations.of(context)!.no_product_found,
                  style: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.s18)),
            )
                : Container(
              height: MediaQuery.of(context).size.height * 0.84,
                  child: ListView.builder(
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
                                .deliveryPoint ?? controller
                                .customerOrder[index]
                                .branch!
                                .branchAddress!,
                            destination: controller
                                .customerOrder[index]
                                .branch!
                                .branchAddress!),
                      ));
                    },
                    child: Column(
                      children: [
                        MyOrdersWidget(
                            statusName: controller.customerOrder[index].statusName!,
                            image: controller.customerOrder[index].branch!.branchLogoImage!,
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
                ),
          )

        ],
      ),
    );
  }
}