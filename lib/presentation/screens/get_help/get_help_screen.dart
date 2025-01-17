import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/presentation/screens/get_help/return_order_get_help.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class GetHelpScreen extends StatefulWidget {
  @override
  State<GetHelpScreen> createState() => _GetHelpScreenState();
}

class _GetHelpScreenState extends State<GetHelpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(AppSize.s6),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
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
              ),
              Spacer(),
              Text(
                AppLocalizations.of(context)!.get_help,
                style: getSemiBoldStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s18,
                ),
              ),
              Spacer(),
            ],
          ),
          Divider(
            thickness: 1,
            color: ColorManager.greyLight,
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.s14),
            child: Text(
              '${AppLocalizations.of(context)!.hi} ${AppSharedData.currentUser?.firstName} ${AppSharedData.currentUser?.lastName}. ${AppLocalizations.of(context)!.what_we_can_help_you}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s16),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(AppSize.s24),
            child: Text(
              AppLocalizations.of(context)!
                  .if_you_have_issue_please_select_one_of_the_option,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorManager.greyLight,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s14),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReturnOrderGetHelp(
                      getHelpType: AppLocalizations.of(context)!
                          .return_an_item_you_ordered),
                ));
              },
              child: GetHelpType(
                  AppLocalizations.of(context)!.return_an_item_you_ordered)),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReturnOrderGetHelp(
                      getHelpType: AppLocalizations.of(context)!
                          .report_delayed_delivery),
                ));
              },
              child: GetHelpType(
                  AppLocalizations.of(context)!.report_delayed_delivery)),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ReturnOrderGetHelp(
                    getHelpType: AppLocalizations.of(context)!
                        .report_issues_with_your_order),
              ));
            },
            child: GetHelpType(
                AppLocalizations.of(context)!.report_issues_with_your_order),
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReturnOrderGetHelp(
                      getHelpType:
                          AppLocalizations.of(context)!.report_other_issues),
                ));
              },
              child: GetHelpType(
                  AppLocalizations.of(context)!.report_other_issues)),
        ],
      ),
    );
  }

  Widget GetHelpType(String text) {
    return Padding(
      padding: EdgeInsets.all(AppSize.s14),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: ColorManager.primary,
          ),
          SizedBox(
            width: AppSize.s24,
          ),
          Text(text,
              style: TextStyle(
                  fontSize: FontSize.s16, fontWeight: FontWeight.w500)),
          Spacer(),
          Image.asset(
            SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow : IconsAssets.arrow2,
            height: AppSize.s18,
            color: ColorManager.primary,
          ),
        ],
      ),
    );
  }
}
