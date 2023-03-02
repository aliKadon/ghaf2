import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/transaction.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../checkout/snapsheet_screen.dart';


class AddCreditScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: AppSize.s32,
          ),
          Row(
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
                AppLocalizations.of(context)!.add_credit1,
                style: getSemiBoldStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s18,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: AppSize.s16,
          ),
          Divider(
            thickness: 1,
            color: ColorManager.greyLight,
          ),
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
                    SnapsheetScreen(lastScreen: 'addCredit'),
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
      ),
    );
  }
}