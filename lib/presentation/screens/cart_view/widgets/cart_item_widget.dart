import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/domain/model/cart_item.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/cart_view/cart_view_getx_controller.dart';

class CartItemWidget extends StatefulWidget {
  final int index;

  const CartItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  // controller.
  late final CartItem _cartItem = Get.find<CartItem>(
    tag: widget.index.toString(),
  );
  late final CartViewGetXController _cartViewGetXController =
      Get.find<CartViewGetXController>();

  // dispose.
  @override
  void dispose() {
    Get.delete<CartItem>(
      tag: widget.index.toString(),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<int>(widget.index),
      onDismissed: (DismissDirection direction) {
        _cartViewGetXController.removeCartItem(index: widget.index);
        _cartItem.toggleAddToCartRequest();
      },
      background: Container(
        margin: EdgeInsetsDirectional.only(end: 290),
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        width: AppSize.s55,
        height: AppSize.s84,
        child: Image.asset(
          ImageAssets.deleted,
          width: AppSize.s32,
          height: AppSize.s32,
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.r8),
                child: Image.memory(
                  base64Decode(_cartItem.product?.ghafImage?[0].data ?? ''),
                  height: AppSize.s84,
                  width: AppSize.s77,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: AppSize.s12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _cartItem.product?.name ?? '',
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s6,
                  ),
                  Text(
                    _cartItem.product?.description ?? '',
                    style: getRegularStyle(
                      color: ColorManager.grey,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s8,
                  ),
                  if (_cartItem.product?.productDiscount == null)
                    Row(
                      children: [
                        Text(
                          '99 AED',
                          style: getRegularStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s16,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Text(
                          '${_cartItem.product?.productDiscount!.discount} AED',
                          style: getRegularStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s16,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          '${_cartItem.product?.price} AED',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              Spacer(),
              Column(children: [
                InkWell(
                  onTap: () {
                    _cartItem.increment(
                      context: context,
                    );
                    _cartViewGetXController.calculateBell();
                  },
                  child: Image.asset(
                    IconsAssets.plus1,
                    height: AppSize.s31,
                    width: AppSize.s31,
                  ),
                ),
                GetBuilder<CartItem>(
                  id: 'productCount',
                  tag: widget.index.toString(),
                  builder: (controller) => Text(
                    (controller.productCount ?? 0).toString(),
                    style: getRegularStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_cartItem.productCount == 1) {
                      _cartViewGetXController.removeCartItem(
                          index: widget.index);
                      _cartItem.toggleAddToCartRequest();
                    } else {
                      _cartItem.decrement(
                        context: context,
                      );
                      _cartViewGetXController.calculateBell();
                    }
                  },
                  child: Image.asset(
                    IconsAssets.minus1,
                    height: AppSize.s31,
                    width: AppSize.s31,
                  ),
                ),
              ]),
            ],
          ),
          SizedBox(
            height: AppSize.s17,
          ),
          Divider(height: 1, color: ColorManager.grey),
          SizedBox(
            height: AppSize.s17,
          ),
        ],
      ),
    );
  }
}
