import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/screens/profile/notification/controller/notification_getx_controller.dart';

import '../../../../domain/model/customer_notification.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import 'notificaton_widget.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  //controller
  final NotificationGetxController _notificationGetxController =
      Get.put(NotificationGetxController());

  var imageUrl = '';

  void chooseImageForNotification(CustomerNotification notification) {
    if (notification.type == 0 || notification.type == -1) {
      imageUrl = IconsAssets.orderStatus;
    } else if (notification.type == 1 || notification.type == 2) {
      imageUrl = IconsAssets.notifications1;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _notificationGetxController.getCustomerNotification(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(AppSize.s8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
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
                    AppLocalizations.of(context)!.notifications_and_alerts,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s12,
            ),
            Divider(height: 1, color: ColorManager.greyLight),
            SizedBox(
              height: AppSize.s17,
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: AppPadding.p16),
            //   child: Text(
            //     AppLocalizations.of(context)!.never_miss_a_chance,
            //     style: getMediumStyle(
            //       color: ColorManager.primaryDark,
            //       fontSize: FontSize.s16,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: AppSize.s16,
            // ),
            Container(
              padding: EdgeInsets.all(
                AppPadding.p20,
              ),
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
                SizedBox(
                  width: AppSize.s22,
                ),
                Text(
                  AppLocalizations.of(context)!
                      .you_can_modify_and_turn_off_individual,
                  style: getMediumStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s14,
                  ),
                ),
              ]),
            ),
            GetBuilder<NotificationGetxController>(
              builder: (controller) => Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.customerNotification.length,
                  itemBuilder: (context, index) {
                    chooseImageForNotification(
                        controller.customerNotification[index]);
                    return NotificationWidget(
                      isRead: controller.customerNotification[index].isRead!,
                      imageUrl: imageUrl,
                      index: index,
                      body: controller.customerNotification[index].body!,
                      id: controller.customerNotification[index].id!,
                      header: controller.customerNotification[index].header!,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: AppSize.s20,
                  // ),
                  // Row(
                  //   children: [
                  //     Image.asset(
                  //       IconsAssets.orderStatus,
                  //       height: AppSize.s32,
                  //       width: AppSize.s32,
                  //     ),
                  //     SizedBox(
                  //       width: AppSize.s14,
                  //     ),
                  //     Text(
                  //       AppLocalizations.of(context)!.order_status,
                  //       style: getSemiBoldStyle(
                  //         color: ColorManager.primaryDark,
                  //         fontSize: FontSize.s16,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: AppSize.s16,
                  // ),
                  // Text(
                  //   AppLocalizations.of(context)!.receive_status_alerts_about,
                  //   style: getRegularStyle(
                  //     color: ColorManager.grey,
                  //     fontSize: FontSize.s14,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: AppSize.s24,
                  // ),
                  // Row(
                  //   children: [
                  //     Image.asset(
                  //       IconsAssets.notifications1,
                  //       height: AppSize.s32,
                  //       width: AppSize.s32,
                  //     ),
                  //     SizedBox(
                  //       width: AppSize.s14,
                  //     ),
                  //     Text(
                  //       AppLocalizations.of(context)!.announcements_and_offers,
                  //       style: getSemiBoldStyle(
                  //         color: ColorManager.primaryDark,
                  //         fontSize: FontSize.s16,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: AppSize.s16,
                  // ),
                  // Text(
                  //   AppLocalizations.of(context)!
                  //       .get_information_on_new_products,
                  //   style: getRegularStyle(
                  //     color: ColorManager.grey,
                  //     fontSize: FontSize.s14,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: AppSize.s24,
                  // ),
                  // Row(
                  //   children: [
                  //     // Image.asset(
                  //     //   IconsAssets.notifications1,
                  //     //   height: AppSize.s32,
                  //     //   width: AppSize.s32,
                  //     // ),
                  //     Icon(Icons.payments_outlined,
                  //         size: AppSize.s32,
                  //         color: ColorManager.primaryDark.withOpacity(0.8)),
                  //     SizedBox(
                  //       width: AppSize.s14,
                  //     ),
                  //     Text(
                  //       AppLocalizations.of(context)!.pay_later_notify,
                  //       style: getSemiBoldStyle(
                  //         color: ColorManager.primaryDark,
                  //         fontSize: FontSize.s16,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: AppSize.s16,
                  // ),
                  // Text(
                  //   AppLocalizations.of(context)!.pay_later_description,
                  //   style: getRegularStyle(
                  //     color: ColorManager.grey,
                  //     fontSize: FontSize.s14,
                  //   ),
                  // ),
                  SizedBox(
                    height: AppSize.s18,
                  ),
                  SharedPrefController().enableNotifications
                      ? Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: AppMargin.m16,
                          ),
                          width: double.infinity,
                          height: AppSize.s55,
                          child: ElevatedButton(
                            onPressed: () {
                              SharedPrefController()
                                  .setEnableNotification(false);
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Thank you, The notifications is Off!'),
                                backgroundColor: Colors.green,
                              ));
                            },
                            child: Text(
                              AppLocalizations.of(context)!.turn_off_notification,
                              // 'Turn Off Notifications',
                              style: getSemiBoldStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s18),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: AppMargin.m16,
                              ),
                              width: double.infinity,
                              height: AppSize.s55,
                              child: ElevatedButton(
                                onPressed: () {
                                  SharedPrefController()
                                      .setEnableNotification(true);
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Thank you, The notifications is On!'),
                                    backgroundColor: Colors.green,
                                  ));
                                },
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .turn_on_notifications,
                                  style: getSemiBoldStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.s18),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AppSize.s18,
                            ),
                            Align(
                              alignment: AlignmentDirectional.center,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Text(
                                  AppLocalizations.of(context)!.no_thanks,
                                  style: getMediumStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
