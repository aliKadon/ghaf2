import 'package:flutter/material.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';

import '../resources/values_manager.dart';

class PreOrderWidget extends StatelessWidget {
  var language = SharedPrefController().lang1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Image.asset(
              ImageAssets.albaik,
              height: AppSize.s85,
            ),
            SizedBox(
              width: AppSize.s30,
            ),
            Text(
              'Albaik',
              style: TextStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            language == 'en' ? Image.asset(
              IconsAssets.arrow2,
              height: AppSize.s30,
              color: ColorManager.primary,
            ) : Image.asset(
              IconsAssets.arrow,
              height: AppSize.s30,
              color: ColorManager.primary,
            ),
          ],
        ),
      ),
    );
  }
}
