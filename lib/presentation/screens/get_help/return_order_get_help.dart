import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/get_help/controller/help_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/get_help/report_another_issue_screen.dart';
import 'package:ghaf_application/presentation/screens/get_help/report_delayed_screen.dart';
import 'package:ghaf_application/presentation/screens/get_help/report_issue_with_order_Screen.dart';
import 'package:ghaf_application/presentation/screens/get_help/return_order_item_details_get_help.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ReturnOrderGetHelp extends StatefulWidget {
  final String getHelpType;

  ReturnOrderGetHelp({required this.getHelpType});

  @override
  State<ReturnOrderGetHelp> createState() => _ReturnOrderGetHelpState();
}

class _ReturnOrderGetHelpState extends State<ReturnOrderGetHelp> {
  //controller
  late final HelpGetxController _helpGetxController =
      Get.put(HelpGetxController());

  @override
  void initState() {
    // TODO: implement initState
    _helpGetxController.getItemsToReturn(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(AppSize.s12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          SharedPrefController().lang1 == 'ar'
                              ? IconsAssets.arrow2
                              : IconsAssets.arrow,
                          height: AppSize.s18,
                          width: AppSize.s10,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.get_help,
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
              SizedBox(
                height: AppSize.s14,
              ),
              Text(
                widget.getHelpType,
                style: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.primaryDark),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                AppLocalizations.of(context)!.tap_an_item_you_need_help_with,
                style: TextStyle(fontSize: FontSize.s16),
              ),
              SizedBox(
                height: AppSize.s14,
              ),
              Container(
                height: AppSize.s50,
                width: MediaQuery.of(context).size.width * 1,
                child: TextField(
                  textInputAction: TextInputAction.search,
                  textAlign: TextAlign.start,
                  style: getMediumStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
                      child: Image.asset(
                        IconsAssets.search,
                        width: AppSize.s16,
                        height: AppSize.s16,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p16, vertical: AppPadding.p16),
                    hintText: AppLocalizations.of(context)!.search_your_item,
                    hintStyle: getMediumStyle(
                      color: ColorManager.hintTextFiled,
                    ),
                  ),
                  onChanged: (value) {
                    _helpGetxController.getItemsToReturn(
                        context: context, productName: value);
                  },
                ),
              ),
              GetBuilder<HelpGetxController>(
                builder: (controller) => Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: controller.itemsToReturn.length == 0
                      ? Center(
                          child: Text(
                              AppLocalizations.of(context)!.no_product_found,
                              style: TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s16,
                                  fontWeight: FontWeight.w600)),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.itemsToReturn.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (widget.getHelpType ==
                                    AppLocalizations.of(context)!
                                        .return_an_item_you_ordered) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ReturnOrderItemDetailsGetHelp(
                                            orderId:
                                                controller.itemsToReturn[index]
                                                    .orderId,
                                            productId:
                                                controller.itemsToReturn[index]
                                                    .productId,
                                            name: controller
                                                .itemsToReturn[index]
                                                .product
                                                ?.name,
                                            imageUrl: controller
                                                            .itemsToReturn[
                                                                index]
                                                            .product
                                                            ?.productImages
                                                            ?.length ==
                                                        0 ||
                                                    controller
                                                            .itemsToReturn[
                                                                index]
                                                            .product
                                                            ?.productImages ==
                                                        null
                                                ? null
                                                : controller
                                                    .itemsToReturn[index]
                                                    .product
                                                    ?.productImages?[0]),
                                  ));
                                }
                                if (widget.getHelpType ==
                                    AppLocalizations.of(context)!
                                        .report_issues_with_your_order) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ReportIssueWithOrderScreen(
                                            orderId: controller
                                                .itemsToReturn[index].orderId,
                                            name: controller
                                                .itemsToReturn[index]
                                                .product
                                                ?.name,
                                            imageUrl: controller
                                                            .itemsToReturn[
                                                                index]
                                                            .product
                                                            ?.productImages
                                                            ?.length ==
                                                        0 ||
                                                    controller
                                                            .itemsToReturn[
                                                                index]
                                                            .product
                                                            ?.productImages ==
                                                        null
                                                ? null
                                                : controller
                                                    .itemsToReturn[index]
                                                    .product
                                                    ?.productImages?[0]),
                                  ));
                                }
                                if (widget.getHelpType ==
                                    AppLocalizations.of(context)!
                                        .report_delayed_delivery) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ReportDelayedScreen(
                                        orderId: controller
                                            .itemsToReturn[index].orderId,
                                        imageUrl: controller
                                                        .itemsToReturn[index]
                                                        .product
                                                        ?.productImages
                                                        ?.length ==
                                                    0 ||
                                                controller
                                                        .itemsToReturn[index]
                                                        .product
                                                        ?.productImages ==
                                                    null
                                            ? null
                                            : controller.itemsToReturn[index]
                                                .product?.productImages?[0],
                                        name: controller.itemsToReturn[index]
                                            .product?.name),
                                  ));
                                }
                                if (widget.getHelpType ==
                                    AppLocalizations.of(context)!
                                        .report_other_issues) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ReportAnotherIssueScreen(
                                      imageUrl: controller
                                                      .itemsToReturn[index]
                                                      .product
                                                      ?.productImages
                                                      ?.length ==
                                                  0 ||
                                              controller.itemsToReturn[index]
                                                      .product?.productImages ==
                                                  null
                                          ? null
                                          : controller.itemsToReturn[index]
                                              .product?.productImages?[0],
                                      name: controller
                                          .itemsToReturn[index].product?.name,
                                      orderId: controller
                                          .itemsToReturn[index].orderId,
                                    ),
                                  ));
                                }
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      controller.itemsToReturn[index].product
                                                      ?.productImages ==
                                                  null ||
                                              controller
                                                      .itemsToReturn[index]
                                                      .product
                                                      ?.productImages
                                                      ?.length ==
                                                  0
                                          ? Container(
                                              height: AppSize.s110,
                                              width: AppSize.s110,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppSize.s20),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          ImageAssets.logo2))),
                                            )
                                          : Container(
                                        height: AppSize.s110,
                                              width: AppSize.s110,
                                              child: Image.network(
                                                controller.itemsToReturn[index]
                                                    .product!.productImages![0],
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Image.asset(
                                                      ImageAssets.logo2);
                                                },
                                              ),
                                          ),
                                      // Container(
                                      //         height: AppSize.s110,
                                      //         width: AppSize.s110,
                                      //         decoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(AppSize.s20),
                                      //             image: DecorationImage(
                                      //                 image: NetworkImage(
                                      //                     controller
                                      //                             .itemsToReturn[
                                      //                                 index]
                                      //                             .product!
                                      //                             .productImages![
                                      //                         0]))),
                                      //       ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${_helpGetxController.itemsToReturn[index].product?.name}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: FontSize.s14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: AppSize.s30,
                                          ),
                                          Text(
                                            '${(_helpGetxController.itemsToReturn[index].product!.addedAt!)}'
                                                .substring(0, 10),
                                            style: TextStyle(
                                              color: ColorManager.greyLight,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        SharedPrefController().lang1 == 'ar'
                                            ? IconsAssets.arrow
                                            : IconsAssets.arrow2,
                                        height: AppSize.s18,
                                        color: ColorManager.primary,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppSize.s18,
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
        ),
      ),
    );
  }
}
