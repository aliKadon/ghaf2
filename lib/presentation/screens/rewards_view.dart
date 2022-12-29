import 'package:flutter/material.dart';
import '../../app/constants.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math; // import this

class RewardsView extends StatelessWidget {
  const RewardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              Row(
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
                    AppLocalizations.of(context)!.rewards,
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
                height: AppSize.s30,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p10, vertical: AppPadding.p14),
                    decoration: BoxDecoration(
                      color: ColorManager.greyLight,
                      borderRadius: BorderRadius.circular(AppRadius.r8),
                    ),
                    child: Image.asset(
                      IconsAssets.rewards,
                      height: AppSize.s34,
                      width: AppSize.s44,
                    ),
                  ),
                  SizedBox(
                    width: AppSize.s10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '355 point',
                        style: getBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s18,
                        ),
                      ),
                      Text(
                        'Points expire',
                        style: getRegularStyle(
                          color: ColorManager.grey,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      Text(
                        ' 22\10\2022',
                        style: getRegularStyle(
                          color: ColorManager.grey,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: AppSize.s24,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: AppPadding.p8, horizontal: AppPadding.p8),
                decoration: BoxDecoration(
                  color: ColorManager.whiteLight,
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                ),
                child: Row(
                  children: [
                    Text(
                      '90 points spent',
                      style: getMediumStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.browse_history,
                      style: getRegularStyle(
                        color: ColorManager.grey,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.free_delivery_bonus,
                      style: getMediumStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.more,
                      style: getMediumStyle(
                        color: ColorManager.greyLight,
                        fontSize: FontSize.s16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s8,
              ),
              Expanded(
                child: GridView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p8, vertical: AppPadding.p4),
                    shrinkWrap: true,
                    itemCount: 10,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Constants.crossAxisCount,
                      mainAxisExtent: Constants.mainAxisExtent,
                      mainAxisSpacing: Constants.mainAxisSpacing,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r14),
                                child: Image.asset(
                                  ImageAssets.test,
                                  height: AppSize.s211,
                                  width: AppSize.s154,
                                ),
                              ),
                              PositionedDirectional(
                                end: AppSize.s12,
                                top: AppSize.s12,
                                child: CircleAvatar(
                                  radius: AppRadius.r14,
                                  backgroundColor: ColorManager.burgundy,
                                  child: Image.asset(
                                    IconsAssets.heart,
                                    height: AppSize.s16,
                                    width: AppSize.s16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            'Modern light clothes',
                            style: getSemiBoldStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s14,
                            ),
                          ),
                          SizedBox(
                            height: AppSize.s8,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: AppPadding.p22),
                            child: Row(
                              children: [
                                Text(
                                  'Dress modern',
                                  style: getRegularStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s10,
                                  ),
                                ),
                                Spacer(),
                                Image.asset(
                                  IconsAssets.start,
                                  height: AppSize.s14,
                                  width: AppSize.s15,
                                ),
                                SizedBox(
                                  width: AppSize.s8,
                                ),
                                Text(
                                  '5.0',
                                  style: getRegularStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: AppSize.s22,
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
