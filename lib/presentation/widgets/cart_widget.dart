import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../domain/model/cart_item.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import '../screens/cart_view/cart_view_getx_controller.dart';

class CartWidget extends StatefulWidget {
  final int index;
  final String image;
  final String name;
  final String idProduct;
  final num price;
  final String isoCurrencySymbol;
  final num productCount;

  CartWidget(
      {required this.index,
      required this.isoCurrencySymbol,
      required this.price,
      required this.name,
      required this.idProduct,
      required this.image,
      required this.productCount});


  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {


  // late final CartViewGetXController _cartViewGetXController =
  //     Get.put(CartViewGetXController());

  late final CartItem _cartItem = Get.put(CartItem());
  @override
  void initState() {
    // _cartViewGetXController.init(
    //   context: context,
    // );
    super.initState();
  }

  var selected = 0;

  var count = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
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
                GetBuilder<CartItem>(
                  id: 'productCount',
                  builder: (controller) => Text(
                    'item ${widget.productCount}',
                    style: TextStyle(
                        color: ColorManager.greyLight,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
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
                        // _cartItem.increment(
                        //     context: context,
                        //     productCount: count,
                        //     idProduct: widget.idProduct);
                        setState(() {
                          selected = widget.index;
                          count++;
                        });
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
                        });
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
