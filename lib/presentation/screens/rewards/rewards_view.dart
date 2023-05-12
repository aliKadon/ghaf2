import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/offers_view/offers_screen_getx_controller.dart';
import 'package:provider/provider.dart';

import '../../../app/constants.dart';
import '../../../providers/product_provider.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class RewardsView extends StatefulWidget {
  const RewardsView({Key? key}) : super(key: key);

  @override
  State<RewardsView> createState() => _RewardsViewState();
}

class _RewardsViewState extends State<RewardsView> {
  late final OffersScreenGetXController _offersScreenGetXController =
      Get.put(OffersScreenGetXController());

  var isLoading = true;

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false)
        .getRedeemPoints()
        .then((value) => isLoading = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var redeem = Provider
    //     .of<ProductProvider>(context)
    //     .redeemsPoints;

    var allRedeemPoint = Provider.of<ProductProvider>(context).redeemsPoints;
    print('=======================rewards');
    print(allRedeemPoint);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: isLoading
              ? Center(
                  child: Container(
                    width: 20.h,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // allRedeemPoint = 0;
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.038,
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: Image.asset(
                              IconsAssets.arrow,
                              height: AppSize.s18,
                              width: AppSize.s10,
                            ),
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
                              horizontal: AppPadding.p10,
                              vertical: AppPadding.p14),
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
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${allRedeemPoint['total']} ${AppLocalizations.of(context)!.point}',
                                  style: getBoldStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s18,
                                  ),
                                ),
                                SizedBox(
                                  width: AppSize.s123,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    AppLocalizations.of(context)!.how_it_work,
                                    style: getBoldStyle(
                                      color: ColorManager.primary,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: AppSize.s110,
                              child: Text(
                                AppLocalizations.of(context)!.all_points_you_have,
                                style: getRegularStyle(
                                  color: ColorManager.grey,
                                  fontSize: FontSize.s14,
                                ),
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.congrats,
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
                            '90 ${AppLocalizations.of(context)!.points_spent2}',
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
                    Row(
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
                    SizedBox(
                      height: AppSize.s8,
                    ),
                    Expanded(
                      child: GridView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppPadding.p8,
                              vertical: AppPadding.p4),
                          shrinkWrap: true,
                          itemCount: allRedeemPoint['list'].length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                    // PositionedDirectional(
                                    //   end: AppSize.s12,
                                    //   top: AppSize.s12,
                                    //   child: CircleAvatar(
                                    //     radius: AppRadius.r14,
                                    //     backgroundColor: ColorManager.burgundy,
                                    //     child: Image.asset(
                                    //       IconsAssets.heart,
                                    //       height: AppSize.s16,
                                    //       width: AppSize.s16,
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                                Text(
                                  AppLocalizations.of(context)!.congrats,
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
                                      FittedBox(
                                        child: Text(
                                          allRedeemPoint['list'][index]
                                              ['storeName'],
                                          style: getRegularStyle(
                                            color: ColorManager.grey,
                                            fontSize: FontSize.s14,
                                          ),
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
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          allRedeemPoint['list'][index]
                                                  ['points']
                                              .toString(),
                                          style: getRegularStyle(
                                            color: ColorManager.black,
                                            fontSize: FontSize.s10,
                                          ),
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
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.offers,
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
            child: Container(
              height: MediaQuery.of(context).size.height * 0.038,
              width: MediaQuery.of(context).size.width * 0.08,
              child: Image.asset(
                IconsAssets.arrow,
                height: AppSize.s18,
                width: AppSize.s10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
