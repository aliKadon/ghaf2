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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CartItemWidget extends StatefulWidget {
  int? index;

   CartItemWidget({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  // controller.
  // late final CartItem _cartItem = Get.find<CartItem>(
  //   tag: widget.index.toString(),
  // );
  late final CartItem _cartItem = Get.put(CartItem());
  late final CartViewGetXController _cartViewGetXController =
      Get.find<CartViewGetXController>();


  //  File file =  File('path/to/image.png');
  // Uint8List? imageData = await file.readAsBytesSync();

  // Future<Uint8List> getImageData() async {
  //   File file = File('assets/images/checkout.png');
  //   return file.readAsBytes();
  // }

  // String imageData = 'iVBORw0KGgoAAAANSUhEUgAAAO8AAADSCAMAAACVSmf4AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAADDUExURf///8ESHAAAAPb29sXFxePj48AAEp2dnWxsbENDQ8xSVsAACtaAg7wAAPz8/LOzs/Ly8uzs7OTk5MzMzNra2tLS0rm5udbW1qOjo93d3YeHh5CQkL+/v6urq4+Pj29vb4GBgWNjY0tLS1hYWIODg3h4eDs7O09PTy8vLzQ0NCgoKNR5e/Pa2/rv8Dg4OOa0tRsbG+rAwd6cnfbj5MhFScEdI+m+v9Fvce/P0NqQkuKoqc1dYM9jZsQvNMdBRcQ1ORYWFs4biS8AAA64SURBVHhe7Z1rf9o2FIdJgQBNsbk6gLmDQ5Jubdet3bqtXb//p9o5R8eWDZJsYy62fzxvKi5JObHQI8t/QeXGjRs3bty4cePGjQJiIdwuOVBotdpBqtXyFw3Fdrrd+ngwGIzr3W4HSuZHSolldbr1Qb82dRxnWus/1rFifqyEwMHtPdacWcN153O3MXNqj71ueQu2qt1x3xm53ma9WSw2u+Z85PTHpS0Yy63NXK/l9alCq7/cuLNaWQsW5c6b6wHfAYw329IWbHXq/dl8teKbzGI5q9U7JazXqvaGttvcUPvzjy9ffnymKldze9gr3wGG3jyYNhbPHWj/1m7f393dt9tf4UZn3XAG5evR0Jtrs+V6BM2/2ndM+ze4OWuOytej4fAO7flqjc0HrhZoV+GOzcQeluwAw7xqPG14z2Novw8O793dw59wx3jXmA66pZpYwmDVn213E2j+EioXDvBfcNfcm/VL1aOhNz86bvMZ299hqJLcf8f71nP7sUw9GnpzbeS91KD5OXJ44QB/gztrm0ZtXJ4DjOqdTTYLaP6+Vy4U/Dvc7W1n/dJImNX7iup9G+nNyP0fcHe15Tql6dGo3tGyNYPmx4PDCwf4Izxgl0fCrN4dNkPqlbR/hYdWpZGwUO8rqvdPZb0k4d66JBK';

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
    // print('================================data');
    // print(_cartItem.product!.ghafImage);
    return Dismissible(
      key: ValueKey<int>(widget.index!),
      onDismissed: (DismissDirection direction) {
        _cartViewGetXController.removeCartItem(index: widget.index!);
        _cartItem.toggleAddToCartRequest();
      },
      background: Container(
        padding: EdgeInsets.all(8),
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
                child:_cartItem.product?.productImages?.length == 0 ?
                Image.asset(
                  'assets/images/product_image.png',
                  height: AppSize.s84,
                  width: AppSize.s77,
                  fit: BoxFit.cover,
                ) :
                Image.network(
                  _cartItem.product!.productImages![0] ,
                  height: AppSize.s84,
                  width: AppSize.s77,
                  // fit: BoxFit.fill,
                )
                // child: Icon(Icons.add),
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
                  // Text(
                  //   _cartItem.product?.description!.substring(0,20) ?? '',
                  //
                  //   style: getRegularStyle(
                  //
                  //     color: ColorManager.grey,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: AppSize.s8,
                  // ),
                  if (_cartItem.product?.productDiscount == null)
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.no_discount,
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
                          '${((_cartItem.product!.price!-(_cartItem.product!.price! * _cartItem.product!.productDiscount!.discount! / 100)).toStringAsFixed(1))} AED',
                          style: getRegularStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s16,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          '${_cartItem.product?.price} ${AppLocalizations.of(context)!.aed}',
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
                    // _cartItem.increment(
                    //   context: context,
                    // );
                    // _cartViewGetXController.calculateBell();
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
                          index: widget.index!);
                      _cartItem.toggleAddToCartRequest();
                    } else {
                      // _cartItem.decrement(
                      //   context: context,
                      // );
                      // _cartViewGetXController.calculateBell();
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
          Divider(height: 2, color: ColorManager.grey),
          SizedBox(
            height: AppSize.s17,
          ),
        ],
      ),
    );
  }
}
