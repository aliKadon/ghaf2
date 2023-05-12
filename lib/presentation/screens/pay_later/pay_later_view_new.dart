import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/presentation/screens/pay_later/pay_later_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/pay_later_producte_widget.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class PayLaterViewNew extends StatefulWidget {
  @override
  State<PayLaterViewNew> createState() => _PayLaterViewNewState();
}

class _PayLaterViewNewState extends State<PayLaterViewNew> {
  //controller
  late final PayLaterGetxController _payLaterGetxController =
      Get.put(PayLaterGetxController());
  var selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    _payLaterGetxController.getCustomerPayLaterProduct(context: context);
    super.initState();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _payLaterGetxController.payLaterProductActive = [];
  //   _payLaterGetxController.payLaterProductComplete = [];
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    List payLaterType = [
      AppLocalizations.of(context)!.active,
      AppLocalizations.of(context)!.complete
    ];
    return Scaffold(
      body: GetBuilder<PayLaterGetxController>(
        builder: (controller) => Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MainView(),
                    )),
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
                  AppLocalizations.of(context)!.pay_later,
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
            Divider(height: 1, color: ColorManager.greyLight),
            Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: double.infinity,
              color: ColorManager.greyLight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0, left: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.available_credit,
                      style: TextStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s20,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.aed} ${controller.totalCredit ?? 0}',
                      style: TextStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s24,
                          fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   '${AppLocalizations.of(context)!.total_limit} AED 0.00',
                    //   style: TextStyle(
                    //       color: ColorManager.primaryDark,
                    //       fontSize: FontSize.s20,
                    //       fontWeight: FontWeight.w500),
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.07,
              child: ListView.builder(
                shrinkWrap: true,
                itemExtent: MediaQuery.of(context).size.width * 0.5,
                itemCount: payLaterType.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = index;
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                        selected == index
                            ? Text(payLaterType[index],
                                style: TextStyle(
                                    fontSize: FontSize.s18,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.primaryDark))
                            : Text(payLaterType[index],
                                style: TextStyle(fontSize: FontSize.s14)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(
              thickness: 1,
              color: ColorManager.greyLight,
            ),
            GetBuilder<PayLaterGetxController>(
              builder: (controller) => Container(
                padding: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height * 0.5,
                child: controller.payLaterProducts == 0
                    ? Center(
                        child: Text(
                            AppLocalizations.of(context)!.no_order_found,
                            style: TextStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeight.w600)),
                      )
                    : selected == 0
                        ? controller.payLaterProductActive.length == 0
                            ? Center(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .no_product_found,
                                    style: TextStyle(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: FontSize.s16)),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    controller.payLaterProductActive.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, mainAxisExtent: AppSize.s311
                                    ),
                                itemBuilder: (context, index) {
                                  return PayLaterProductWidget(
                                    index: index,
                                    id: controller
                                        .payLaterProductActive[index].groupId!,
                                    stars: controller
                                        .payLaterProductActive[index].stars!,
                                    imageUrl: controller
                                                .payLaterProductActive[index]
                                                .images!
                                                .length ==
                                            0
                                        ? ''
                                        : controller
                                            .payLaterProductActive[index]
                                            .images![0],
                                    price: controller
                                        .payLaterProductActive[index].price!,
                                    name: controller
                                        .payLaterProductActive[index]
                                        .productName!,
                                  );
                                },
                              )
                        : controller.payLaterProductComplete.length == 0
                            ? Center(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .no_product_found,
                                    style: TextStyle(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: FontSize.s16)),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    controller.payLaterProductComplete.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, mainAxisExtent: AppSize.s311
                                    ),
                                itemBuilder: (context, index) {
                                  return PayLaterProductWidget(
                                    index: index,
                                    id: controller
                                        .payLaterProductComplete[index]
                                        .groupId!,
                                    stars: controller
                                        .payLaterProductComplete[index].stars!,
                                    imageUrl: controller
                                                .payLaterProductComplete[index]
                                                .images!
                                                .length ==
                                            0
                                        ? ''
                                        : controller
                                            .payLaterProductComplete[index]
                                            .images![0],
                                    price: controller
                                        .payLaterProductComplete[index].price!,
                                    name: controller
                                        .payLaterProductComplete[index]
                                        .productName!,
                                  );
                                },
                              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
