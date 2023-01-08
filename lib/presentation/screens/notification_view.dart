import 'package:flutter/material.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    AppLocalizations.of(context)!.notifications_and_alerts,
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
                AppLocalizations.of(context)!.never_miss_a_chance,
                style: getMediumStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s16,
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
             Container(
               padding: EdgeInsets.all( AppPadding.p20,),
               decoration: BoxDecoration(
                 color: ColorManager.grey,
                 borderRadius: BorderRadius.circular(AppRadius.r8),
               ),
               child: Row(children: [
                 Image.asset(
                   IconsAssets.help1,
                   height: AppSize.s26,
                   width: AppSize.s26,
                 ),
                 SizedBox(width: AppSize.s22,),
                 Text(
                   AppLocalizations.of(context)!.you_can_modify_and_turn_off_individual,
                   style: getMediumStyle(
                     color: ColorManager.white,
                     fontSize: FontSize.s14,
                   ),
                 ),
               ]),
             ),
              SizedBox(height: AppSize.s58,),
              Row(
                children: [
                  Image.asset(
                    IconsAssets.orderStatus,
                    height: AppSize.s32,
                    width: AppSize.s32,
                  ),
                  SizedBox(width: AppSize.s14,),
                  Text(
                    AppLocalizations.of(context)!.order_status,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.s16,),
              Text(
                AppLocalizations.of(context)!.receive_status_alerts_about,
                style: getRegularStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s14,
                ),
              ),
              SizedBox(height: AppSize.s24,),
              Row(
                children: [
                  Image.asset(
                    IconsAssets.notifications1,
                    height: AppSize.s32,
                    width: AppSize.s32,
                  ),
                  SizedBox(width: AppSize.s14,),
                  Text(
                    AppLocalizations.of(context)!.announcements_and_offers,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.s16,),
              Text(
                AppLocalizations.of(context)!.get_information_on_new_products,
                style: getRegularStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s14,
                ),
              ),

              SizedBox(height: AppSize.s24,),
              Row(
                children: [
                  // Image.asset(
                  //   IconsAssets.notifications1,
                  //   height: AppSize.s32,
                  //   width: AppSize.s32,
                  // ),
                  Icon(Icons.payments_outlined,size: AppSize.s32,color: ColorManager.primaryDark.withOpacity(0.8)),
                  SizedBox(width: AppSize.s14,),
                  Text(
                    AppLocalizations.of(context)!.pay_later_notify,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.s16,),
              Text(
                AppLocalizations.of(context)!.pay_later_description,
                style: getRegularStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s14,
                ),
              ),

              // SizedBox(
              //   height: AppSize.s18,
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(
              //     horizontal: AppMargin.m16,
              //   ),
              //   width: double.infinity,
              //   height: AppSize.s55,
              //   child: ElevatedButton(
              //     onPressed: () =>Navigator.pushReplacementNamed(context, Routes.registerRoute),
              //     child: Text(
              //       AppLocalizations.of(context)!.turn_on_notifications,
              //       style: getSemiBoldStyle(
              //           color: ColorManager.white, fontSize: FontSize.s18),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: AppSize.s18,
              // ),
              // Align(
              //   alignment: AlignmentDirectional.center,
              //   child: Text(
              //     AppLocalizations.of(context)!.no_thanks,
              //     style: getMediumStyle(
              //       color: ColorManager.grey,
              //       fontSize: FontSize.s14,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
