import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/checkout/snapsheet_screen.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/edit_payment_method_screen.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/enter_amount.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/transaction.dart';
import 'package:ghaf_application/presentation/widgets/top_up_widget.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class TopUpScreen extends StatelessWidget {
  String? screenName;

  TopUpScreen({this.screenName});

  var a = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s32,
            ),
            screenName == 'topUp'
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
                          child: Image.asset(
                            IconsAssets.arrow,
                            height: AppSize.s18,
                            width: AppSize.s10,
                            color: ColorManager.primaryDark,
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
                          child: Image.asset(
                            IconsAssets.arrow,
                            height: AppSize.s18,
                            width: AppSize.s10,
                            color: ColorManager.primaryDark,
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
                            builder: (context) => EditPaymentMethodScreen(),
                          ));
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 14.0, right: 14.0),
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
            a == 0
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
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EnterAmount(),
                                ));
                              },
                              child: TopUpWidget());
                        },
                      )
                    ],
                  ),
            InkWell(
              onTap: () {
                if (screenName == 'topUp') {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SnapsheetScreen(lastScreen: 'topUp'),
                  ));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SnapsheetScreen(lastScreen: 'manage'),
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
    );
  }
}
