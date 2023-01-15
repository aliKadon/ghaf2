import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    // print('===============================const');
    // print(cost);
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
            // SizedBox(
            //   height: AppSize.s12,
            // ),
            Expanded(
              child: Stack(
                children: [
                  widget.product2.ghafImage == null
                      ? Image.asset('assets/images/product_image.png',fit: BoxFit.cover,)
                      : Image.network(
                    widget.product2.ghafImage?[0]['data'],
                    width: double.infinity,
                    height: 400.h,
                    // fit: BoxFit.fill,
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
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),

                        ),
                        color: ColorManager.whiteLight,
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
                                if (widget.product2.productDiscount != null) ...[
                                  // SizedBox(height: AppSize.s4),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                      Text(
                                        '${((widget.product2.price!-(widget.product2.price! * widget.product2.productDiscount!['discount']! / 100)).toStringAsFixed(1))} AED',
                                        style: getBoldStyle(
                                            color: ColorManager.red,
                                            fontSize: FontSize.s26),
                                      ),
                                      Text(
                                        '${widget.product2.price!.toStringAsFixed(1)}',
                                        style: TextStyle(
                                          fontSize: FontSize.s14,
                                          fontFamily: FontConstants.fontFamily,
                                          color: ColorManager.grey,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (widget.product2.productDiscount == null)
                                    Text(
                                      '${widget.product2.price!.toStringAsFixed(1)} AED',
                                      style: TextStyle(
                                        fontSize: FontSize.s20,
                                        fontFamily: FontConstants.fontFamily,
                                        color: ColorManager.grey,
                                        fontWeight: FontWeight.w400,
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSize.s6,
                            ),
                            buildRating(
                                Text(
                                  "${widget.product2.storeStars}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                widget.product2),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                            Text(
                              '${widget.product2.description }' ?? '',
                              maxLines:5 ,
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
                            blurRadius: AppSize.s10,
                            offset: Offset(
                                AppSize.s2, AppSize.s2), // Shadow position
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' AED $cost deliver',
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
  Widget buildRating(Widget ifYouNeedRate, Product2 product2) => Row(
    children: [
      RatingBar.builder(
          initialRating: product2.storeStars!.toDouble(),
          minRating: 1,
          itemSize: 20,
          updateOnDrag: false,
          allowHalfRating: true,
          ignoreGestures: true,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          }),
      SizedBox(
        width: 5,
      ),
      ifYouNeedRate,
    ],
  );
}