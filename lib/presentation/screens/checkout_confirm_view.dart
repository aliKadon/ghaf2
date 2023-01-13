import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class CheckOutConfirmView extends StatefulWidget {
  // const CheckOutConfirmView({Key? key}) : super(key: key);

  final String orderId;

  CheckOutConfirmView(this.orderId);

  @override
  State<CheckOutConfirmView> createState() => _CheckOutConfirmViewState();
}

class _CheckOutConfirmViewState extends State<CheckOutConfirmView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    Text(
                      AppLocalizations.of(context)!.checkout,
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
                  height: AppSize.s65,
                ),
                Image.asset(
                  ImageAssets.checkout,
                  height: AppSize.s263,
                  width: AppSize.s222,
                ),
                Text(
                  AppLocalizations.of(context)!.order_success,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s20,
                  ),
                ),
                SizedBox(
                  height: AppSize.s18,
                ),
                Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(context)!.payment_has_been_made,
                  style: getSemiBoldStyle(
                    color: ColorManager.grey,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(
                  height: AppSize.s35,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s55,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (builder) => OrderTrackingScreen(widget.orderinfo)),
                      // );
                      print('=================================checkout confirm orderInfo');
                      print(widget.orderId);
                      Navigator.of(context).pushNamed(
                          Routes.orderTrackingScreen,
                          arguments: widget.orderId);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.order_tracking,
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s22,
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(Routes.mainRoute),
                  child: Text(
                    AppLocalizations.of(context)!.back_to_home,
                    style: getSemiBoldStyle(
                      color: ColorManager.grey,
                      fontSize: FontSize.s20,
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

  void _customDialogProgress() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s214,
              width: AppSize.s258,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Text(
                      AppLocalizations.of(context)!.rewarding_progress,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s20),
                    ),
                    SizedBox(
                      height: AppSize.s40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p12,
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        AppLocalizations.of(context)!
                            .you_have_completed_10_orders,
                        style: getMediumStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s12),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s24,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName(Routes.mainRoute));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p55,
                          vertical: AppPadding.p8,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryDark,
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.close,
                          style: getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s18,
                    ),
                  ]),
            ),
          );
        });
  }
}
