import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/screens/addresses_view/addresses_view_getx_controller.dart';
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
  String? addressLong;
  String? addressLat;

  AllProductScreen({required this.type, this.addressLong, this.addressLat});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  // controller.
  late final ProductsScreenGetXController _productsScreenGetXController =
      Get.put(ProductsScreenGetXController());
  late final AddressesViewGetXController _addressesViewGetXController =
      Get.find<AddressesViewGetXController>();

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
        // padding: EdgeInsets.all(14.h),
        child: widget.type == 'mostPopular'
            ? _homeViewGetXController.product.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context)!.no_product_found,
                    ),
                  )
                : Container(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p4, vertical: AppPadding.p4),
                      itemCount: _homeViewGetXController.mostPopular.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Constants.crossAxisCount,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height * 0.36,
                          mainAxisSpacing: Constants.mainAxisSpacing,
                          crossAxisSpacing: Constants.crossAxisSpacing),
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
                          return Container(
                            // height: AppSize.s125,
                            // color: Colors.red,
                            child: ProductItemNew(
                                image: _homeViewGetXController
                                            .mostPopular[index]
                                            .productImages!
                                            .length ==
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
                                idProduct: _homeViewGetXController
                                    .mostPopular[index].id!),
                          );
                        });
                      },
                    ),
                  )
            : widget.type == 'order'
                ? GetBuilder<CheckOutGetxController>(
                    builder: (controller) => controller.customerOrder.isEmpty ||
                            controller.customerOrder.length == 0
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.no_order_found,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                _checkOutGetxController.customerOrder.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => OrderTrackingScreen(
                                      createdDate: DateTime.parse(_checkOutGetxController.customerOrder[index].createDate!),
                                        orderId: _checkOutGetxController
                                            .customerOrder[index].id!,
                                        source: _checkOutGetxController
                                                .customerOrder[index]
                                                .deliveryPoint ??
                                            _checkOutGetxController
                                                .customerOrder[index]
                                                .branch!
                                                .branchAddress!,
                                        destination: _checkOutGetxController
                                            .customerOrder[index]
                                            .branch!
                                            .branchAddress!),
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: MyOrdersWidget(
                                          image: _checkOutGetxController
                                              .customerOrder[index]
                                              .branch!
                                              .branchLogoImage!,
                                          statusName: _checkOutGetxController
                                              .customerOrder[index].statusName!,
                                          date: _checkOutGetxController
                                              .customerOrder[index].createDate!,
                                          price: (_checkOutGetxController
                                                  .customerOrder[index]
                                                  .orderCostForCustomer)
                                              .toString(),
                                          orderSequence:
                                              (_checkOutGetxController
                                                      .customerOrder[index]
                                                      .sequenceNumber)
                                                  .toString(),
                                          branchName: _checkOutGetxController
                                              .customerOrder[index]
                                              .branch!
                                              .storeName!,
                                          branchAddress: _checkOutGetxController
                                                  .customerOrder[index]
                                                  .branch!
                                                  .branchAddress ??
                                              null),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: AppSize.s12,
                                          left: AppSize.s12),
                                      child: Divider(
                                        thickness: 1,
                                        color: ColorManager.greyLight,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
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
                              mainAxisExtent: AppSize.s258,
                              // mainAxisSpacing: Constants.mainAxisSpacing,
                            ),
                            itemBuilder: (context, index) {
                              return Builder(builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.all(AppSize.s5),
                                  child: Container(
                                    child: NearByWidget(
                                      addressLat: widget.addressLat == null
                                          ? _addressesViewGetXController
                                                      .addresses.length ==
                                                  0
                                              ? null
                                              : _addressesViewGetXController
                                                  .addresses[0].altitude!
                                          : widget.addressLat!,
                                      addressLong: widget.addressLong == null
                                          ? _addressesViewGetXController
                                                      .addresses.length ==
                                                  0
                                              ? null
                                              : _addressesViewGetXController
                                                  .addresses[0].longitude!
                                          : widget.addressLong!,
                                      is24: _homeViewGetXController
                                          .nearbyStores[index].is24Hours!,
                                      details: _homeViewGetXController
                                              .nearbyStores[index].details ??
                                          '',
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
