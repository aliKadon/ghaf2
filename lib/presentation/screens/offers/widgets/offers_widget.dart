import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';

import '../../../resources/values_manager.dart';

class OffersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      child: Row(
        children: [
          Image.asset(
            ImageAssets.brIcon,
            height: AppSize.s75,
          ),
          SizedBox(width: AppSize.s15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '10 AED off on selected items',
                style: TextStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w600
                ),
              ),
              Text(
                'valid from 19 january, 2023',
                style: TextStyle(
                    color: ColorManager.greyLight,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Baskin robbins',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Price on selection',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
