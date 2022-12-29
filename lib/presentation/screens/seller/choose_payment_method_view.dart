import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class ChoosePaymentMethodView extends StatelessWidget {
  const ChoosePaymentMethodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Column(
            children: [
              SizedBox(
                height: AppSize.s12,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.choose_payment_method,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s20),
                ),
              ),
              SizedBox(
                height: AppSize.s12,
              ),
              Expanded(
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: AppSize.s16,
                  mainAxisSpacing: AppSize.s16,
                  crossAxisCount: 3,
                  children: <Widget>[
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.mada),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.paypal),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.visa),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.google_pay),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.stcPay),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.amazonPay),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.applePay),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.cash),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.fawry),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.mastercard),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.americanExpress),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p4,
                            vertical: AppPadding.p12),
                        child: Image.asset(ImageAssets.bank),
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
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)!.save_payment_details,
                    style: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s18),
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
