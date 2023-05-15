import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import 'controller/notification_getx_controller.dart';

class NotificationWidget extends StatelessWidget {
  int index;
  String id;
  String imageUrl;
  String header;
  bool isRead;
  String body;

  NotificationWidget(
      {required this.body,
      required this.index,
        required this.id,
        required this.isRead,
      required this.imageUrl,
      required this.header});

  //controller
  final NotificationGetxController _notificationGetxController =
      Get.find<NotificationGetxController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _notificationGetxController.markAsRead(
            context: context,
            id:id);
      },
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s20,
            ),
            Row(
              children: [
                Image.asset(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      IconsAssets.orderStatus,
                      height: AppSize.s32,
                      width: AppSize.s32,
                    );
                  },
                  height: AppSize.s32,
                  width: AppSize.s32,
                ),
                SizedBox(
                  width: AppSizeWidth.s14,
                ),
                Text(
                  '${header}',
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s16,
                  ),
                ),
                Spacer(),
                Visibility(
                  visible: !isRead,
                  child: Container(
                    height: AppSize.s6,
                    width: AppSizeWidth.s6,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(400)),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: AppSize.s16,
            ),
            Row(
              children: [
                Text(
                  '${body}',
                  style: getRegularStyle(
                    color: ColorManager.grey,
                    fontSize: FontSize.s14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
