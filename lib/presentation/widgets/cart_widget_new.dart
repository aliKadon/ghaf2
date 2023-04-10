import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:provider/provider.dart';

import '../../domain/model/cart_item.dart';
import '../../providers/product_provider.dart';
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
  num count = 1;

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
            widget.image == ''
                ? Container(
                    height: AppSize.s110,
                    width: AppSize.s110,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImageAssets.logo1)),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  )
                : Container(
                    height: AppSize.s110,
                    width: AppSize.s110,
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: NetworkImage(widget.image)),
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
                  'item ${count!}',
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

                        // _cartItem.increment(
                        //     idProduct: widget.cartItemId,
                        //     productCount1: count,
                        //     context: context);
                        _cartViewGetXController.changeCartAmount(
                            context: context,
                            cartItemId:
                                _cartViewGetXController.cartItems[selected].id!,
                            count: count);
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
                  Text(count.toString()),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = widget.index;
                          count--;
                          // count = widget.productCount;
                        });
                        if (count == 0) {
                          print('==================it is 0');
                          Provider.of<ProductProvider>(context, listen: false)
                              .addOrRemoveFromCard(productId: widget.idProduct)
                              .then((value) =>
                                  _cartViewGetXController.getMyCart());
                        }
                        // _cartItem.decrement(
                        //     idProduct: widget.cartItemId,
                        //     productCount: count,
                        //     context: context);
                        _cartViewGetXController.changeCartAmount(
                            context: context,
                            cartItemId:
                            _cartViewGetXController.cartItems[selected].id!,
                            count: count);
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
