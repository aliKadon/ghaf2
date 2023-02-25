import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/screens/profile/profile_setting.dart';

import '../../../app/constants.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class Profile extends StatelessWidget {
  var language = SharedPrefController().lang1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s20,
            ),
            Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Row(
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
                    AppLocalizations.of(context)!.profile,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            // SizedBox(
            //   height: AppSize.s8,
            // ),
            Divider(
              thickness: 1,
              color: ColorManager.greyLight,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p16),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.grey,
                    blurRadius: AppSize.s2,
                    offset: Offset(AppSize.s0, AppSize.s2), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileSetting(),));
                    },
                    child: accountWidget(
                        context,
                        language == 'en'
                            ? IconsAssets.arrow2
                            : IconsAssets.arrow,
                        AppLocalizations.of(context)!.account_info),
                  ),
                  GestureDetector(
                    child: accountWidget(
                        context,
                        language == 'en'
                            ? IconsAssets.arrow2
                            : IconsAssets.arrow,
                        AppLocalizations.of(context)!.change_email),
                  ),
                  GestureDetector(
                    child: accountWidget(
                        context,
                        language == 'en'
                            ? IconsAssets.arrow2
                            : IconsAssets.arrow,
                        AppLocalizations.of(context)!.change_password),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p16),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.grey,
                    blurRadius: AppSize.s2,
                    offset: Offset(AppSize.s0, AppSize.s2), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    child: accountWidget(
                        context,
                        language == 'en'
                            ? IconsAssets.arrow2
                            : IconsAssets.arrow,
                        AppLocalizations.of(context)!.notifications),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p16),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.grey,
                    blurRadius: AppSize.s2,
                    offset: Offset(AppSize.s0, AppSize.s2), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    child: accountWidget(
                        context,
                        language == 'en'
                            ? IconsAssets.arrow2
                            : IconsAssets.arrow,
                        AppLocalizations.of(context)!.language),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding accountWidget(BuildContext context,
      String icon,
      String title, {
        String? subTitle,
        bool isVector = false,
        IconData? iconName,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p22),
      child: Row(
        children: [
          // SizedBox(
          //   width: AppSize.s8,
          // ),
          Text(
            title,
            style: getMediumStyle(
              color: ColorManager.primaryDark,
              fontSize: FontSize.s16,
            ),
          ),

          Text(
            subTitle ?? '',
            style: getRegularStyle(
              color: ColorManager.grey,
              fontSize: FontSize.s14,
            ),
          ),
          Spacer(),
          iconName == null
              ? isVector
              ? SvgPicture.asset(
            '${Constants.vectorsPath}$icon.svg',
            width: AppSize.s24,
            height: AppSize.s24,
            color: ColorManager.primary,
          )
              : Image.asset(
            icon,
            height: AppSize.s20,
            width: AppSize.s20,
            color: ColorManager.primary,
          )
              : Icon(
            iconName,
            color: ColorManager.primary,
          ),
        ],
      ),
    );
  }
}
