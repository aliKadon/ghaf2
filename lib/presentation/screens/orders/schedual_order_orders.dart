import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/checkout/order_tracking-schedual_screen.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../checkout/order_tracking_screen.dart';

class SchedualOrderOrders extends StatefulWidget {
  String branchName;

  SchedualOrderOrders({required this.branchName});

  @override
  State<SchedualOrderOrders> createState() => _SchedualOrderOrdersState();
}

class _SchedualOrderOrdersState extends State<SchedualOrderOrders> {
  final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getSchedualOrder1(
        context: context, store: widget.branchName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CheckOutGetxController>(
        builder: (controller) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Padding(
                padding:  EdgeInsets.only(left: AppSize.s12, right: AppSize.s12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.038,
                        width: MediaQuery.of(context).size.width * 0.08,
                        child: Image.asset(
                          SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                          height: AppSize.s18,
                          width: AppSize.s10,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.scheduled_orders,
                      style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Divider(
                color: ColorManager.greyLight,
                thickness: 1,
              ),
              Container(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.scheduleOrders1.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              OrderTrackingSchedualScreen(
                                  orderId: _checkOutGetxController.scheduleOrders1[index].id!,
                                  source: _checkOutGetxController.scheduleOrders1[index].deliveryPoint!,
                                  destination: _checkOutGetxController.scheduleOrders1[index].branch!.branchAddress!),));
                      },
                      child: Padding(
                        padding:  EdgeInsets.all(AppSize.s20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${_checkOutGetxController.scheduleOrders1[index].mealType}',

                                  style: TextStyle(
                                      color: ColorManager.primaryDark,
                                      fontSize: FontSize.s18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(height: AppSize.s12),
                            Row(
                              children: [
                                Icon(Icons.home, color: ColorManager.primaryDark),
                                SizedBox(
                                  width: AppSize.s16,
                                ),
                                Text(
                                  '${_checkOutGetxController.scheduleOrders1[index].branch!.branchAddress!.addressName}',

                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: FontSize.s16,
                                      color: ColorManager.primaryDark),
                                )
                              ],
                            ),
                            SizedBox(height: AppSize.s4),
                            Divider(
                              thickness: 1,
                              color: ColorManager.greyLight,
                            ),
                            SizedBox(height: AppSize.s4),
                            Row(
                              children: [
                                Icon(Icons.timer,
                                    color: ColorManager.primaryDark),
                                SizedBox(width: AppSize.s16),
                                Text(
                                  '${_checkOutGetxController.scheduleOrders1[index].hourNumber}',

                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: FontSize.s16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: AppSize.s4),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
