import 'package:flutter/material.dart';
import 'package:ghaf_application/domain/model/category.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;

  const CategoryWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.products,
          arguments: category.id,
        );
      },
      child: Container(
        width: AppSize.s92,
        padding: EdgeInsetsDirectional.only(
          end: AppSize.s8,
        ),
        child: Column(
          children: [
            Container(
              height: AppSize.s60,
              width: AppSize.s60,
              padding: EdgeInsets.all(AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                border: Border.all(
                    width: AppSize.s0_5, color: ColorManager.greyLight),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.greyLight,
                    blurRadius: AppSize.s4,
                    offset: Offset(AppSize.s0, AppSize.s4), // Shadow position
                  ),
                ],
                borderRadius: BorderRadius.circular(AppRadius.r4),
              ),
              child: Image.asset(
                IconsAssets.cart,
                height: AppSize.s36,
                width: AppSize.s36,
              ),
            ),
            SizedBox(
              height: AppSize.s6,
            ),
            Flexible(
              child: Text(
                category.name ?? '',
                overflow: TextOverflow.ellipsis,
                style: getMediumStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
