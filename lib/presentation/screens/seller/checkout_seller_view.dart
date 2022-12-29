import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class CheckoutSellerView extends StatelessWidget {
  const CheckoutSellerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Column(
            children: [
              SizedBox(
                height: AppSize.s12,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.checkout,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s20),
                ),
              ),
              SizedBox(
                height: AppSize.s92,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: AppPadding.p32),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.one_time_payment,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s18),
                    ),
                    Spacer(),
                    Text(
                      '316.55 AED',
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: AppPadding.p32),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.monthly_charge,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s18),
                    ),
                    Spacer(),
                    Text(
                      '316.55 AED',
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: AppPadding.p32),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.tax,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s18),
                    ),
                    Spacer(),
                    Text(
                      '316.55 AED',
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: AppPadding.p32),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.total,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s18),
                    ),
                    Spacer(),
                    Text(
                      '316.55 AED',
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s20),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)!.payment,
                    style: getSemiBoldStyle(
                        color:  ColorManager.white, fontSize: FontSize.s18),
                  ),
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
