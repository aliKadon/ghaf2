import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/subscribe_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/terms_use_view.dart';

import '../../resources/color_manager.dart';

class SubscribeViewFromHomePage extends StatefulWidget {
  String? last4DigitNumber;

  SubscribeViewFromHomePage({this.last4DigitNumber});

  @override
  State<SubscribeViewFromHomePage> createState() =>
      _SubscribeViewFromHomePageState();
}

class _SubscribeViewFromHomePageState extends State<SubscribeViewFromHomePage>
    with Helpers {
  // controller.
  SubscribeViewGetXController _subscribeViewGetXController =
      Get.find<SubscribeViewGetXController>();
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());

  @override
  void initState() {
    _subscribeViewGetXController.getSubscriptionPlan();
    _checkOutGetxController.getPaymentMethod(context: context);
    super.initState();
  }

  // dispose.
  @override
  void dispose() {
    Get.delete<SubscribeViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SubscribeViewGetXController>(
        builder: (controller) => controller.isLoadingSubscribePlan
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              ColorManager.primaryDark,
                              ColorManager.greyLight
                            ])),
                          ),
                          PositionedDirectional(
                            start: 0,
                            end: -200,
                            // top: 0,
                            bottom: 0,
                            child: Image.asset(
                              ImageAssets.subscribe,
                              height: AppSize.s154,
                            ),
                          ),
                          PositionedDirectional(
                            start: 0,
                            end: 200,
                            top: 0,
                            // bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) => MainView(),
                                      ));
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(ImageAssets.x,
                                              color: ColorManager.grey,
                                              fit: BoxFit.scaleDown,
                                              height: AppSize.s20),
                                        )),
                                  ),
                                  Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.ghaf,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: FontSize.s22)),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                            AppLocalizations.of(context)!.gold,
                                            style: TextStyle(
                                              color: ColorManager.primaryDark,
                                              fontSize: FontSize.s22,
                                            )),
                                      ),
                                    ],
                                  ),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .order_like_pro,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: FontSize.s22)),
                                  SizedBox(
                                    height: AppSize.s20,
                                  ),
                                  Container(
                                    width: AppSize.s258,
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .the_ultimate_shopping,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: FontSize.s18,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            AppLocalizations.of(context)!
                                .monthly_subscribe_text,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: FontSize.s18,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: AppSize.s35,
                          ),
                          Image.asset(
                            ImageAssets.subscribe1,
                            height: AppSize.s35,
                          ),
                          SizedBox(
                            width: AppSize.s35,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                                AppLocalizations.of(context)!
                                    .subscribe_benefits_1,
                                style: TextStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: AppSize.s35,
                          ),
                          Image.asset(
                            ImageAssets.subscribe2,
                            height: AppSize.s35,
                          ),
                          SizedBox(
                            width: AppSize.s35,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                                AppLocalizations.of(context)!
                                    .subscribe_benefits_2,
                                style: TextStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: AppSize.s35,
                          ),
                          Image.asset(
                            ImageAssets.subscribe3,
                            height: AppSize.s35,
                          ),
                          SizedBox(
                            width: AppSize.s35,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                                AppLocalizations.of(context)!
                                    .subscribe_benefits_3,
                                style: TextStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: AppSize.s35,
                          ),
                          Image.asset(
                            ImageAssets.subscribe4,
                            height: AppSize.s35,
                          ),
                          SizedBox(
                            width: AppSize.s35,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                                AppLocalizations.of(context)!
                                    .subscribe_benefits_4,
                                style: TextStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          thickness: 1,
                          color: ColorManager.greyLight,
                        ),
                      ),
                      Text(AppLocalizations.of(context)!.two_weeks_free_trail,
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppLocalizations.of(context)!.cancel_any_time,
                                style: TextStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeight.w500)),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TermsOfUseView(),
                                ));
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.terms_apply,
                                  style: TextStyle(
                                      color: ColorManager.primary,
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: AppSize.s82,
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        child: ElevatedButton(
                            onPressed: () {
                              showSubscribeSheet(
                                  context: context,
                                  subscriptionPlan: _subscribeViewGetXController
                                      .subscriptionPlan,
                                  last4DigitNumber: widget.last4DigitNumber,
                                  paymentMethod:
                                      _checkOutGetxController.paymentMethod[0],
                                  paymentMethodId:
                                      _checkOutGetxController.paymentMethod);
                            },
                            child:
                                Text(AppLocalizations.of(context)!.continue1)),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
