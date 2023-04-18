import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/screens/products_screen/products_screen_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/product_item_new.dart';

import '../../../app/constants.dart';
import '../../../domain/model/product.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/my_orders_widget.dart';
import '../../widgets/nearby_widget.dart';
import '../checkout/check_out_getx_controller.dart';
import '../checkout/order_tracking_screen.dart';
import '../home_view/home_view_getx_controller.dart';

class AllProductScreen extends StatefulWidget {
  String type;

  AllProductScreen({required this.type});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  // controller.
  late final ProductsScreenGetXController _productsScreenGetXController =
      Get.put(ProductsScreenGetXController());

  // controller.
  HomeViewGetXController _homeViewGetXController =
      Get.find<HomeViewGetXController>();
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());

  var isLoading = true;

  @override
  void initState() {
    if (widget.type == 'mostPopular') {
      _homeViewGetXController.getMostPopularProduct();
    } else if (widget.type == 'order') {
      _checkOutGetxController.getCustomerOrder(context: context);
    } else if (widget.type == 'near') {
      _homeViewGetXController.getNearbyStores(
          lat: SharedPrefController().locationLat.toString(),
          long: SharedPrefController().locationLong.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.type == 'mostPopular'
            ? Text(AppLocalizations.of(context)!.products)
            : widget.type == 'order'
                ? Text(AppLocalizations.of(context)!.orders)
                : widget.type == 'near'
                    ? Text(AppLocalizations.of(context)!.stores)
                    : Container(),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.all(14.h),
        child: widget.type == 'mostPopular'
            ? _homeViewGetXController.product.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context)!.no_product_found,
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p8, vertical: AppPadding.p4),
                    itemCount: _homeViewGetXController.mostPopular.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Constants.crossAxisCount,
                      mainAxisExtent: Constants.mainAxisExtent,
                      mainAxisSpacing: Constants.mainAxisSpacing,
                    ),
                    itemBuilder: (context, index) {
                      // Get.put<Product>(
                      //   _productsScreenGetXController.products[index],
                      //   tag:
                      //   '${_productsScreenGetXController.products[index].id}products',
                      // );
                      return Builder(builder: (context) {
                        Get.put<Product>(
                          _homeViewGetXController.mostPopular[index],
                          tag:
                              '${_homeViewGetXController.mostPopular[index].id}',
                        );
                        return ProductItemNew(
                            image: _homeViewGetXController.mostPopular[index]
                                        .productImages!.length ==
                                    0
                                ? ''
                                : _homeViewGetXController
                                    .mostPopular[index].productImages![0],
                            name: _homeViewGetXController
                                .mostPopular[index].name!,
                            tag:
                                '${_homeViewGetXController.mostPopular[index].id}',
                            stars: _homeViewGetXController
                                .mostPopular[index].stars!,
                            price: _homeViewGetXController
                                .mostPopular[index].price!,
                            index: index,
                            isFavorite: _homeViewGetXController
                                .mostPopular[index].isFavorite!,
                            idProduct:
                                _homeViewGetXController.mostPopular[index].id!);
                      });
                    },
                  )
            : widget.type == 'order'
                ? _checkOutGetxController.customerOrder.isEmpty
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.no_order_found,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _checkOutGetxController.customerOrder.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    OrderTrackingScreen(
                                        orderId:
                                        _checkOutGetxController.customerOrder[index].id!,
                                        source: _checkOutGetxController.customerOrder[index]
                                            .deliveryPoint!,
                                        destination: _checkOutGetxController
                                            .customerOrder[index]
                                            .branch!
                                            .branchAddress!),
                              ));
                            },
                            child: Column(
                              children: [
                                MyOrdersWidget(
                                  image: _checkOutGetxController.customerOrder[index].branch!.branchLogoImage!,
                                    statusName: _checkOutGetxController.customerOrder[index].statusName!,
                                    date: _checkOutGetxController
                                        .customerOrder[index].createDate!,
                                    price: (_checkOutGetxController
                                            .customerOrder[index]
                                            .orderCostForCustomer)
                                        .toString(),
                                    orderSequence: (_checkOutGetxController
                                            .customerOrder[index].sequenceNumber)
                                        .toString(),
                                    branchName: _checkOutGetxController
                                        .customerOrder[index].branch!.storeName!,
                                    branchAddress: _checkOutGetxController
                                            .customerOrder[index]
                                            .branch!
                                            .branchAddress ??
                                        null),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12.0, left: 12.0),
                                  child: Divider(
                                    thickness: 1,
                                    color: ColorManager.greyLight,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                : widget.type == 'near'
                    ? _homeViewGetXController.nearbyStores.isEmpty
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.no_stores_found,
                            ),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p8,
                                vertical: AppPadding.p4),
                            itemCount:
                                _homeViewGetXController.nearbyStores.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 200,
                              // mainAxisSpacing: Constants.mainAxisSpacing,
                            ),
                            itemBuilder: (context, index) {
                              return Builder(builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: NearByWidget(
                                    is24: _homeViewGetXController
                                        .nearbyStores[index].is24Hours!,
                                    details: _homeViewGetXController
                                        .nearbyStores[index].details!,
                                    index: index,
                                    imageUrl: _homeViewGetXController
                                                    .nearbyStores[index]
                                                    .branchLogoImage
                                                    ?.length ==
                                                0 ||
                                            _homeViewGetXController
                                                    .nearbyStores[index]
                                                    .branchLogoImage ==
                                                null
                                        ? ''
                                        : _homeViewGetXController
                                            .nearbyStores[index]
                                            .branchLogoImage!,
                                    storeName: _homeViewGetXController
                                        .nearbyStores[index].branchName!,
                                    branchId: _homeViewGetXController
                                        .nearbyStores[index].id!,
                                    address: _homeViewGetXController
                                        .nearbyStores[index].branchAddress!,
                                  ),
                                );
                              });
                            },
                          )
                    : Container(),
      ),
    );
  }
}
