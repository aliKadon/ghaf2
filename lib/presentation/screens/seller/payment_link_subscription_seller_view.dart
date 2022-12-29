import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class PaymentLinkSubscriptionSellerView extends StatelessWidget {
  const PaymentLinkSubscriptionSellerView({Key? key}) : super(key: key);

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
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!
                      .payment_link_solution_subscription,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s20),
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.join_us,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s20),
                ),
              ),
              Container(
                padding: EdgeInsets.all(AppPadding.p12),
                decoration: BoxDecoration(
                  color: ColorManager.primaryDark,
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: AppSize.s48,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          AppLocalizations.of(context)!.aed_50,
                          textAlign: TextAlign.center,
                          style: getMediumStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s65,
                    ),
                    Padding(
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
                                  color: ColorManager.white,
                                  fontSize: FontSize.s16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
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
                                  .payment_link_subscription2,
                              textAlign: TextAlign.start,
                              style: getMediumStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s16),
                            ),
                          ),
                        ],
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
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.subscribe_now,
                          style: getSemiBoldStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s22,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              TabPageSelectorIndicator(
                backgroundColor: ColorManager.primaryDark,
                borderColor: ColorManager.primaryDark,
                size: AppSize.s12,
              ),
              SizedBox(
                height: AppSize.s22,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .i_agree_to_the_terms_of_service,
                    style: getMediumStyle(
                        color: ColorManager.grey, fontSize: FontSize.s14),
                  ),
                ],
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
