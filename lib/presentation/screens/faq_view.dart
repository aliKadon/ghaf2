import 'package:flutter/material.dart';
import '../../domain/model/models.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math; // import this

class FAQView extends StatefulWidget {
  const FAQView({Key? key}) : super(key: key);

  @override
  State<FAQView> createState() => _FAQViewState();
}

class _FAQViewState extends State<FAQView> {


  @override
  Widget build(BuildContext context) {
    List<Faq> _faqs = <Faq>[
      Faq(question: AppLocalizations.of(context)!.faq1, answer:  AppLocalizations.of(context)!.faq1_res),
      Faq(question: AppLocalizations.of(context)!.faq2, answer:  AppLocalizations.of(context)!.faq2_res),
      Faq(question: AppLocalizations.of(context)!.faq3, answer:  AppLocalizations.of(context)!.faq3_res),
      Faq(question: AppLocalizations.of(context)!.faq4, answer:  AppLocalizations.of(context)!.faq4_res),
      Faq(question: AppLocalizations.of(context)!.faq5, answer:  AppLocalizations.of(context)!.faq5_res),
      Faq(question: AppLocalizations.of(context)!.faq6, answer:  AppLocalizations.of(context)!.faq6_res),
      Faq(question: AppLocalizations.of(context)!.faq7, answer:  AppLocalizations.of(context)!.faq7_res),
      Faq(question: AppLocalizations.of(context)!.faq8, answer:  AppLocalizations.of(context)!.faq8_res),
      Faq(question: AppLocalizations.of(context)!.faq9, answer:  AppLocalizations.of(context)!.faq9_res),
      Faq(question: AppLocalizations.of(context)!.faq10, answer:  AppLocalizations.of(context)!.faq10_res),
        ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p8,vertical: AppPadding.p16),
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
                    AppLocalizations.of(context)!.faqs,
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
                height: AppSize.s18,
              ),
              Image.asset(
                ImageAssets.faq,
                height: AppSize.s184,
                width: AppSize.s281,
              ),
              SizedBox(
                height: AppSize.s22,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _faqs.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        collapsedTextColor: ColorManager.black,
                        expandedAlignment: Alignment.bottomLeft,
                        childrenPadding: EdgeInsets.symmetric(horizontal: AppPadding.p12,vertical: AppPadding.p8),
                        title: Text(_faqs[index].question,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s18),),
                        children: [
                          Text(_faqs[index].answer,style: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14),),
                        ],
                      );
                    }),
              ),
            ],
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
