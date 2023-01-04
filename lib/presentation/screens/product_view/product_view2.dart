import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ghaf_application/domain/model/product2.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/product.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ProductView2 extends StatefulWidget {

  final Product2 product2;

  ProductView2(this.product2);



  @override
  State<ProductView2> createState() => _ProductView2State();
}

class _ProductView2State extends State<ProductView2> {

  // final int cost = 0;

  // void getStoreDelevery(Product2 product2, int cost) {
  //   for(int i = 0 ; i < 4; i++) {
  //     if (product2.branch!['storeDeliveryCost']['methodName'] == 'Delivery'){
  //       cost = int.parse(product2.branch!['storeDeliveryCost']['cost']);
  //     }
  //   }
  //
  // }

  var isAdded = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cost = widget.product2.branch!['storeDeliveryCost'][2]['cost'];
    print('===============================const');
    print(cost);
    // getStoreDelevery(widget.product2,cost);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p16, vertical: AppPadding.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    widget.product2.name ?? '',
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s12,
            ),
            Expanded(
              child: Stack(
                children: [
                  widget.product2.ghafImage == null
                      ? SizedBox(
                    height: 350.h,
                    width: double.infinity,
                    child: Icon(
                      Icons.broken_image,
                    ),
                  )
                      : Image.memory(
                    base64Decode(widget.product2.ghafImage?[0]['data'] ?? ''),
                    width: double.infinity,
                    height: 350.h,
                    fit: BoxFit.fill,
                  ),
                  // PositionedDirectional(
                  //   top: 10,
                  //   start: 20,
                  //   child: Container(
                  //     height: AppSize.s31,
                  //     width: AppSize.s125,
                  //     decoration: BoxDecoration(
                  //       color: ColorManager.white,
                  //       borderRadius: BorderRadius.circular(AppRadius.r4),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           width: AppSize.s9,
                  //         ),
                  //         Image.asset(
                  //           IconsAssets.clock,
                  //           height: AppSize.s20,
                  //           width: AppSize.s18,
                  //         ),
                  //         SizedBox(
                  //           width: AppSize.s10,
                  //         ),
                  //         Text(
                  //           '20 - 40',
                  //           style: getRegularStyle(
                  //             color: ColorManager.grey,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: AppSize.s7,
                  //         ),
                  //         Text(
                  //           'min',
                  //           style: getRegularStyle(
                  //             color: ColorManager.grey,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      width: double.infinity,
                      height: AppSize.s326,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppRadius.r39),
                          topRight: Radius.circular(AppRadius.r39),
                        ),
                        color: ColorManager.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p16,
                            vertical: AppPadding.p24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.product2.name ?? '',
                                  style: getRegularStyle(
                                      color: ColorManager.primaryDark,
                                      fontSize: FontSize.s26),
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$ ${widget.product2.price!.toStringAsFixed(1)}',
                                      style: TextStyle(
                                        fontSize: FontSize.s14,
                                        fontFamily: FontConstants.fontFamily,
                                        color: ColorManager.grey,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    if (widget.product2.productDiscount != null) ...[
                                      SizedBox(height: AppSize.s4),
                                      Text(
                                        '\$ ${((widget.product2.price! * widget.product2.productDiscount!['discount']! / 100).toStringAsFixed(1))}',
                                        style: getBoldStyle(
                                            color: ColorManager.primary,
                                            fontSize: FontSize.s26),
                                      )
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSize.s6,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  IconsAssets.start,
                                  height: AppSize.s17,
                                  width: AppSize.s18,
                                  color: (widget.product2.stars ?? 0) >= 1
                                      ? null
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: AppSize.s2,
                                ),
                                Image.asset(
                                  IconsAssets.start,
                                  height: AppSize.s17,
                                  width: AppSize.s18,
                                  color: (widget.product2.stars ?? 0) >= 2
                                      ? null
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: AppSize.s2,
                                ),
                                Image.asset(
                                  IconsAssets.start,
                                  height: AppSize.s17,
                                  width: AppSize.s18,
                                  color: (widget.product2.stars ?? 0) >= 3
                                      ? null
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: AppSize.s2,
                                ),
                                Image.asset(
                                  IconsAssets.start,
                                  height: AppSize.s17,
                                  width: AppSize.s18,
                                  color: (widget.product2.stars ?? 0) >= 4
                                      ? null
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: AppSize.s2,
                                ),
                                Image.asset(
                                  IconsAssets.start,
                                  height: AppSize.s17,
                                  width: AppSize.s18,
                                  color: (widget.product2.stars ?? 0) >= 5
                                      ? null
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: AppSize.s6,
                                ),
                                Text(
                                  '(${widget.product2.productReview ?? '0'})',
                                  style: getRegularStyle(
                                      color: ColorManager.grey,
                                      fontSize: FontSize.s14),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                            Text(
                              widget.product2.description ?? '',
                              style: getRegularStyle(
                                color: ColorManager.grey,
                              ),
                            ),
                            SizedBox(
                              height: AppSize.s30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Container(
                                //   height: AppSize.s52,
                                //   width: AppSize.s154,
                                //   decoration: BoxDecoration(
                                //     borderRadius:
                                //         BorderRadius.circular(AppRadius.r40),
                                //     border: Border.all(
                                //         width: AppSize.s1,
                                //         color: ColorManager.greyLight),
                                //   ),
                                //   child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceEvenly,
                                //       children: [
                                //         Image.asset(
                                //           IconsAssets.minus,
                                //           height: AppSize.s24,
                                //           width: AppSize.s7,
                                //         ),
                                //         VerticalDivider(
                                //             width: AppSize.s1,
                                //             color: ColorManager.greyLight),
                                //         Text(
                                //           '1',
                                //           style: getRegularStyle(
                                //               color: ColorManager.black,
                                //               fontSize: FontSize.s16),
                                //         ),
                                //         VerticalDivider(
                                //             width: AppSize.s1,
                                //             color: ColorManager.greyLight),
                                //         Image.asset(
                                //           IconsAssets.plus,
                                //           height: AppSize.s24,
                                //           width: AppSize.s12,
                                //         ),
                                //       ]),
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    Provider.of<ProductProvider>(context,listen: false).addToCart(widget.product2.id!);
                                    setState(() {
                                      isAdded = !isAdded;
                                    });
                                    // widget.product2.toggleIsAddToCart(
                                    //     context: context);
                                  },
                                  // child: GetBuilder<Product>(
                                  //   id: 'isInCart',
                                  //   // tag: widget.tag,
                                  //   builder: (controller) => Container(
                                      child : Container(
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      width: MediaQuery.of(context).size.height * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppRadius.r14),
                                        color: isAdded
                                            ? Colors.red
                                            : ColorManager.primary,
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              IconsAssets.bag,
                                              height: AppSize.s20,
                                              width: AppSize.s20,
                                            ),
                                            SizedBox(
                                              width: AppSize.s8,
                                            ),
                                            Text(
                                              isAdded
                                                  ? 'Remove from cart'
                                                  : 'Add to Cart',
                                              style: getRegularStyle(
                                                  color: ColorManager.white,
                                                  fontSize: FontSize.s14),
                                            ),
                                          ]),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 311,
                    end: 30,
                    child: Container(
                      height: AppSize.s30,
                      width: AppSize.s130,
                      decoration: BoxDecoration(
                        color: ColorManager.primaryDark,
                        borderRadius: BorderRadius.circular(AppRadius.r4),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.primaryDark,
                            spreadRadius: 2,
                            blurRadius: AppSize.s20,
                            offset: Offset(
                                AppSize.s2, AppSize.s2), // Shadow position
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AED $cost deliver',
                            style: getRegularStyle(
                              color: ColorManager.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}