import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';

class ProductsWithOutDetailsSellerView extends StatefulWidget {
  const ProductsWithOutDetailsSellerView({Key? key}) : super(key: key);

  @override
  State<ProductsWithOutDetailsSellerView> createState() => _ProductsWithOutDetailsSellerViewState();
}

class _ProductsWithOutDetailsSellerViewState extends State<ProductsWithOutDetailsSellerView> {
  var isShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppSize.s15,
            ),
            Image.asset(
              ImageAssets.logo2,
              fit: BoxFit.fill,
              height: AppSize.s206,
              width: AppSize.s206,
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
                onPressed: () {
                  Navigator.pushNamed(context, Routes.createPaymentLinkSellerRoute);
                },
                child: Text(
                  AppLocalizations.of(context)!.generate_payment_link,
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
                onPressed: () {

                  Navigator.pushNamed(context, Routes.addItem2SellerRoute,arguments: isShow);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.transparent,
                  elevation: 0,
                  side: BorderSide(
                    color: ColorManager.primaryDark,
                    width: AppSize.s1,
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.generate_detailed_payment_link,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
