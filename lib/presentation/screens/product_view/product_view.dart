import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/screens/product_view/product_view_getx_controller.dart';
import 'package:provider/provider.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../../providers/product_provider.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ProductView extends StatefulWidget {
  final String tag;

  const ProductView({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  // controller.
  late final ProductViewGetXController _productViewGetXController =
      Get.put(ProductViewGetXController());
  late final Product _product = Get.find<Product>(tag: widget.tag);

  var isLoading = true;

  // init state.
  @override
  void initState() {
    _productViewGetXController.init(
      context: context,
    );
    Provider.of<ProductProvider>(context, listen: false)
        .getProductById(_product.id!)
        .then((value) => isLoading = false);
    super.initState();
  }

  // dispose.
  @override
  void dispose() {
    Get.delete<ProductViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var product2 = Provider.of<ProductProvider>(context).productById;
    // var cost = widget.product?.branch!.storeDeliveryCost![2]['cost'];
    // var cost = _product.branch.details.
    // var cost = _product.branch?.storeDeliveryCost?[0].cost;
    print('=================================cost');
    // print(product2['branch']['storeDeliveryCost'][2]['cost']);
    return Scaffold(
      body: SafeArea(
        child: product2.isEmpty
            ? Center(

                child: Container(
                  width: 20.h,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              )
            : Column(
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
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.038,
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: Image.asset(
                              SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                              height: AppSize.s18,
                              width: AppSize.s10,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          _product.name ?? '',
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
                        _product.ghafImage!.isEmpty
                            ? Image.asset(
                                'assets/images/product_image.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                _product.ghafImage?[0].data ?? '',
                                width: double.infinity,
                                height: 400.h,
                                // fit: BoxFit.cover,
                              ),
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
                                        _product.name ?? '',
                                        style: getRegularStyle(
                                            color: ColorManager.primaryDark,
                                            fontSize: FontSize.s26),
                                      ),
                                      Spacer(),
                                      if (_product.productDiscount != null) ...[
                                        // SizedBox(height: AppSize.s4),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${((_product.price! - (_product.price! * _product.productDiscount!.discount! / 100)).toStringAsFixed(1))} AED',
                                              style: getBoldStyle(
                                                  color: ColorManager.red,
                                                  fontSize: FontSize.s26),
                                            ),
                                            Text(
                                              '${_product.price!.toStringAsFixed(1)}',
                                              style: TextStyle(
                                                fontSize: FontSize.s14,
                                                fontFamily:
                                                    FontConstants.fontFamily,
                                                color: ColorManager.grey,
                                                fontWeight: FontWeight.w400,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          if (_product.productDiscount == null)
                                            Text(
                                              '${_product.price!.toStringAsFixed(1)} ${AppLocalizations.of(context)!.aed}',
                                              style: TextStyle(
                                                fontSize: FontSize.s20,
                                                fontFamily:
                                                    FontConstants.fontFamily,
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
                                        "${_product.storeStars}",
                                        style: TextStyle(fontSize: FontSize.s16),
                                      ),
                                      _product),
                                  SizedBox(
                                    height: AppSize.s10,
                                  ),
                                  Text(
                                    _product.description ?? '',
                                    style: getRegularStyle(
                                      color: ColorManager.grey,
                                    ),
                                    maxLines: 5,
                                  ),
                                  SizedBox(
                                    height: AppSize.s30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                          _product.toggleIsAddToCart(
                                              context: context);
                                        },
                                        child: GetBuilder<Product>(
                                          id: 'isInCart',
                                          tag: widget.tag,
                                          builder: (controller) => Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppRadius.r14),
                                              color: controller.isInCart!
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
                                                    controller.isInCart!
                                                        ? AppLocalizations.of(
                                                                context)!
                                                            .remove_from_cart
                                                        : AppLocalizations.of(
                                                                context)!
                                                            .add_to_cart,
                                                    style: getRegularStyle(
                                                        color:
                                                            ColorManager.white,
                                                        fontSize: FontSize.s14),
                                                  ),
                                                ]),
                                          ),
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
                                  offset: Offset(AppSize.s2,
                                      AppSize.s2), // Shadow position
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.aed} ${product2['branch']['storeDeliveryCost'][2]['cost']} deliver',
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

  Widget buildRating(Widget ifYouNeedRate, Product _product) => Row(
        children: [
          RatingBar.builder(
              initialRating: _product.storeStars!.toDouble(),
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
