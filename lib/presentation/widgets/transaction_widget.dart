import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

class TransactionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.asset(
            ImageAssets.brIcon,
            height: AppSize.s60,
          ),
          SizedBox(
            width: AppSize.s30,
          ),
          Column(
            children: [
              Text('baskin robbins',
                  style: TextStyle(
                      color: ColorManager.primaryDark,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.s16)),
              Text(
                'october 28, 2022',
                style: TextStyle(
                    color: ColorManager.greyLight,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Spacer(),
          Text(
            '-34',
            style: TextStyle(
                color: ColorManager.black,
                fontWeight: FontWeight.w600,
                fontSize: FontSize.s16),
          ),
          SizedBox(width: AppSize.s20,)
        ],
      ),
    );
  }
}
