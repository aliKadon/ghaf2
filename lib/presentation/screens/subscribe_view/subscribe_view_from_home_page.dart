import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/subscribe_view_getx_controller.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class SubscribeViewFromHomePage extends StatefulWidget {
  const SubscribeViewFromHomePage({Key? key}) : super(key: key);

  @override
  State<SubscribeViewFromHomePage> createState() => _SubscribeViewFromHomePageState();
}

class _SubscribeViewFromHomePageState extends State<SubscribeViewFromHomePage> {
  // controller.
  SubscribeViewGetXController _subscribeViewGetXController =
  Get.find<SubscribeViewGetXController>();

  // dispose.
  @override
  void dispose() {
    Get.delete<SubscribeViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: ListView(
            children: [
              SizedBox(
                height: AppSize.s12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.subscribe,
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark, fontSize: FontSize.s20),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              Container(
                padding: EdgeInsets.all(AppPadding.p12),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                  boxShadow: kElevationToShadow[4],
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: AppSize.s40,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          IconsAssets.start1,
                          width: AppSize.s32,
                          height: AppSize.s32,
                        ),
                        SizedBox(
                          width: AppSize.s8,
                        ),
                        Text(
                          AppLocalizations.of(context)!.ghaf_gold,
                          textAlign: TextAlign.center,
                          style: getMediumStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s20),
                        ),
                        Spacer(),
                        Text(
                          AppLocalizations.of(context)!.aed_50,
                          textAlign: TextAlign.center,
                          style: getMediumStyle(
                              color: ColorManager.grey, fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s65,
                    ),
                    ...List.generate(
                      3,
                          (index) => Padding(
                        padding: EdgeInsets.only(bottom: AppPadding.p8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: AppRadius.r8,
                              backgroundColor: ColorManager.primary,
                            ),
                            SizedBox(
                              width: AppSize.s12,
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .payment_link_subscription1,
                                textAlign: TextAlign.start,
                                style: getMediumStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s22,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: AppMargin.m50,
                      ),
                      width: double.infinity,
                      height: AppSize.s55,
                      child: ElevatedButton(
                        onPressed: AppSharedData.currentUser!.ghafGold ?? false
                            ? _subscribeViewGetXController.cancelSubscription
                            : _subscribeViewGetXController
                            .subscribeAsGhafGolden,
                        child: Text(
                          AppSharedData.currentUser!.ghafGold ?? false
                              ? 'Un Subscribe'
                              : AppLocalizations.of(context)!.subscribe_now,
                          style: getSemiBoldStyle(
                            color: ColorManager.white,
                            fontSize: FontSize.s18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s16,
                    ),
                    if (!AppSharedData.currentUser!.active!)
                      Row(
                        children: [
                          Spacer(),
                          InkWell(
                            onTap: _subscribeViewGetXController.subscribeAsFree,
                            child: Text(
                              AppLocalizations.of(context)!.skip,
                              style: getMediumStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    SizedBox(
                      height: AppSize.s22,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s92,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
