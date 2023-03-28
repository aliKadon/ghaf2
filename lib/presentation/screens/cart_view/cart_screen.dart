import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/screens/cart_view/widgets/cart_item_widget.dart';
import 'package:ghaf_application/presentation/screens/login_view/login_view.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/cart_widget_new.dart';
import 'cart_view_getx_controller.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // controller.
  late final CartViewGetXController _cartViewGetXController =
  Get.put(CartViewGetXController());

  var a = 1;

  @override
  void initState() {
    Get.put(CartItemWidget());
    _cartViewGetXController.init(
      context: context,
    );


    super.initState();
  }

  // dispose.
  @override
  void dispose() {
    Get.delete<CartViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CartViewGetXController>(
        builder: (controller) =>
            SafeArea(
              child: AppSharedData.currentUser == null
                  ? Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                  SizedBox(
                    height: AppSize.s75,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.welcome_to_the} ',
                            style: TextStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s14),
                          ),
                          Text(
                            AppLocalizations.of(context)!.ghaf_application,
                            style: TextStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Text(
                        AppLocalizations.of(context)!.in_order_to_add,
                        style: TextStyle(
                            color: ColorManager.grey, fontSize: FontSize.s14),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s75,
                  ),
                  Image.asset(ImageAssets.emptyCard),
                  SizedBox(
                    height: AppSize.s46,
                  ),
                  Container(
                    height: AppSize.s58,
                    width: double.infinity,
                    padding: EdgeInsets.all(4),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => LoginView(),));
                        },
                        child: Text(
                            AppLocalizations.of(context)!.getting_started)),
                  )
                ],
              )
                  : _cartViewGetXController.isMyCartLoading
                  ? Center(
                child: Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              )
                  : _cartViewGetXController.cartItems.length == 0
                  ? Center(
                child: Text(
                    AppLocalizations.of(context)!.cart_is_empty,
                    style: TextStyle(
                        fontSize: FontSize.s18,
                        color: ColorManager.primary,
                        fontWeight: FontWeight.w600)),
              )
                  : Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.45,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                      _cartViewGetXController.cartItems.length,
                      itemBuilder: (context, index) {
                        print('================cart screen');
                        print(_cartViewGetXController
                            .cartItems[index].productCount);
                        return CartWidgetNew(
                          cartItemId: _cartViewGetXController
                              .cartItems[index].id!,
                          index: index,
                          name: _cartViewGetXController
                              .cartItems[index].product!.name!,
                          price: _cartViewGetXController
                              .cartItems[index].product!.price!,
                          image: _cartViewGetXController
                              .cartItems[index]
                              .product!
                              .productImages!.length == 0
                              ? ''
                              : _cartViewGetXController
                              .cartItems[index]
                              .product!
                              .productImages![0],
                          isoCurrencySymbol: _cartViewGetXController
                              .cartItems[index]
                              .product!
                              .isoCurrencySymbol!,
                          productCount: _cartViewGetXController
                              .cartItems[index].productCount!,
                          idProduct: _cartViewGetXController
                              .cartItems[index].product!.id!,
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: ColorManager.greyLight,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.order_Summary,
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GetBuilder<CartViewGetXController>(
                          builder: (controller) =>
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .subtotal,
                                        style: TextStyle(
                                            color: ColorManager.greyLight,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${controller
                                            .subTotal} ${AppLocalizations.of(
                                            context)!.aed}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .discount,
                                        style: TextStyle(
                                            color: ColorManager.greyLight,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${controller
                                            .discount} ${AppLocalizations.of(
                                            context)!.aed}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: ColorManager.greyLight,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .total,
                                        style: TextStyle(
                                            color:
                                            ColorManager.primaryDark,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${controller.total} ${AppLocalizations
                                            .of(context)!.aed}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color:
                                            ColorManager.primaryDark),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: AppSize.s82,
                    padding: EdgeInsets.all(AppSize.s16),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(15)))),
                        onPressed: () {
                          // _cartViewGetXController.emptyBasket(context);
                          _cartViewGetXController
                              .createOrder(context);
                        },
                        child: Text(AppLocalizations.of(context)!
                            .place_order)),
                  )
                ],
              ),
            ),
      ),
    );
  }
}
