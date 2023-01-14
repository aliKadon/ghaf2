import 'package:flutter/material.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';

import '../../domain/model/models.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math; // import this

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
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
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
