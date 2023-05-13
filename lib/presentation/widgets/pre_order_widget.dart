import 'package:flutter/material.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/screens/orders/schedual_order_orders.dart';

import '../resources/values_manager.dart';

class PreOrderWidget extends StatefulWidget {
  final String storeName;
  final String image;

  PreOrderWidget({required this.storeName, required this.image});

  @override
  State<PreOrderWidget> createState() => _PreOrderWidgetState();
}

class _PreOrderWidgetState extends State<PreOrderWidget> {
  var language = SharedPrefController().lang1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSize.s8),
      child: Container(
        child: Row(
          children: [
            Image.network(
              widget.image,
              height: AppSize.s65,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  ImageAssets.albaik,
                  height: AppSize.s85,
                );
              },
            ),
            SizedBox(
              width: AppSize.s30,
            ),
            Text(
              '${widget.storeName}',
              style: TextStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            language == 'en'
                ? Image.asset(
                    SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                    height: AppSize.s30,
                    color: ColorManager.primary,
                  )
                : Image.asset(
                    SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                    height: AppSize.s30,
                    color: ColorManager.primary,
                  ),
          ],
        ),
      ),
    );
  }
}
