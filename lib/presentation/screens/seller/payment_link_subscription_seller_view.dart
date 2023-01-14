import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';

class PaymentLinkSubscriptionSellerView extends StatefulWidget {
  const PaymentLinkSubscriptionSellerView({Key? key}) : super(key: key);

  @override
  State<PaymentLinkSubscriptionSellerView> createState() =>
      _PaymentLinkSubscriptionSellerViewState();
}

class _PaymentLinkSubscriptionSellerViewState
    extends State<PaymentLinkSubscriptionSellerView> {
  var option = '';
  var planId = '';
  var isLoading = true;

  // @override
  // void initState() {
  //   Provider.of<SellerProvider>(context,listen: false).getPlanForSellerIndividual().then((value) => isLoading = false);
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    Provider.of<SellerProvider>(context)
        .getPlanForSellerIndividual()
        .then((value) => isLoading = false);
    super.didChangeDependencies();
  }

  late var plane = Provider.of<SellerProvider>(context).planSellerIndividual;

  @override
  Widget build(BuildContext context) {
    // var repo = Provider.of<SellerProvider>(context).repo;
    bool monthly = true;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: ListView(
            children: [
              SizedBox(
                height: AppSize.s28,
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
                      color: ColorManager.primaryDark, fontSize: 30),
                ),
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              Container(
                height: 450,
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
                      height: AppSize.s15,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        isLoading
                            ? Container()
                            : isLoading == false && monthly
                                ? Text(
                                    '${plane[0].priceAmount} ${AppLocalizations.of(context)!.aed}',
                                    textAlign: TextAlign.center,
                                    style: getMediumStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s20),
                                  )
                                : Text(
                                    '${plane[1].priceAmount} ${AppLocalizations.of(context)!.aed}',
                                    textAlign: TextAlign.center,
                                    style: getMediumStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s20),
                                  ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s48,
                    ),
                    isLoading
                        ? Center(
                            child: Container(
                              width: 20.h,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          )
                        : Padding(
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
                                    '${AppLocalizations.of(context)!.monthly_plane} ${plane[0].priceAmount} ${plane[0].priceCurrency} ${AppLocalizations.of(context)!.every_month}'
                                    '${AppLocalizations.of(context)!.and_have} ${plane[0].freeDays} ${AppLocalizations.of(context)!.free_days}',
                                    textAlign: TextAlign.start,
                                    style: getMediumStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    isLoading
                        ? Center(
                            child: Container(
                              width: 20.h,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          )
                        : Padding(
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
                                    '${AppLocalizations.of(context)!.annual_plane} ${plane[1].priceAmount} ${plane[1].priceCurrency} ${AppLocalizations.of(context)!.every_month}'
                                    '${AppLocalizations.of(context)!.and_have} ${plane[1].freeDays} ${AppLocalizations.of(context)!.free_days}',
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
                      height: AppSize.s65,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: AppPadding.p8),
                      // child: Row(
                      //   children: [
                      // CircleAvatar(
                      //   radius: AppRadius.r8,
                      //   backgroundColor: ColorManager.primary,
                      // ),
                      // SizedBox(
                      //   width: AppSize.s12,
                      // ),
                      child: Row(
                        children: [
                          GestureDetector(
                            // onTap: () => Navigator.pop(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                    activeColor: ColorManager.primary,
                                    value: 'Monthly',
                                    onChanged: (n) {
                                      setState(() {
                                        monthly = true;
                                        // Agree = !Agree;
                                        planId = plane[0].id;
                                        option = n!;
                                      });
                                      print(
                                          '--------------------------------monthly');
                                      print(option);
                                    },
                                    groupValue: option),
                                Text(
                                  AppLocalizations.of(context)!.monthly,
                                  style: getRegularStyle(
                                      color: ColorManager.grey,
                                      fontSize: FontSize.s16),
                                ),
                              ],
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: GestureDetector(
                              // onTap: () => Navigator.pop(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio(
                                      activeColor: ColorManager.primary,
                                      value: 'Annual',
                                      onChanged: (n) {
                                        setState(() {
                                          monthly = false;
                                          // Agree = !Agree;
                                          planId = plane[1].id;
                                          option = n!;
                                        });
                                        print(
                                            '--------------------------------annual');
                                        print(option);
                                      },
                                      groupValue: option),
                                  Text(
                                    AppLocalizations.of(context)!.annual,
                                    style: getRegularStyle(
                                        color: ColorManager.grey,
                                        fontSize: FontSize.s16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Expanded(
                      //   child: Text(
                      //     AppLocalizations.of(context)!
                      //         .payment_link_subscription1,
                      //     textAlign: TextAlign.start,
                      //     style: getMediumStyle(
                      //         color: ColorManager.white,
                      //         fontSize: FontSize.s16),
                      //   ),
                      // ),
                      //   ],
                      // ),
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
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              Routes.addPaymentCardSelleRoute,
                              arguments: planId);
                        },
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
