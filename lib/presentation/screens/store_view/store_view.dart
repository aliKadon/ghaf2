import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/screens/categories_view/categories_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/home_view/home_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/presentation/widgets/product_item_new.dart';
import 'package:ghaf_application/presentation/widgets/widget_in_store_screen_widget.dart';

import '../../../domain/model/product.dart';
import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';

class StoreView extends StatefulWidget {
  final String branchId;
  bool? isFromCheckout;
  String? orderId;

  StoreView({required this.branchId, this.isFromCheckout, this.orderId});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  //controller
  late final CategoriesGetxController _categoriesGetxController =
      Get.put(CategoriesGetxController());
  late final HomeViewGetXController _homeViewGetXController =
      Get.put(HomeViewGetXController());

  var selected = 0;

  @override
  void initState() {
    print('=====================isFromCheckOut');
    print(widget.isFromCheckout);
    print(widget.orderId);
    _categoriesGetxController.getBranchById(
        context: context, branchId: widget.branchId);
    _homeViewGetXController.getRecommendedProductForBranch(
        context: context, bid: widget.branchId);
    _homeViewGetXController.getProductType(
        context: context, bid: widget.branchId);

    // _homeViewGetXController.getProductByType(
    //     context: context,
    //     bid: widget.branchId,
    //     productTypeId: _homeViewGetXController.productType[0].productType);

    //get product by type

    // _homeViewGetXController.getProductByType(
    //     context: context,
    //     bid: widget.branchId,
    //     filterContent: _homeViewGetXController.productType[0].productType);
    super.initState();
  }

  List<String> imageOfType = [
    'assets/images/trending.png',
    'assets/images/on_sale.png',
    'assets/images/logo1.png'
  ];

