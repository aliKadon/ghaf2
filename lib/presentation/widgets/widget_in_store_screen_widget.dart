import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/offers/offers_screen_new.dart';
import 'package:ghaf_application/presentation/screens/store_view/discount_screen.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import '../screens/store_view/onsale_view.dart';
import '../screens/store_view/trending_view.dart';

class WidgetInStoreScreenWidget extends StatelessWidget {

  final String text;
  final String imageUrl;
  final String bid;
  final bool is24;
  WidgetInStoreScreenWidget({required this.text,required this.imageUrl,required this.bid,required this.is24});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(text == AppLocalizations.of(context)!.discount) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DisicountScreen(),
            ),
          );
        }else if (text == AppLocalizations.of(context)!.on_sale) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OnsaleView(bid: bid,is24: is24),
            ),
          );
        }else if (text == AppLocalizations.of(context)!.trending ) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TrendingView(bid: bid),
            ),
          );
        }

      },
      child: Container(
        width: AppSize.s92,
        padding: EdgeInsetsDirectional.only(
          end: AppSize.s8,
        ),
        child: Container(
          height: MediaQuery.of(context)
              .size
              .height *
              0.2,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context)
                    .size
                    .height *
                    0.12,
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
                        overflow: TextOverflow
                            .ellipsis,
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