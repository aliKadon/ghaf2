import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyWalletView extends StatefulWidget {
  const MyWalletView({Key? key}) : super(key: key);

  @override
  State<MyWalletView> createState() => _MyWalletViewState();
}

class _MyWalletViewState extends State<MyWalletView> {


  var isLoading = true;

  @override
  void initState() {
    Provider.of<ProductProvider>(context,listen: false).getAllDetailsOrder().then((value) => isLoading = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<ProductProvider>(context).allPointsWallet;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        product = 0;
                      });
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.my_wallet,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p32),
                child: Stack(
                  children: [
                    Image.asset(
                      ImageAssets.wallet,
                      height: AppSize.s146,
                      width: AppSize.s315,
                      fit: BoxFit.fill,
                    ),
                    PositionedDirectional(
                      top: AppSize.s30,
                      start: AppSize.s30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.balance,
                            style: getMediumStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s16),
                          ),
                          isLoading ? Center(
                            child: Container(
                              width: 20.h,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          ) : Text(
                            product.toString(),
                            style: getBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s15,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () {},

                  style: ElevatedButton.styleFrom(
                      textStyle: getMediumStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                      backgroundColor: ColorManager.primaryDark,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r8))),
                  child: Text(
                    // AppLocalizations.of(context)!.add_balance,
                    'Your Balance',
                    style: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s18),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s27,
              ),
              // Text(
              //   AppLocalizations.of(context)!.recent_transactions,
              //   style: getSemiBoldStyle(
              //     color: ColorManager.primaryDark,
              //     fontSize: FontSize.s18,
              //   ),
              // ),
              // SizedBox(
              //   height: AppSize.s16,
              // ),
              // RecentTransactions(),
              // RecentTransactions(),
              // RecentTransactions(),
              // RecentTransactions(),
              SizedBox(
                height: AppSize.s18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
