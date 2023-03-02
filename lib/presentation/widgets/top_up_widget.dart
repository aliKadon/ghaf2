import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

class TopUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorManager.grey)),
        child: Row(
          children: [
            Image.asset(
              ImageAssets.visa,
              height: AppSize.s20,
            ),
            SizedBox(
              width: AppSize.s46,
            ),
            Text(
              'Visa xxxx-4851',
              style: TextStyle(
                  color: ColorManager.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSize.s16),
            ),
            Spacer(),
            Image.asset(
              IconsAssets.arrow2,
              height: AppSize.s20,
              color: ColorManager.greyLight,
            )
          ],
        ),
      ),
    );
  }
}
