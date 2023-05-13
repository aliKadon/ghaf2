import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

import '../../../resources/routes_manager.dart';

class IntroduceToSubscribe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> introduceText = [
      AppLocalizations.of(context)!.introduce_to_subscribe1,
      AppLocalizations.of(context)!.introduce_to_subscribe2,
      AppLocalizations.of(context)!.introduce_to_subscribe3,
      AppLocalizations.of(context)!.introduce_to_subscribe4,
      AppLocalizations.of(context)!.introduce_to_subscribe5
    ];
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Text(
            AppLocalizations.of(context)!.join_sus_snow_and_get,
            style: TextStyle(
                fontSize: FontSize.s18,
                color: ColorManager.primary,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AppSize.s15,
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.s14),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: introduceText.length,
              itemBuilder: (context, index) {
                return introduceToSubscribeWidget(context: context,text: introduceText[index]);
              },
            ),
          ),
          Image.asset(
            ImageAssets.introduceSubscribeSeller,
            height: AppSize.s222,
          ),
          SizedBox(height: AppSize.s16,),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: AppSize.s43,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.subscriptionSellerRoute);
                }, child: Text(AppLocalizations.of(context)!.next)),
          )
        ],
      ),
    );
  }

  Widget introduceToSubscribeWidget({required BuildContext context,required String text}) {
    return Container(
      padding: EdgeInsets.all(AppSize.s8),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: ColorManager.primary,
          ),
          SizedBox(
            width: AppSize.s16,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              text,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
