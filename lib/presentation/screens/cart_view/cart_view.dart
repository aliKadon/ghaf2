import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/domain/model/cart_item.dart';
import 'package:ghaf_application/presentation/screens/cart_view/cart_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/cart_view/widgets/cart_item_widget.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // controller.
  late final CartViewGetXController _cartViewGetXController =
      Get.put(CartViewGetXController());

  List<int> items = List<int>.generate(3, (index) => index);

  // init state.
  @override
  void initState() {
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Expanded(
                child: GetBuilder<CartViewGetXController>(
                  id: 'myCart',
                  builder: (controller) => controller.isMyCartLoading
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          ),
                        )
                      : _cartViewGetXController.cartItems.isEmpty
                          ? Center(
                              child: Text(
                                'Cart is empty',
                              ),
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: controller.cartItems.length,
                                    itemBuilder: (context, index) {
                                      return Builder(
                                        builder: (context) {
                                          Get.put<CartItem>(
                                              _cartViewGetXController
                                                  .cartItems[index],
                                              tag: index.toString());
                                          return CartItemWidget(
                                            index: index,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.s14,
                                ),
                                GetBuilder<CartViewGetXController>(
                                  id: 'bell',
                                  builder: (controller) => Column(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .order_summary,
                                        style: getSemiBoldStyle(
                                          color: ColorManager.primaryDark,
                                          fontSize: FontSize.s16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: AppSize.s14,
                                      ),
                                      Row(children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .subtotal,
                                          style: getRegularStyle(
                                            color: ColorManager.grey,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          '${controller.subTotal} AED',
                                          style: getRegularStyle(
                                            color: ColorManager.primaryDark,
                                          ),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      Row(children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .discount,
                                          style: getRegularStyle(
                                            color: ColorManager.grey,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          '${controller.discount} AED',
                                          style: getRegularStyle(
                                            color: ColorManager.primaryDark,
                                          ),
                                        ),
                                      ]),
                                      Divider(
                                          height: 1, color: ColorManager.grey),
                                      SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      Row(children: [
                                        Text(
                                          AppLocalizations.of(context)!.total,
                                          style: getSemiBoldStyle(
                                            color: ColorManager.primaryDark,
                                            fontSize: FontSize.s16,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          '${controller.total} AED',
                                          style: getSemiBoldStyle(
                                            color: ColorManager.primaryDark,
                                            fontSize: FontSize.s16,
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.s46,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: AppMargin.m16,
                                  ),
                                  width: double.infinity,
                                  height: AppSize.s55,
                                  child: ElevatedButton(
                                    onPressed:
                                        _cartViewGetXController.createOrder,
                                    child: Text(
                                      'Create Order',
                                      style: getSemiBoldStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.s44,
                                ),
                              ],
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
