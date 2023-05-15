import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/screens/cart_view/cart_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/product_view/product_view_getx_controller.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/utils/helpers.dart';
import '../../../domain/model/product.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ProductViewNew extends StatefulWidget {
  final String idProduct;
  bool? isFromChekOut;
  String? orderId;
  num? minOrder;

  ProductViewNew(
      {required this.idProduct,
      this.isFromChekOut,
      this.orderId,
      this.minOrder});

  @override
  State<ProductViewNew> createState() => _ProductViewNewState();
}

class _ProductViewNewState extends State<ProductViewNew> with Helpers {
  var isLoading = true;

  late final ProductViewGetXController _productViewGetXController =
      Get.put(ProductViewGetXController());
  final CartViewGetXController _cartViewGetXController =
      Get.put(CartViewGetXController());
  final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());

  late final Product _product = Get.put<Product>(Product());

  @override
  void initState() {
    print('=====================isFromCheckOut');
    print(widget.isFromChekOut);
    print(widget.idProduct);
    print(widget.orderId);
    _productViewGetXController.init(
      context: context,
    );
    super.initState();
  }

  var language = SharedPrefController().lang1;

  // dispose.
  @override
  void dispose() {
    Get.delete<ProductViewGetXController>();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    Provider.of<ProductProvider>(context)
        .getProductById(widget.idProduct)
        .then((value) => isLoading = false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var productById =
        Provider.of<ProductProvider>(context, listen: false).productById;
    var provider = Provider.of<ProductProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        _cartViewGetXController.getMyCart();
        _cartViewGetXController.calculateBell();
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(
                child: Container(
                  width: AppSizeWidth.s20,
                  height: AppSize.s20,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              )
            : SafeArea(
                child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            _cartViewGetXController.getMyCart();
                            _cartViewGetXController.calculateBell();
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.038,
                              width: MediaQuery.of(context).size.width * 0.08,
                              child: Image.asset(
                                SharedPrefController().lang1 == 'ar'
                                    ? IconsAssets.arrow2
                                    : IconsAssets.arrow,
                                height: AppSize.s18,
                                width: AppSizeWidth.s10,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          AppLocalizations.of(context)!.my_cart,
                          style: getSemiBoldStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    Divider(height: 1, color: ColorManager.greyLight),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Stack(
                        children: [
                          productById["productImages"].length == 0
                              ? Image.asset(ImageAssets.logo1,
                                  fit: BoxFit.scaleDown,
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4)
                              : Image.network(
                                  productById["productImages"][0],
                                  fit: BoxFit.scaleDown,
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(ImageAssets.logo1,
                                        fit: BoxFit.scaleDown,
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4);
                                  },
                                ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: AppSize.s300,
                            // bottom: -10,
                            child: Container(
                              padding: EdgeInsets.all(AppSize.s20),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(50),
                                color: Colors.white,
                              ),
                              height: MediaQuery.of(context).size.height * 1,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: AppSize.s30,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Text(
                                              language == 'en'
                                                  ? productById["name"]
                                                  : productById["nameAr"] ??
                                                      productById["name"],
                                              overflow: TextOverflow.clip,
                                              style: getSemiBoldStyle(
                                                color: ColorManager.primaryDark,
                                                fontSize: FontSize.s22,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: AppSizeWidth.s73
                                            ,
                                            child: Text(
                                              '${productById["price"]} ${AppLocalizations.of(context)!.aed}',
                                              overflow: TextOverflow.clip,
                                              style: getSemiBoldStyle(
                                                color: ColorManager.primary,
                                                fontSize: FontSize.s16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          RatingBar.builder(
                                              initialRating: double.parse(
                                                  productById["stars"]
                                                      .toString()),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                          ),
                                          Text(
                                            '(${productById["reviewCount"]} reviews)',
                                            style: getSemiBoldStyle(
                                              color: ColorManager.greyLight,
                                              fontSize: FontSize.s10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      Text(
                                        language == 'en'
                                            ? productById["description"]
                                            : productById["description"],
                                        style: getSemiBoldStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s14,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Positioned(
                          //   left: 20,
                          //   top: 20,
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(horizontal: 12),
                          //     child: Container(
                          //       height: AppSize.s46,
                          //       width: AppSize.s110,
                          //       decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(AppSize.s10)),
                          //       child: Row(
                          //         children: [
                          //           Icon(Icons.timer,
                          //               color: ColorManager.primaryDark),
                          //           SizedBox(
                          //             width: AppSize.s26,
                          //           ),
                          //           Text(productById["timeToPrepareMinutes"]
                          //                   .toString() ??
                          //               '20 - 40 min')
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // PositionedDirectional(
                          //   bottom: 390,
                          //   end: 30,
                          //   child: Container(
                          //     height: AppSize.s30,
                          //     width: AppSize.s130,
                          //     decoration: BoxDecoration(
                          //       color: ColorManager.primaryDark,
                          //       borderRadius:
                          //           BorderRadius.circular(AppRadius.r4),
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: ColorManager.primaryDark,
                          //           spreadRadius: 2,
                          //           blurRadius: AppSize.s20,
                          //           offset: Offset(AppSize.s2,
                          //               AppSize.s2), // Shadow position
                          //         ),
                          //       ],
                          //     ),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           '${AppLocalizations.of(context)!.aed} ${(productById["branch"]["storeDeliveryCost"] ?? 0)} deliver',
                          //           style: getRegularStyle(
                          //             color: ColorManager.white,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: EdgeInsets.all(AppSize.s15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      topLeft: Radius.circular(50)),
                                  color: Colors.white,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: AppSizeWidth.s50,
                                child: Row(
                                  children: [
                                    Spacer(),
                                    widget.isFromChekOut != null &&
                                            widget.isFromChekOut!
                                        ? ElevatedButton(
                                            onPressed: () {
                                              if (AppSharedData.currentUser ==
                                                  null) {
                                                showSignInSheet(
                                                    context: context,
                                                    role: 'Customer');
                                              } else {
                                                _checkOutGetxController
                                                    .addItems(
                                                        context: context,
                                                        orderId:
                                                            widget.orderId!,
                                                        productId:
                                                            widget.idProduct);
                                              }
                                            },
                                            style: ButtonStyle(
                                                shape: MaterialStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)))),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .add_to_order,
                                              // 'Login',
                                              style: getSemiBoldStyle(
                                                  color: ColorManager.white,
                                                  fontSize: FontSize.s18),
                                            ),
                                          )
                                        : productById["isInCart"] == false
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  if (AppSharedData
                                                          .currentUser ==
                                                      null) {
                                                    showSignInSheet(
                                                        context: context,
                                                        role: 'Customer');
                                                  } else {
                                                    print(
                                                        '============================min order');
                                                    print(widget.minOrder);

                                                    // _cartViewGetXController.calculate(minOrder1: widget.minOrder!);
                                                    Provider.of<ProductProvider>(
                                                            context,
                                                            listen: false)
                                                        .addOrRemoveFromCard(
                                                            productId: widget
                                                                .idProduct)
                                                        .then((value) =>
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                  provider
                                                                      .message),
                                                              backgroundColor:
                                                                  Colors.green,
                                                            )));
                                                    _cartViewGetXController
                                                        .calculateBell(
                                                            minOrder1: widget
                                                                .minOrder);
                                                  }
                                                },
                                                style: ButtonStyle(
                                                    shape: MaterialStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)))),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .add_to_cart,
                                                  // 'Login',
                                                  style: getSemiBoldStyle(
                                                      color: ColorManager.white,
                                                      fontSize: FontSize.s18),
                                                ),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  if (AppSharedData
                                                          .currentUser ==
                                                      null) {
                                                    showSignInSheet(
                                                        context: context,
                                                        role: 'Customer');
                                                  } else {
                                                    Provider.of<ProductProvider>(
                                                            context,
                                                            listen: false)
                                                        .addOrRemoveFromCard(
                                                            productId: widget
                                                                .idProduct)
                                                        .then((value) =>
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                  provider
                                                                      .message),
                                                              backgroundColor:
                                                                  Colors.green,
                                                            )));
                                                  }
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            ColorManager.red),
                                                    shape: MaterialStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)))),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .remove_from_cart,
                                                  // 'Login',
                                                  style: getSemiBoldStyle(
                                                      color: ColorManager.white,
                                                      fontSize: FontSize.s18),
                                                ),
                                              ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              )),
      ),
    );
  }
}
