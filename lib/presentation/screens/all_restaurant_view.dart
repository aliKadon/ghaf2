import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllRestaurantView extends StatelessWidget {
  const AllRestaurantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.038,
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.all_restaurant,
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
                  height: AppSize.s12,
                ),
                Text(
                  AppLocalizations.of(context)!.save_more_than_30_aed,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Text(
                  AppLocalizations.of(context)!
                      .we_noticed_that_you_have_not_ordered,
                  style: getRegularStyle(
                    color: ColorManager.grey,
                    fontSize: FontSize.s12,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context,index){
                  return  Padding(
                    padding:  EdgeInsets.symmetric(vertical: AppPadding.p12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.r14),
                          child: Image.asset(
                            fit: BoxFit.cover,
                            ImageAssets.test,
                            height: AppSize.s86,
                            width: AppSize.s86,
                          ),
                        ),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Emirates Cafeteria',
                              style: getMediumStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            SizedBox(
                              height: AppSize.s4,
                            ),
                            Text(
                              'Breakfast, lunch',
                              style: getRegularStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s12,
                              ),
                            ),
                            SizedBox(
                              height: AppSize.s4,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  IconsAssets.start,
                                  height: AppSize.s15,
                                  width: AppSize.s15,
                                ),
                                SizedBox(
                                  width: AppSize.s10,
                                ),
                                Text(
                                  '5.0',
                                  style: getRegularStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                                SizedBox(
                                  width: AppSize.s10,
                                ),
                                Text(
                                  '(100+)',
                                  style: getRegularStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSize.s4,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  IconsAssets.clock1,
                                  height: AppSize.s12,
                                  width: AppSize.s12,
                                ),
                                SizedBox(
                                  width: AppSize.s6,
                                ),
                                Text(
                                  '20 MIN',
                                  style: getRegularStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                                SizedBox(
                                  width: AppSize.s10,
                                ),
                                Image.asset(
                                  IconsAssets.motorcycleDelivery,
                                  height: AppSize.s16,
                                  width: AppSize.s16,
                                ),
                                SizedBox(
                                  width: AppSize.s6,
                                ),
                                Text(
                                  '8 AED',
                                  style: getRegularStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
