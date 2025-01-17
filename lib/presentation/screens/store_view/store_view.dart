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
  final bool is24;

  StoreView(
      {required this.branchId,
      this.isFromCheckout,
      this.orderId,
      required this.is24});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  var language = SharedPrefController().lang1;

  //controller
  late final CategoriesGetxController _categoriesGetxController =
      Get.put(CategoriesGetxController());
  late final HomeViewGetXController _homeViewGetXController =
      Get.put(HomeViewGetXController());

  var selected = 0;

  @override
  void initState() {
    super.initState();
    _categoriesGetxController.getBranchById(
        context: context, branchId: widget.branchId);
    _homeViewGetXController.getRecommendedProductForBranch(
        context: context, bid: widget.branchId);
    _homeViewGetXController.getProductType(
        context: context, bid: widget.branchId);
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
              : controller.isLoadingBranchById
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
                                        bottomLeft:
                                            Radius.circular(AppSizeWidth.s161),
                                        bottomRight:
                                            Radius.circular(AppSizeWidth.s161),
                                      ),
                                    ),
                                  ),
                                  child: _categoriesGetxController.branchById
                                                  ?.storeCoverImage ==
                                              null ||
                                          _categoriesGetxController.branchById!
                                              .storeCoverImage!.isEmpty
                                      ? Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.18,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    ImageAssets.imageStoreView),
                                                fit: BoxFit.cover),
                                          ),
                                        )
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.18,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    _categoriesGetxController
                                                        .branchById!
                                                        .storeCoverImage!),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                ),
                                PositionedDirectional(
                                  bottom: AppSize.s92,
                                  start: 0,
                                  end: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: AppSizeWidth.s40,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) => MainView(),
                                          ));
                                          // if(widget.isFromCheckout != null && widget.isFromCheckout!) {
                                          //
                                          // }else {
                                          //   Navigator.pop(context);
                                          // }
                                        },
                                        child: Container(
                                          height: AppSize.s30,
                                          width: AppSize.s30,
                                          // width: MediaQuery.of(context).size.width *
                                          //     0.08,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSizeWidth.s10),
                                              color: ColorManager.primaryDark),
                                          child: Image.asset(
                                            SharedPrefController().lang1 == 'ar'
                                                ? IconsAssets.arrow2
                                                : IconsAssets.arrow,
                                            height: AppSize.s14,
                                            width: AppSize.s30,
                                            color: ColorManager.primary,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: AppSizeWidth.s184,
                                      ),
                                      RatingBar.builder(
                                        initialRating:
                                            (_categoriesGetxController
                                                    .branchById!.storeStars!)
                                                .toDouble(),
                                        minRating: 1,
                                        itemSize: AppSize.s15,
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
                                        width: AppSizeWidth.s4,
                                      ),
                                      _categoriesGetxController
                                                  .branchById!.reviewCount ==
                                              0
                                          ? Container()
                                          : Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppSizeWidth.s25),
                                                  color: ColorManager.primary),
                                              width: AppSizeWidth.s14,
                                              height: AppSizeWidth.s14,
                                              child: Center(
                                                child: Text(
                                                    '${_categoriesGetxController.branchById!.reviewCount}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            FontSize.s12)),
                                              ),
                                            ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                PositionedDirectional(
                                  bottom: 0,
                                  start: 0,
                                  end: 0,
                                  child: _categoriesGetxController.branchById
                                                  ?.branchLogoImage ==
                                              null ||
                                          _categoriesGetxController.branchById
                                                  ?.branchLogoImage ==
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
                            '${_categoriesGetxController.branchById!.storeName}',
                            style: TextStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s20,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${_categoriesGetxController.branchById!.details == null ? '' : _categoriesGetxController.branchById!.details}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Container(
                            height: AppSize.s125,
                            width: MediaQuery.of(context).size.width * 1,
                            padding: EdgeInsets.all(AppSize.s14),
                            child: Row(
                              children: [
                                _categoriesGetxController
                                            .branchById!.storeDeliveryCost ==
                                        null
                                    ? Container()
                                    : Expanded(
                                        child: ListView.builder(
                                          itemCount: _categoriesGetxController
                                              .branchById!
                                              .storeDeliveryCost!
                                              .length,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                _categoriesGetxController
                                                        .branchById!
                                                        .storeDeliveryCost![
                                                            index]
                                                        .methodImage!
                                                        .isEmpty
                                                    ? Image.asset(
                                                        ImageAssets.carDelivery,
                                                        height: AppSize.s20,
                                                        width: AppSize.s20,
                                                      )
                                                    : Image.network(
                                                        _categoriesGetxController
                                                            .branchById!
                                                            .storeDeliveryCost![
                                                                index]
                                                            .methodImage!,
                                                        height: AppSize.s20,
                                                        width: AppSize.s20,
                                                      ),
                                                SizedBox(
                                                  width: AppSizeWidth.s4,
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                VerticalDivider(
                                  thickness: 1,
                                  color: ColorManager.grey,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: AppSize.s10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            // width: AppSizeWidth.s210,
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .open_close_time,
                                              style: TextStyle(
                                                  color: ColorManager.primary,
                                                  fontSize: FontSize.s12),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: AppSize.s10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            color: ColorManager.primary,
                                          ),
                                          Container(
                                            width: AppSizeWidth.s110,
                                            child: Text(
                                              overflow: TextOverflow.clip,
                                              widget.is24
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .open_24_hours
                                                  : controller
                                                          .branchById!.isOpen!
                                                      ? '${_categoriesGetxController.branchById!.todayWorkHoursToString}'
                                                      : '${AppLocalizations.of(context)!.store_currently_closed}',
                                              style: TextStyle(
                                                  color:
                                                      ColorManager.primaryDark),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                  thickness: 1,
                                  color: ColorManager.grey,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(height: AppSize.s10),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .minimum_order,
                                        style: TextStyle(
                                            color: ColorManager.primary),
                                      ),
                                      SizedBox(height: AppSize.s10),
                                      Text(
                                          '${AppLocalizations.of(context)!.aed} ${_categoriesGetxController.branchById!.minOrder == null ? 0 : _categoriesGetxController.branchById!.minOrder} '),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(AppSize.s8),
                            child: Divider(
                              color: ColorManager.greyLight,
                              thickness: 1,
                            ),
                          ),
                          Container(
                            height: AppSize.s110,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: typeOfList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: AppSize.s8,
                                    right: AppSize.s8,
                                  ),
                                  child: WidgetInStoreScreenWidget(
                                    is24: _categoriesGetxController
                                        .branchById!.is24Hours!,
                                    imageUrl: imageOfType[index],
                                    text: typeOfList[index],
                                    bid: _categoriesGetxController
                                        .branchById!.id!,
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: AppSize.s8, left: AppSize.s8),
                            child: Divider(
                              color: ColorManager.greyLight,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(AppSize.s8),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .recommended_for_you,
                                  style: TextStyle(
                                      fontSize: FontSize.s20,
                                      fontWeight: FontWeight.w600,
                                      color: ColorManager.primaryDark),
                                ),
                              ],
                            ),
                          ),
                          GetBuilder<HomeViewGetXController>(
                            builder: (controller) => controller
                                    .isLoadingRecommended
                                ? Container()
                                : controller.recommendedProduct.length == 0
                                    ? Center(
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .no_product_found,
                                            style: TextStyle(
                                                color: ColorManager.primary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: FontSize.s16)),
                                      )
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: AppSizeWidth.s5,
                                              ),
                                              Container(
                                                height: AppSize.s300,
                                                width: MediaQuery.of(context).size.width * 1,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemCount: controller
                                                      .recommendedProduct.length,
                                                  itemBuilder: (context, index) {
                                                    return Builder(
                                                        builder: (context) {

                                                      Get.put<Product>(
                                                        controller
                                                                .recommendedProduct[
                                                            index],
                                                        tag:
                                                            '${controller.recommendedProduct[index].id}',
                                                      );
                                                      return Container(
                                                        // width: AppSizeWidth.s154,
                                                        child: ProductItemNew(
                                                            isFromCheckOut: widget
                                                                .isFromCheckout,
                                                            orderId:
                                                                widget.orderId,
                                                            tag:
                                                                '${controller.recommendedProduct[index].id}',
                                                            image: controller.recommendedProduct[index].productImages?.length == 0
                                                                ? ''
                                                                : controller.recommendedProduct[index].productImages![
                                                                    0],
                                                            name: controller
                                                                .recommendedProduct[
                                                                    index]
                                                                .name!,
                                                            stars: controller
                                                                .recommendedProduct[
                                                                    index]
                                                                .stars!,
                                                            index: index,
                                                            price: controller
                                                                .recommendedProduct[
                                                                    index]
                                                                .price!,
                                                            isFavorite: controller
                                                                .recommendedProduct[
                                                                    index]
                                                                .isFavorite!,
                                                            idProduct: controller
                                                                .recommendedProduct[index]
                                                                .id!),
                                                      );
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: AppSize.s8, left: AppSize.s8),
                            child: Divider(
                              color: ColorManager.greyLight,
                              thickness: 1,
                            ),
                          ),
                          GetBuilder<HomeViewGetXController>(
                            builder: (controller) =>
                                controller.productType.length == 0
                                    ? Center(
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .no_type_found,
                                            style: TextStyle(
                                                color: ColorManager.primary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: FontSize.s16)),
                                      )
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: AppSizeWidth.s5,
                                            ),
                                            Container(
                                                height: AppSize.s40,
                                                padding:
                                                    EdgeInsets.all(AppSize.s8),
                                                child: GetBuilder<
                                                        HomeViewGetXController>(
                                                    builder: (controller) {
                                                  if (controller
                                                          .productType.length >
                                                      0) {
                                                    controller.getProductByType(
                                                        context: context,
                                                        bid: widget.branchId,
                                                        productTypeId:
                                                            _homeViewGetXController
                                                                .productType[
                                                                    selected]
                                                                .id);
                                                  }
                                                  return ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.only(
                                                        left: AppSizeWidth.s5,
                                                        right: AppSizeWidth.s5),
                                                    itemCount: controller
                                                        .productType.length,
                                                    itemExtent: AppSize.s110,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return SharedPrefController()
                                                                  .lang1 ==
                                                              'en'
                                                          ? selected == index
                                                              ? Container(
                                                                  padding: EdgeInsets.only(
                                                                      left: AppSizeWidth
                                                                          .s2,
                                                                      right: AppSizeWidth
                                                                          .s2),
                                                                  child: Text(
                                                                    '${controller.productType[index].productType}',
                                                                    style: TextStyle(
                                                                        color: ColorManager
                                                                            .primary,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            FontSize.s14),
                                                                  ),
                                                                )
                                                              : GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selected =
                                                                          index;
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                    '${controller.productType[index].productType}',
                                                                    style: TextStyle(
                                                                        color: ColorManager
                                                                            .primaryDark,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            FontSize.s14),
                                                                  ),
                                                                )
                                                          : selected == index
                                                              ? Text(
                                                                  '${controller.productType[index].productTypeAr}',
                                                                  style: TextStyle(
                                                                      color: ColorManager
                                                                          .primary,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          FontSize
                                                                              .s14),
                                                                )
                                                              : GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selected =
                                                                          index;
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                    '${controller.productType[index].productTypeAr}',
                                                                    style: TextStyle(
                                                                        color: ColorManager
                                                                            .primaryDark,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            FontSize.s14),
                                                                  ),
                                                                );
                                                    },
                                                  );
                                                })),
                                          ],
                                        ),
                                      ),
                          ),
                          GetBuilder<HomeViewGetXController>(
                            builder: (controller) => controller
                                    .isLoadingProductByType
                                ? Container()
                                : controller.productByType.length == 0
                                    ? Container(
                                        height: AppSize.s192,
                                        child: Center(
                                            child: Text(
                                          AppLocalizations.of(context)!
                                              .no_product_found,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: ColorManager.primary,
                                              fontSize: FontSize.s18),
                                        )),
                                      )
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: AppSizeWidth.s5,
                                              ),
                                              Container(
                                                height: AppSize.s300,
                                                width: MediaQuery.of(context).size.width * 1,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemCount: controller
                                                      .productByType.length,
                                                  itemBuilder: (context, index) {
                                                    return Builder(
                                                        builder: (context) {

                                                      Get.put<Product>(
                                                        controller
                                                            .productByType[index],
                                                        tag:
                                                            '${controller.productByType[index].id}',
                                                      );
                                                      return Container(
                                                        // width: AppSizeWidth.s154,
                                                        child: ProductItemNew(
                                                            isFromCheckOut: widget
                                                                .isFromCheckout,
                                                            orderId:
                                                                widget.orderId,
                                                            tag:
                                                                '${controller.productByType[index].id}',
                                                            image: controller.productByType[index].productImages?.length == 0
                                                                ? ''
                                                                : controller.productByType[index].productImages?[
                                                                    0],
                                                            name: controller
                                                                .productByType[
                                                                    index]
                                                                .name!,
                                                            stars: controller
                                                                .productByType[
                                                                    index]
                                                                .stars!,
                                                            price: controller
                                                                .productByType[
                                                                    index]
                                                                .price!,
                                                            index: index,
                                                            isFavorite: controller
                                                                .productByType[
                                                                    index]
                                                                .isFavorite!,
                                                            idProduct: controller
                                                                .productByType[index]
                                                                .id!),
                                                      );
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
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
