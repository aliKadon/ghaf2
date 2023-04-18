import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/screens/cart_view/cart_screen.dart';
import 'package:ghaf_application/presentation/screens/cart_view/cart_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/home_view/home_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/offers_view/offers_screen_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/store_view/store_view.dart';

import '../../../app/constants.dart';
import '../../../app/utils/helpers.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/onsale_widget.dart';

class OnsaleView extends StatefulWidget {
  final String bid;
  final bool is24;

  OnsaleView({required this.bid,required this.is24});

  @override
  State<OnsaleView> createState() => _OnsaleViewState();
}

class _OnsaleViewState extends State<OnsaleView> with Helpers {
  //controller
  final OffersScreenGetXController _offersScreenGetXController =
      Get.put(OffersScreenGetXController());
  final CartViewGetXController _cartViewGetXController =
      Get.put(CartViewGetXController());
  final HomeViewGetXController _homeViewGetXController =
      Get.put(HomeViewGetXController());

  @override
  void initState() {
    // TODO: implement initState
    if(AppSharedData.currentUser != null){
      _offersScreenGetXController.getOffers(context: context, bid: widget.bid);
    }
    super.initState();
    if(AppSharedData.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showSignInSheet(context: context,role: Constants.roleRegisterCustomer);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _cartViewGetXController.emptyBasket(context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => StoreView(branchId: widget.bid,is24: widget.is24),
        ));
        // _offersScreenGetXController.subtotal =
        //     _offersScreenGetXController.offers[0].branch!.minOrder!;
        return false;
      },
      child: AppSharedData.currentUser == null ? Container() : GetBuilder<OffersScreenGetXController>(
        builder: (controller1) => Scaffold(
          body: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        _cartViewGetXController.emptyBasket(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => StoreView(branchId: widget.bid,is24: widget.is24),
                        ));
                        // _offersScreenGetXController.subtotal =
                        //     _offersScreenGetXController
                        //         .offers[0].branch!.minOrder!;
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
                      AppLocalizations.of(context)!.on_sale,
                      style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Divider(
                color: ColorManager.greyLight,
                thickness: 1,
              ),
              GetBuilder<OffersScreenGetXController>(
                builder: (controller) => Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: controller.offers.length == 0
                      ? Center(
                          child: Text(
                              AppLocalizations.of(context)!.no_product_found,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.s16,
                                  color: ColorManager.primary)),
                        )
                      : GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.offers.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: AppSize.s311),
                          itemBuilder: (context, index) {
                            return Builder(builder: (context) {
                              Get.put<Product>(controller.offers[index],
                                  tag: '${controller.offers[index].id}');
                              return OnsaleWidget(
                                discount: AppSharedData.currentUser!.ghafGold! ? controller.offers[index].discountValueForGoldenUsers! :  controller.offers[index].discountValueForAllUsers!,
                                tag: '${controller.offers[index].id}',
                                minOrder:
                                    controller.offers[index].branch!.minOrder ?? 0,
                              );
                            });
                          },
                        ),
                ),
              ),
              GetBuilder<CartViewGetXController>(
                builder: (controller) {
                  // num orderCost = 0;
                  //
                  // if((_offersScreenGetXController.offers[0].branch!.minOrder!) - (controller.total) <= 0) {
                  //   orderCost = (_offersScreenGetXController.offers[0].branch!.minOrder!) - (controller.total);
                  //
                  // }else {
                  //   orderCost = (_offersScreenGetXController.offers[0].branch!.minOrder!) - (controller.total);
                  // }
                  return controller1.offers.length == 0
                      ? Container()
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          padding: EdgeInsets.all(5),
                          child: (((controller1.offers[0].branch!.minOrder!) -
                                      (controller.subTotal)) >
                                  0)
                              ? ElevatedButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                          '${((controller.subTotal == 0) ? (controller1.offers[0].branch!.minOrder!) : (((controller1.offers[0].branch!.minOrder!) - (controller.subTotal)) > 0) ? ((controller1.offers[0].branch!.minOrder!) - (controller.subTotal)) : 0)}'
                                          // '${controller.subtotal == 0 ? _offersScreenGetXController.offers[0].branch!.minOrder! : controller.subtotal} ${_offersScreenGetXController.offers[0].isoCurrencySymbol}'
                                          ),
                                      Spacer(),
                                      Icon(Icons.shopping_bag_outlined),
                                      Text(AppLocalizations.of(context)!
                                          .add_to_cart)
                                    ],
                                  ),
                                )
                              : ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.red)),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => CartScreen(),
                                    ));
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                          '${((controller.subTotal == 0) ? (controller1.offers[0].branch!.minOrder!) : (((controller1.offers[0].branch!.minOrder!) - (controller.subTotal)) > 0) ? ((controller1.offers[0].branch!.minOrder!) - (controller.subTotal)) : 0)}'
                                          // '${controller.subtotal == 0 ? _offersScreenGetXController.offers[0].branch!.minOrder! : controller.subtotal} ${_offersScreenGetXController.offers[0].isoCurrencySymbol}'
                                          ),
                                      Spacer(),
                                      Icon(Icons.shopping_bag_outlined),
                                      Text(AppLocalizations.of(context)!
                                          .create_order)
                                    ],
                                  ),
                                ),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
