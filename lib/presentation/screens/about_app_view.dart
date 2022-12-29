import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/screens/faq_view.dart';
import 'package:ghaf_application/presentation/screens/share_opinion_view.dart';
import 'package:ghaf_application/presentation/screens/site_privacy_view.dart';
import 'package:ghaf_application/presentation/screens/terms_use_view.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math; // import this

class AboutAppView extends StatelessWidget {
  const AboutAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: SingleChildScrollView(
            child: Column(
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
                      AppLocalizations.of(context)!.about_the_app,
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
                  height: AppSize.s40,
                ),
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => FAQView()),
                      );
                    },
                    child: aboutApp(context, AppLocalizations.of(context)!.faqs)),
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => SharaYourOpinionView()),
                      );
                    },
                    child: aboutApp(context, AppLocalizations.of(context)!.share_your_opinion)),
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => SitePrivacyView()),
                      );
                    },
                    child: aboutApp(context, AppLocalizations.of(context)!.site_privacy)),
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => TermsOfUseView()),
                      );
                    },
                    child: aboutApp(context, AppLocalizations.of(context)!.terms_of_use)),
                aboutApp(context, AppLocalizations.of(context)!.facebook),
                aboutApp(context, AppLocalizations.of(context)!.twitter),
                aboutApp(context, AppLocalizations.of(context)!.instagram),
                SizedBox(
                  height: AppSize.s22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding aboutApp(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Row(
        children: [
          Text(
            title,
            style: getRegularStyle(
              color: ColorManager.grey,
              fontSize: FontSize.s16,
            ),
          ),
          Spacer(),
          Transform(
            transform: Matrix4.rotationY(math.pi),
            child: Image.asset(
              IconsAssets.arrow,
              height: AppSize.s18,
              width: AppSize.s10,
            ),
          ),
        ],
      ),
    );
  }
}
