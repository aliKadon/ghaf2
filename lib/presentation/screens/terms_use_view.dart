import 'package:flutter/material.dart';
import '../../app/preferences/shared_pref_controller.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()=>Navigator.pop(context),
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
                    Text(
                      AppLocalizations.of(context)!.terms_of_use,
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
                  height: AppSize.s17,
                ),
                Text(
                  '${AppLocalizations.of(context)!.terms}',
                  textAlign: TextAlign.start,
                  style: getRegularStyle(
                    color: ColorManager.grey,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(
                  height: AppSize.s18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
