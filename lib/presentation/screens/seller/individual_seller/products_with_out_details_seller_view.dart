import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/store_seller_view.dart';

import '../../../../app/preferences/shared_pref_controller.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../main_view.dart';

class ProductsWithOutDetailsSellerView extends StatefulWidget {
  const ProductsWithOutDetailsSellerView({Key? key}) : super(key: key);

  @override
  State<ProductsWithOutDetailsSellerView> createState() =>
      _ProductsWithOutDetailsSellerViewState();
}



class _ProductsWithOutDetailsSellerViewState
    extends State<ProductsWithOutDetailsSellerView> {
  bool _doubleBackToExitPressedOnce = false;


  var isShow = true;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSize.s50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StoreSellerView(),
                  ));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: AppSize.s35,
                      color: ColorManager.primary,
                    ),
                    SizedBox(
                      width: AppSize.s6,
                    ),
                  ],
                ),
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
                    Navigator.pushNamed(
                        context, Routes.createPaymentLinkSellerRoute);
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
                    Navigator.pushNamed(context, Routes.addItem2SellerRoute,
                        arguments: isShow);
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
                    AppLocalizations.of(context)!
                        .generate_detailed_payment_link,
                    style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> _onWillPop() async {
    if (_doubleBackToExitPressedOnce) {
      return true;
    }

    _doubleBackToExitPressedOnce = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Press back again to exit')),
    );

    Timer(Duration(seconds: 2), () {
      _doubleBackToExitPressedOnce = false;
    });

    return false;
  }
}
