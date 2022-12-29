import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class ProductsWithOutDetailsSellerView extends StatelessWidget {
  const ProductsWithOutDetailsSellerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageAssets.logo2,
            fit: BoxFit.fill,
            height: AppSize.s206,
            width: AppSize.s184,
          ),
          SizedBox(
            height: AppSize.s148,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppMargin.m16,
            ),
            width: double.infinity,
            height: AppSize.s55,
            child: ElevatedButton(
              onPressed: () =>Navigator.pushNamed(context, Routes.createPaymentLinkSellerRoute),
              child: Text(
                AppLocalizations.of(context)!.products_with_details,
                style: getSemiBoldStyle(
                    color: ColorManager.white, fontSize: FontSize.s18),
              ),
            ),
          ),
          SizedBox(
            height: AppSize.s26,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppMargin.m16,
            ),
            width: double.infinity,
            height: AppSize.s55,
            child: ElevatedButton(
              onPressed: () =>Navigator.pushNamed(context, Routes.loginRoute),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.transparent,
                elevation: 0,
                side: BorderSide(
                  color: ColorManager.primaryDark,
                  width: AppSize.s1,
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.products_without_details,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
