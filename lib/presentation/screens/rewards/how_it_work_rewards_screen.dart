import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/get_help/get_help_screen.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class HowItWorkRewardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.05),
          Row(
            children: [
              SizedBox(
                width: AppSize.s20,
              ),
              GestureDetector(
                onTap: () {
                  // allRedeemPoint = 0;
                  Navigator.pop(context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.038,
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: Image.asset(
                    SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                    height: AppSize.s18,
                    width: AppSize.s10,
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GetHelpScreen(),));
                },
                child: Text(
                  AppLocalizations.of(context)!.get_help,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
              ),
              SizedBox(
                width: AppSize.s20,
              ),
            ],
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorManager.greyLight1,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(150),
                    bottomLeft: Radius.circular(150))),
            padding: EdgeInsets.all(AppSize.s40),
            child: Image.asset(
              ImageAssets.gift2,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.s14),
            child: Text(
              AppLocalizations.of(context)!.how_to_earn_points,
              style: TextStyle(
                  color: ColorManager.primaryDark,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSize.s20),
            ),
          ),
          StructureToEarnPoints(context, ImageAssets.ghafHelp,
              AppLocalizations.of(context)!.structure_earn_points1),
          StructureToEarnPoints(context, ImageAssets.earnPoints2,
              AppLocalizations.of(context)!.structure_earn_points2),
          StructureToEarnPoints(context, ImageAssets.gift2,
              AppLocalizations.of(context)!.structure_earn_points3),
          StructureToEarnPoints(context, ImageAssets.star1,
              AppLocalizations.of(context)!.structure_earn_points4),
        ],
      ),
    );
  }

  Widget StructureToEarnPoints(BuildContext context, String image,
      String text) {
    return Padding(
      padding: EdgeInsets.all(AppSize.s14),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: ColorManager.greyLight1,
                borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.all(AppSize.s10),
            child: Image.asset(image, height: AppSize.s30),
          ),
          SizedBox(
            width: AppSize.s20,
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.65,
            child: Text(text,
                softWrap: true,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    color: ColorManager.primaryDark,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.s14)),
          ),
        ],
      ),
    );
  }
}
