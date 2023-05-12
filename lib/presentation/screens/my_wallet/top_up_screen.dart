import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/checkout/snapsheet_screen.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/edit_payment_method_screen.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/enter_amount.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/transaction.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/wallet_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/pay_later/pay_later_product_view.dart';
import 'package:ghaf_application/presentation/widgets/top_up_widget.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class TopUpScreen extends StatefulWidget {
  String? screenName;

  TopUpScreen({this.screenName});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  //controller
  late final WalletGetxController _walletGetxController =
      Get.find<WalletGetxController>();
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getPaymentMethod(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CheckOutGetxController>(
        builder: (controller) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: AppSize.s32,
              ),
              widget.screenName == 'topUp'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(AppSize.s6),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => TransactionScreen(),
                              ));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.038,
                              width: MediaQuery.of(context).size.width * 0.08,
                              child: Image.asset(
                                IconsAssets.arrow,
                                height: AppSize.s18,
                                width: AppSize.s10,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          AppLocalizations.of(context)!.top_up,
                          style: getSemiBoldStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        Spacer(),
                      ],
                    )
                  : widget.screenName == 'payLater'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(AppSize.s6),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => PayLaterProductView(
                                        index: SharedPrefController()
                                            .indexOfPayLaterProduct),
                                  ));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.038,
                                  width: MediaQuery.of(context).size.width * 0.08,
                                  child: Image.asset(
                                    IconsAssets.arrow,
                                    height: AppSize.s18,
                                    width: AppSize.s10,
                                    color: ColorManager.primaryDark,
                                  ),
                                ),
                              ),
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
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(AppSize.s6),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => TransactionScreen(),
                                  ));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.038,
                                  width:  MediaQuery.of(context).size.width * 0.08,
                                  child: Image.asset(
                                    IconsAssets.arrow,
                                    height: AppSize.s18,
                                    width: AppSize.s10,
                                    color: ColorManager.primaryDark,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              AppLocalizations.of(context)!.manage_payment,
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s18,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditPaymentMethodScreen(),
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, right: 14.0),
                                child: Text(
                                  AppLocalizations.of(context)!.edit,
                                  style: TextStyle(
                                      color: ColorManager.greyLight,
                                      fontSize: FontSize.s16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
              SizedBox(
                height: AppSize.s16,
              ),
              Divider(
                thickness: 1,
                color: ColorManager.greyLight,
              ),
              _checkOutGetxController.paymentMethod.length == 0
                  ? Column(
                      children: [
                        SizedBox(
                          height: AppSize.s154,
                        ),
                        Image.asset(
                          ImageAssets.topUP,
                          height: AppSize.s192,
                        ),
                        SizedBox(
                          height: AppSize.s30,
                        ),
                        Text(
                          AppLocalizations.of(context)!.add_credit,
                        ),
                        SizedBox(
                          height: AppSize.s14,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SnapsheetScreen(lastScreen: 'topUp'),
                            ));
                          },
                          child: Text(
                            '+ ${AppLocalizations.of(context)!.add_new_card}',
                            style: TextStyle(
                                color: ColorManager.primary,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              _checkOutGetxController.paymentMethod.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  if (widget.screenName == 'payLater') {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => PayLaterProductView(
                                          paymentMethodId:
                                              _checkOutGetxController
                                                  .paymentMethod[index].id,
                                          index: SharedPrefController()
                                              .indexOfPayLaterProduct,
                                          cardNumber: _checkOutGetxController
                                              .paymentMethod[index]
                                              .last4Digits),
                                    ));
                                  } else {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => EnterAmount(
                                          typeOfPage: 0,
                                          paymentMethodId:
                                              _checkOutGetxController
                                                  .paymentMethod[index].id!),
                                    ));
                                  }
                                },
                                child: TopUpWidget(
                                  imageUrl: _checkOutGetxController
                                      .paymentMethod[index].image!,
                                  cardType: _checkOutGetxController
                                      .paymentMethod[index].brand!,
                                  last4digitNumber: _checkOutGetxController
                                      .paymentMethod[index].last4Digits!,
                                ));
                          },
                        )
                      ],
                    ),
              InkWell(
                onTap: () {
                  if (widget.screenName == 'topUp') {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SnapsheetScreen(lastScreen: 'topUp'),
                    ));
                  } else if (widget.screenName == 'payLater') {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SnapsheetScreen(lastScreen: 'payLater'),
                    ));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SnapsheetScreen(lastScreen: 'manage'),
                    ));
                  }
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${AppLocalizations.of(context)!.add_new_card}',
                        style: TextStyle(
                            color: ColorManager.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.s16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
