import 'package:flutter/material.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math; // import this

class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.payment_method,
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
                SizedBox(
                  height: AppSize.s15,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.payment_method,
                      style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    Spacer(),
                    Image.asset(
                      IconsAssets.plus2,
                      height: AppSize.s22,
                      width: AppSize.s22,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSize.s15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                    border:
                        Border.all(width: AppSize.s1, color: ColorManager.grey),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p18,
                      vertical: AppPadding.p12,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          ImageAssets.test,
                          height: AppSize.s50,
                          width: AppSize.s50,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: AppSize.s18,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '**** **** **** 1234',
                                style: getMediumStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                              Text(
                                'expir 2-2023',
                                style: getRegularStyle(
                                  color: ColorManager.grey,
                                  fontSize: FontSize.s12,
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: AppSize.s10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s40,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s55,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, Routes.registerRoute),
                    child: Text(
                      AppLocalizations.of(context)!.done,
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding aboutApp(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Row(
        children: [
          Text(
            title,
            style: getRegularStyle(
              color: ColorManager.grey,
              fontSize: FontSize.s16,
            ),
          ),
          Spacer(),
          Transform(
            transform: Matrix4.rotationY(math.pi),
            child: Image.asset(
              IconsAssets.arrow,
              height: AppSize.s18,
              width: AppSize.s10,
            ),
          ),
        ],
      ),
    );
  }
}
