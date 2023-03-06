import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/get_help/report_another_issue_screen.dart';
import 'package:ghaf_application/presentation/screens/get_help/report_delayed_screen.dart';
import 'package:ghaf_application/presentation/screens/get_help/report_issue_with_order_Screen.dart';
import 'package:ghaf_application/presentation/screens/get_help/return_order_item_details_get_help.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ReturnOrderGetHelp extends StatelessWidget {
  final String getHelpType;
  ReturnOrderGetHelp({required this.getHelpType});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.06,
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
              SizedBox(
                height: AppSize.s14,
              ),
              Text(
                getHelpType,
                style: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.primaryDark),
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.04,
              ),
              Text(
                AppLocalizations.of(context)!.tap_an_item_you_need_help_with,
                style: TextStyle(fontSize: FontSize.s16),
              ),
              SizedBox(
                height: AppSize.s14,
              ),
              Container(
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1,
                child: TextField(
                  textInputAction: TextInputAction.search,
                  textAlign: TextAlign.start,
                  style: getMediumStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
                      child: Image.asset(
                        IconsAssets.search,
                        width: AppSize.s16,
                        height: AppSize.s16,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p16, vertical: AppPadding.p16),
                    hintText: AppLocalizations.of(context)!.search_your_item,
                    hintStyle: getMediumStyle(
                      color: ColorManager.hintTextFiled,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.6,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if(getHelpType == AppLocalizations.of(context)!.return_an_item_you_ordered) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ReturnOrderItemDetailsGetHelp(),));
                        }
                        if (getHelpType == AppLocalizations.of(context)!.report_issues_with_your_order) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ReportIssueWithOrderScreen(),));
                        }
                        if (getHelpType == AppLocalizations.of(context)!.report_delayed_delivery) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ReportDelayedScreen(),));
                        }
                        if (getHelpType == AppLocalizations.of(context)!.report_other_issues) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ReportAnotherIssueScreen(),));
                        }

                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: AppSize.s110,
                                width: AppSize.s110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(ImageAssets.pizza))),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'pizza neew pizza',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: AppSize.s30,
                                  ),
                                  Text(
                                    'ordered on 9 dec 2022',
                                    style: TextStyle(
                                      color: ColorManager.greyLight,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Image.asset(
                                IconsAssets.arrow2,
                                height: AppSize.s18,
                                color: ColorManager.primary,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSize.s18,
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
