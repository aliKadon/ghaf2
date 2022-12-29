import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

class ProductWidget extends StatefulWidget {
  final String tag;
  final int? minProductCountForGift;
  final int? giftCount;

  const ProductWidget({
    Key? key,
    required this.tag,
    this.minProductCountForGift,
    this.giftCount,
  }) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  // controller.
  late final Product _product = Get.find<Product>(
    tag: widget.tag,
  );

  // dispose.
  @override
  void dispose() {
    Get.delete<Product>(tag: widget.tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productRoute,
          arguments: widget.tag,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.r14),
                child: Container(
                  height: AppSize.s211,
                  width: AppSize.s154,
                  color: Colors.grey,
                  child: _product.ghafImage!.isEmpty
                      ? Icon(
                          Icons.broken_image,
                        )
                      : Image.memory(
                          base64Decode(_product.ghafImage![0].data!),
                          height: AppSize.s211,
                          width: AppSize.s154,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) =>
                              Center(
                            child: Icon(
                              Icons.broken_image,
                            ),
                          ),
                        ),
                ),
              ),
              if (widget.minProductCountForGift != null)
                PositionedDirectional(
                  start: 0,
                  end: 0,
                  top: -55,
                  child: Image.asset(
                    '${Constants.imagesPath}gift.png',
                  ),
                ),
              if (widget.minProductCountForGift != null)
                PositionedDirectional(
                  start: 0,
                  end: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(14.r)),
                    ),
                    child: Center(
                      child: Text(
                        'Buy ${widget.minProductCountForGift} get ${widget.giftCount} free',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              PositionedDirectional(
                end: AppSize.s12,
                top: AppSize.s12,
                child: InkWell(
                  onTap: () {
                    _product.toggleIsFavorite(context: context);
                  },
                  child: GetBuilder<Product>(
                    id: 'isFavorite',
                    tag: widget.tag,
                    builder: (controller) => CircleAvatar(
                      radius: AppRadius.r14,
                      backgroundColor: ColorManager.burgundy,
                      child: Image.asset(
                        controller.isFavorite!
                            ? IconsAssets.heart1
                            : IconsAssets.heart,
                        height: AppSize.s16,
                        width: AppSize.s16,
                        color:
                            controller.isFavorite! ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsetsDirectional.only(start: AppPadding.p22),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              _product.name ?? '',
              style: getSemiBoldStyle(
                color: ColorManager.primaryDark,
                fontSize: FontSize.s14,
              ),
            ),
          ),
          SizedBox(
            height: AppSize.s4,
          ),
          Container(
            padding: EdgeInsetsDirectional.only(start: AppPadding.p22),
            alignment: AlignmentDirectional.topStart,
            child: Text(
              _product.branch?.branchName ?? '',
              style: getRegularStyle(
                color: ColorManager.grey,
                fontSize: FontSize.s10,
              ),
            ),
          ),
          SizedBox(
            height: AppSize.s8,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: AppPadding.p22),
            child: Row(
              children: [
                if (_product.productDiscount != null) ...[
                  Text(
                    '\$ ${(_product.price! * (_product.productDiscount!.discount! / 100)).toStringAsFixed(1)}',
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                    ),
                  ),
                  SizedBox(width: AppSize.s10),
                ],
                Text(
                  '\$${_product.price!.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: FontSize.s10,
                    fontFamily: FontConstants.fontFamily,
                    color: ColorManager.grey,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Spacer(),
                Image.asset(
                  IconsAssets.start,
                  height: AppSize.s14,
                  width: AppSize.s15,
                ),
                SizedBox(
                  width: AppSize.s8,
                ),
                Text(
                  _product.productReview ?? '',
                  style: getRegularStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s12,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
