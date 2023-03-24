import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/home_view/only_on_ghaf_screen.dart';
import 'package:ghaf_application/presentation/screens/home_view/past_order_screen.dart';
import 'package:ghaf_application/presentation/screens/offers/offers_screen_new.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import '../screens/store_view/onsale_view.dart';
import '../screens/store_view/trending_view.dart';

class ShortcutsWidget extends StatelessWidget {

  final String text;
  final String imageUrl;
  final String bid;

  ShortcutsWidget(
      {required this.text, required this.imageUrl, required this.bid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text == AppLocalizations.of(context)!.only_on_ghaf) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OnlyOnGhafScreen(),));
        }else if (text == AppLocalizations.of(context)!.trending) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TrendingView(bid: ''),));
        }else if (text == AppLocalizations.of(context)!.past_order) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PastOrderScreen(),));
        }else if (text == AppLocalizations.of(context)!.offers) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OffersScreenNew(),));
        }
      },
      child: Container(
        width: AppSize.s92,
        // height: AppSize.s110,
        padding: EdgeInsetsDirectional.only(
          end: AppSize.s8,
        ),
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height *
              0.2,
          child: Column(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height *
                    0.135,
                width: AppSize.s92,
                padding: EdgeInsets.all(
                    AppPadding.p12),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  border: Border.all(
                      width: AppSize.s0_5,
                      color: ColorManager
                          .greyLight),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager
                          .greyLight,
                      blurRadius: AppSize.s4,
                      offset: Offset(
                          AppSize.s0,
                          AppSize
                              .s4), // Shadow position
                    ),
                  ],
                  borderRadius:
                  BorderRadius.circular(
                      AppRadius.r4),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      // base64Decode(category.categoryImage ?? ''),
                      imageUrl,
                      width: AppSize.s40,
                      height: AppSize.s36,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    Flexible(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow
                            .clip,
                        style: getMediumStyle(
                          color: ColorManager
                              .primaryDark,
                          fontSize:
                          FontSize.s12,
                        ),
                      ),
                    ),
                  ],
                ),

                // Image.asset(
                //   IconsAssets.cart,
                //   height: AppSize.s36,
                //   width: AppSize.s36,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}