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
    _payLaterGetxController.getCustomerInstallments(context: context);
    super.initState();
  }

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
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
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
                child: controller.payLater == 0
                    ? Center(
                        child: Text(
                            AppLocalizations.of(context)!.no_order_found,
                            style: TextStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeight.w600)),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.payLater.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 300),
                        itemBuilder: (context, index) {
                          return PayLaterProductWidget(
                            index: index,
                            stars: controller.payLater[index]
                                .productForThisOperation!.stars!,
                            imageUrl: controller
                                        .payLater[index]
                                        .productForThisOperation!
                                        .productImages!
                                        .length ==
                                    0
                                ? ''
                                : controller.payLater[index]
                                    .productForThisOperation!.productImages![0],
                            price: controller.payLater[index]
                                .productForThisOperation!.price!,
                            name: controller
                                .payLater[index].productForThisOperation!.name!,
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
