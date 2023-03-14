import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../domain/model/cart_item.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import '../screens/cart_view/cart_view_getx_controller.dart';

class CartWidgetNew extends StatefulWidget {
  final int index;
  final String image;
  final String name;
  final String idProduct;
  final num price;
  final String isoCurrencySymbol;
  final num productCount;
  final String cartItemId;

  CartWidgetNew(
      {required this.index,
      required this.isoCurrencySymbol,
      required this.price,
      required this.name,
      required this.idProduct,
      required this.image,
      required this.cartItemId,
      required this.productCount});

  @override
  State<CartWidgetNew> createState() => _CartWidgetNewState();
}

class _CartWidgetNewState extends State<CartWidgetNew> {
  //controller
  late final CartItem _cartItem = Get.put<CartItem>(CartItem());
  late final CartViewGetXController _cartViewGetXController =
      Get.find<CartViewGetXController>();

  var selected = 0;
  num count = 0;

  @override
  void initState() {
    count = widget.productCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: AppSize.s110,
              width: AppSize.s110,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.image,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      color: ColorManager.primaryDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
                Text(
                  'item ${_cartViewGetXController.cartItems[widget.index].productCount!}',
                  style: TextStyle(
                      color: ColorManager.greyLight,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
                SizedBox(height: 20),
                Text(
                  '${widget.price} ${widget.isoCurrencySymbol}',
                  style: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = widget.index;
                          count++;
                          // count = widget.productCount;
                        });
                        _cartItem.increment(
                            idProduct: widget.cartItemId,
                            productCount1: _cartViewGetXController.cartItems[widget.index].productCount!,
                            context: context);
                        _cartViewGetXController.calculateBell();

                        // _cartItem.increment(
                        //     context: context,
                        //     productCount: count,
                        //     idProduct: widget.idProduct);
                      },

                      child: Icon(
                        Icons.add_circle_outline,
                        color: ColorManager.primary,
                      )),
                  Text(_cartViewGetXController.cartItems[widget.index].productCount!.toString()),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = widget.index;
                          count--;
                          // count = widget.productCount;
                        });
                        _cartItem.decrement(
                            idProduct: widget.cartItemId,
                            productCount: _cartViewGetXController.cartItems[widget.index].productCount!,
                            context: context);
                        _cartViewGetXController.calculateBell();
                      },
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: ColorManager.primary,
                      ))
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: AppSize.s16,
        )
      ],
    );
  }
}