  @override
  Widget build(BuildContext context) {
    List<String> typeOfList = [
      AppLocalizations.of(context)!.trending,
      AppLocalizations.of(context)!.on_sale,
      AppLocalizations.of(context)!.discount,
    ];
    return GetBuilder<CategoriesGetxController>(
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MainView(),
          ));
          return false;
        },
        child: Scaffold(
          body: controller.branchById == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: Stack(
                          children: [
                            ClipPath(
                              clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(180),
                                    bottomRight: Radius.circular(180),
                                  ),
                                ),
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          ImageAssets.imageStoreView),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              bottom: AppSize.s92,
                              start: 0,
                              end: 0,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: AppSize.s50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => MainView(),
                                      ));
                                      // if(widget.isFromCheckout != null && widget.isFromCheckout!) {
                                      //
                                      // }else {
                                      //   Navigator.pop(context);
                                      // }
                                    },
                                    child: Image.asset(
                                      IconsAssets.arrow,
                                      height: AppSize.s18,
                                      width: AppSize.s10,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppSize.s92,
                                  ),
                                  RatingBar.builder(
                                    initialRating: (_categoriesGetxController
                                            .branchById!.storeStars!)
                                        .toDouble(),
                                    minRating: 1,
                                    itemSize: 20,
                                    updateOnDrag: true,
                                    allowHalfRating: true,
                                    ignoreGestures: false,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                      // setState(() {
                                      //   star = rating;
                                      // });
                                    },
                                  ),
                                  SizedBox(
                                    width: AppSize.s14,
                                  ),
                                  Text(
                                      '${_categoriesGetxController.branchById!.reviewCount}',
                                      style: TextStyle(color: Colors.white)),
                                  Spacer(),
                                ],
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 0,
                              start: 0,
                              end: 0,
                              child: _categoriesGetxController
                                              .branchById?.branchLogoImage ==
                                          null ||
                                      _categoriesGetxController
                                              .branchById?.branchLogoImage ==
                                          ''
                                  ? Image.asset(
                                      ImageAssets.coffeeHouse,
                                      height: AppSize.s84,
                                      width: AppSize.s84,
                                    )
                                  : Image.network(
                                      _categoriesGetxController
                                          .branchById!.branchLogoImage!,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        ImageAssets.coffeeHouse,
                                        height: AppSize.s84,
                                        width: AppSize.s84,
                                      ),
                                      height: AppSize.s84,
                                      width: AppSize.s84,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${_categoriesGetxController.branchById!.branchName}',
                        style: TextStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s20,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${_categoriesGetxController.branchById!.details}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: AppSize.s84,
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            _categoriesGetxController
                                        .branchById!.storeDeliveryCost ==
                                    null
                                ? Container()
                                : ListView.builder(
                                    itemCount: _categoriesGetxController
                                        .branchById!.storeDeliveryCost!.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return _categoriesGetxController
                                              .branchById!
                                              .storeDeliveryCost![index]
                                              .methodImage!
                                              .isEmpty
                                          ? Image.asset(
                                              ImageAssets.carDelivery,
                                              height: AppSize.s17,
                                              width: AppSize.s17,
                                            )
                                          : Image.network(
                                              _categoriesGetxController
                                                  .branchById!
                                                  .storeDeliveryCost![index]
                                                  .methodImage!,
                                              height: AppSize.s17,
                                              width: AppSize.s17,
                                            );
                                    },
                                  ),
                            VerticalDivider(
                              thickness: 1,
                              color: ColorManager.grey,
                            ),
                            Column(
                              children: [
                                SizedBox(height: AppSize.s10),
                                Text(
                                  AppLocalizations.of(context)!.open_close_time,
                                  style: TextStyle(color: ColorManager.primary),
                                ),
                                SizedBox(height: AppSize.s10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: ColorManager.primary,
                                    ),
                                    Text(
                                        '${_categoriesGetxController.branchById!.todayWorkHoursToString}'),
                                  ],
                                ),
                              ],
                            ),
                            VerticalDivider(
                              thickness: 1,
                              color: ColorManager.grey,
                            ),
                            Column(
                              children: [
                                SizedBox(height: AppSize.s10),
                                Text(
                                  AppLocalizations.of(context)!.minimum_order,
                                  style: TextStyle(color: ColorManager.primary),
                                ),
                                SizedBox(height: AppSize.s10),
                                Text(
                                    '${AppLocalizations.of(context)!.aed} ${_categoriesGetxController.branchById!.minOrder} '),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: ColorManager.greyLight,
                          thickness: 1,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: typeOfList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: WidgetInStoreScreenWidget(
                                imageUrl: imageOfType[index],
                                text: typeOfList[index],
                                bid: _categoriesGetxController.branchById!.id!,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Divider(
                          color: ColorManager.greyLight,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.recommended_for_you,
                              style: TextStyle(
                                  fontSize: FontSize.s20,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.primaryDark),
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<HomeViewGetXController>(
                        builder: (controller) => _homeViewGetXController
                                    .recommendedProduct.length ==
                                0
                            ? Center(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .no_product_found,
                                    style: TextStyle(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: FontSize.s16)),
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.recommendedProduct.length,
                                  itemBuilder: (context, index) {
                                    return Builder(builder: (context) {
                                      Get.put<Product>(
                                        controller.recommendedProduct[index],
                                        tag:
                                            '${controller.recommendedProduct[index].id}recommend',
                                      );
                                      return ProductItemNew(
                                          isFromCheckOut: widget.isFromCheckout,
                                          orderId: widget.orderId,
                                          tag:
                                              '${controller.recommendedProduct[index].id}recommend',
                                          image: controller
                                                      .recommendedProduct[index]
                                                      .productImages
                                                      ?.length ==
                                                  0
                                              ? ''
                                              : controller
                                                  .recommendedProduct[index]
                                                  .productImages![0],
                                          name: controller
                                              .recommendedProduct[index].name!,
                                          stars: controller
                                              .recommendedProduct[index].stars!,
                                          index: index,
                                          price: controller
                                              .recommendedProduct[index].price!,
                                          isFavorite: controller
                                              .recommendedProduct[index]
                                              .isFavorite!,
                                          idProduct: controller
                                              .recommendedProduct[index].id!);
                                    });
                                  },
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Divider(
                          color: ColorManager.greyLight,
                          thickness: 1,
                        ),
                      ),
                      _homeViewGetXController.productType.length == 0
                          ? Center(
                              child: Text(
                                  AppLocalizations.of(context)!.no_type_found,
                                  style: TextStyle(
                                      color: ColorManager.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize.s16)),
                            )
                          : Container(
                              height: AppSize.s50,
                              padding: const EdgeInsets.all(8.0),
                              child: GetBuilder<HomeViewGetXController>(
                                  builder: (controller) {
                                if (_homeViewGetXController.productType.length >
                                    0) {
                                  _homeViewGetXController.getProductByType(
                                      context: context,
                                      bid: widget.branchId,
                                      productTypeId: _homeViewGetXController
                                          .productType[selected].id);
                                }
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: controller.productType.length,
                                  itemExtent: 100,
                                  itemBuilder: (context, index) {
                                    return SharedPrefController().lang1 == 'en'
                                        ? selected == index
                                            ? Text(
                                                '${controller.productType[index].productType}',
                                                style: TextStyle(
                                                    color: ColorManager.primary,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: FontSize.s14),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selected = index;
                                                  });
                                                },
                                                child: Text(
                                                  '${controller.productType[index].productType}',
                                                  style: TextStyle(
                                                      color: ColorManager
                                                          .primaryDark,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: FontSize.s14),
                                                ),
                                              )
                                        : selected == index
                                            ? Text(
                                                '${controller.productType[index].productTypeAr}',
                                                style: TextStyle(
                                                    color: ColorManager.primary,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: FontSize.s14),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selected = index;
                                                  });
                                                },
                                                child: Text(
                                                  '${controller.productType[index].productTypeAr}',
                                                  style: TextStyle(
                                                      color: ColorManager
                                                          .primaryDark,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: FontSize.s14),
                                                ),
                                              );
                                  },
                                );
                              })),
                      GetBuilder<HomeViewGetXController>(
                        builder: (controller) => controller
                                    .productByType.length ==
                                0
                            ? Center(
                                child: Text(
                                AppLocalizations.of(context)!.no_product_found,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s18),
                              ))
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: controller.productByType.length,
                                  itemBuilder: (context, index) {
                                    return Builder(builder: (context) {
                                      Get.put<Product>(
                                        _homeViewGetXController
                                            .productByType[index],
                                        tag:
                                            '${_homeViewGetXController.productByType[index].id}storeView',
                                      );
                                      return ProductItemNew(
                                          isFromCheckOut: widget.isFromCheckout,
                                          orderId: widget.orderId,
                                          tag:
                                              '${_homeViewGetXController.productByType[index].id}storeView',
                                          image: controller.productByType[index]
                                                      .productImages?.length ==
                                                  0
                                              ? ''
                                              : controller.productByType[index]
                                                  .productImages?[0],
                                          name: controller
                                              .productByType[index].name!,
                                          stars: controller
                                              .productByType[index].stars!,
                                          price: controller
                                              .productByType[index].price!,
                                          index: index,
                                          isFavorite: controller
                                              .productByType[index].isFavorite!,
                                          idProduct: controller
                                              .productByType[index].id!);
                                    });
                                  },
                                ),
                              ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
