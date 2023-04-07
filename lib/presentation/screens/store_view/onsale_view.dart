import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/screens/cart_view/cart_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/offers_view/offers_screen_getx_controller.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/onsale_widget.dart';

class OnsaleView extends StatefulWidget {
  final String bid;

  OnsaleView({required this.bid});

  @override
  State<OnsaleView> createState() => _OnsaleViewState();
}

class _OnsaleViewState extends State<OnsaleView> {
  //controller
  final OffersScreenGetXController _offersScreenGetXController =
      Get.put(OffersScreenGetXController());
  final CartViewGetXController _cartViewGetXController =
      Get.put(CartViewGetXController());

  @override
  void initState() {
    // TODO: implement initState
    _offersScreenGetXController.getOffers(context: context, bid: widget.bid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _offersScreenGetXController.total = 0;
        // _offersScreenGetXController.subtotal =
        //     _offersScreenGetXController.offers[0].branch!.minOrder!;
        return false;
      },
      child: Scaffold(
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
                      _offersScreenGetXController.total = 0;
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: AppSize.s311),
                        itemBuilder: (context, index) {
                          return Builder(builder: (context) {
                            Get.put<Product>(controller.offers[index],
                                tag: '${controller.offers[index].id}');
                            return OnsaleWidget(
                              tag: '${controller.offers[index].id}',
                            );
                          });
                        },
                      ),
              ),
            ),
            GetBuilder<OffersScreenGetXController>(
              builder: (controller) {
                // num orderCost = 0;
                //
                // if((_offersScreenGetXController.offers[0].branch!.minOrder!) - (controller.total) <= 0) {
                //   orderCost = (_offersScreenGetXController.offers[0].branch!.minOrder!) - (controller.total);
                //
                // }else {
                //   orderCost = (_offersScreenGetXController.offers[0].branch!.minOrder!) - (controller.total);
                // }
                return _offersScreenGetXController.offers.length == 0
                    ? Container()
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                  '${controller.subtotal == 0 ? _offersScreenGetXController.offers[0].branch!.minOrder! : controller.subtotal} ${_offersScreenGetXController.offers[0].isoCurrencySymbol}'),
                              Spacer(),
                              Icon(Icons.shopping_bag_outlined),
                              Text(AppLocalizations.of(context)!.add_to_cart)
                            ],
                          ),
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
