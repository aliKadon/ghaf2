import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/search/search_screen.dart';
import 'package:ghaf_application/presentation/screens/store_by_category/store_by_category.dart';
import 'package:ghaf_application/presentation/screens/store_view/store_view.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/subscribe_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/product_item_new.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../widgets/shortcuts_widget.dart';
import '../checkout/check_out_getx_controller.dart';
import '../login_view/login_view_getx_controller.dart';
import '../profile/profile_setting/profile_setting_getx_controller.dart';
import 'home_view_getx_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // controller.

  var isLoading = true;
  var language = SharedPrefController().lang1;

  late Position position;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  List<String> imageShortcuts = [
    ImageAssets.logo1,
    ImageAssets.trending,
    ImageAssets.homePastOrder,
    ImageAssets.homeOffers
  ];

  Future<Position> getLocation() async {
    position = await _geolocatorPlatform.getCurrentPosition();
    print('===================my position');
    print(
      position.toString(),
    );
    return position;
  }

  // controller.
  HomeViewGetXController _homeViewGetXController =
      Get.put<HomeViewGetXController>(HomeViewGetXController());
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());
  late final Product _product = Get.put(Product());
  late final ProfileSettingGetxController _profileSettingGetxController =
      Get.put(ProfileSettingGetxController());

  // init state.
  @override
  void initState() {
    _homeViewGetXController.init(context: context);

    Get.put(Product());
    Get.put(LoginViewGetXController(context: context));
    _profileSettingGetxController.getUserDetails(context);
    _checkOutGetxController.getCustomerOrder(context: context);
    _homeViewGetXController.determinePosition().then((value) => getLocation()
        .then((value) => _homeViewGetXController.GetAddressFromLatLong(
                LatLng(position.latitude, position.longitude))
            .then((value) => _homeViewGetXController.getNearbyStores(
                lat: position.latitude.toString(),
                long: position.longitude.toString()))));
    super.initState();
  }

  // dispose.
  @override
  void dispose() {
    Get.delete<HomeViewGetXController>();
    super.dispose();
  }

  // isLoading ? Center(
  // child: Container(
  // width: 20,
  // height: 20,
  // child: CircularProgressIndicator(
  // strokeWidth: 1,
  // ),
  // ),
  // )
  //     :

  @override
  Widget build(BuildContext context) {
    List<String> typeOfShortcuts = [
      AppLocalizations.of(context)!.only_on_ghaf,
      AppLocalizations.of(context)!.trending,
      AppLocalizations.of(context)!.past_order,
      AppLocalizations.of(context)!.offers,
    ];
    SubscribeViewGetXController _subscribeViewGetXController =
        Get.put(SubscribeViewGetXController(context: context));
    var isArabic = SharedPrefController().lang1;
    return ChangeNotifierProvider.value(
      value: ProductProvider(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(top: AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.hello_welcome,
                                  style: getRegularStyle(
                                      color: ColorManager.blackLight),
                                ),
                                SizedBox(
                                  width: AppSize.s82,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      ImageAssets.homePoints,
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    Text(
                                        '${AppSharedData.currentUser?.customerPoints ?? 0} ${AppLocalizations.of(context)!.point}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.myFavorite);
                                      },
                                      child: Image.asset(
                                        IconsAssets.heart,
                                        height: AppSize.s20,
                                        width: AppSize.s20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Text(
                                    '${AppLocalizations.of(context)!.shipping} ${_homeViewGetXController.city}',
                                    style: getRegularStyle(
                                        color: ColorManager.primaryDark),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(width: AppPadding.p12,),
                      Expanded(
                        child: Container(
                            width: AppSize.s280,
                            margin: EdgeInsets.only(
                                bottom: AppMargin.m16,
                                right: AppMargin.m16,
                                left: AppMargin.m16),
                            child: Container(
                                padding: EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: ColorManager.primaryDark)),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => SearchScreen(),
                                    ));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.search),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .search_flower,
                                      ),
                                    ],
                                  ),
                                ))),
                      ),
                      InkWell(
                        onTap: _homeViewGetXController.onFilterButtonTapped,
                        child: Container(
                          height: AppSize.s50,
                          width: AppSize.s55,
                          padding: EdgeInsets.symmetric(
                              horizontal: AppPadding.p12,
                              vertical: AppPadding.p12),
                          decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(AppRadius.r12),
                          ),
                          child: Image.asset(
                            IconsAssets.filter,
                            width: AppSize.s16,
                            height: AppSize.s14,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppPadding.p18,
                      ),
                    ],
                  ),
                  GetBuilder<HomeViewGetXController>(
                    id: 'isSearching',
                    builder: (controller) => controller.isSearching
                        ? SizedBox()
                        : Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      ImageAssets.main4,
                                      height: AppSize.s148,
                                      width: AppSize.s360,
                                      fit: BoxFit.fill,
                                    ),
                                    isArabic == 'en'
                                        ? Positioned(
                                            left: 220,
                                            top: 37,
                                            child: Image.asset(
                                              ImageAssets.imageInMain4,
                                              height: 120,
                                              width: 120,
                                            ))
                                        : Positioned(
                                            right: 220,
                                            top: 37,
                                            child: Image.asset(
                                              ImageAssets.imageInMain4,
                                              height: 120,
                                              width: 120,
                                            )),
                                    PositionedDirectional(
                                      top: AppSize.s24,
                                      start: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text for image up
                                          Text(
                                            AppLocalizations.of(context)!
                                                .upgrade_your_shopping_experience,
                                            style: TextStyle(
                                                height: 1,
                                                fontSize: FontSize.s20,
                                                fontFamily:
                                                    FontConstants.fontFamily,
                                                color: ColorManager.primaryDark,
                                                fontWeight:
                                                    FontWeightManager.medium),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .easy_and_comfortable,
                                            style: getMediumStyle(
                                                color: ColorManager.primaryDark,
                                                fontSize: FontSize.s16),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          AppSharedData.currentUser?.ghafGold ??
                                                  false
                                              ? ElevatedButton(
                                                  // onPressed: () {},
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorManager
                                                                  .primaryDark)),
                                                  onPressed: () {
                                                    _subscribeViewGetXController
                                                        .cancelSubscription(
                                                            context: context);
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .unSubscribe,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ))
                                              : ElevatedButton(
                                                  // onPressed: () {},
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorManager
                                                                  .primaryDark)),
                                                  onPressed:
                                                      _homeViewGetXController
                                                          .onGhafIconTapped,
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .subscribe_to_ghaf_gold,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: AppSize.s24,
                              ),
                              Container(
                                height: AppSize.s210,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p16),
                                  child: GetBuilder<HomeViewGetXController>(
                                    id: 'categories',
                                    builder:
                                        (HomeViewGetXController controller) {
                                      return GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 0.4,
                                                crossAxisSpacing: 20,
                                                mainAxisExtent: 130),
                                        physics: BouncingScrollPhysics(),
                                        itemCount: _homeViewGetXController
                                            .categories.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    StoreByCategory(
                                                        cid:
                                                            _homeViewGetXController
                                                                .categories[
                                                                    index]
                                                                .id!),
                                              ));
                                            },
                                            child: Column(
                                              children: [
                                                Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: _homeViewGetXController
                                                                .categories[
                                                                    index]
                                                                .categoryImageData ==
                                                            null
                                                        ? Image.asset(
                                                            ImageAssets.grocery,
                                                            fit: BoxFit
                                                                .scaleDown)
                                                        : Image.network(
                                                            _homeViewGetXController
                                                                .categories[
                                                                    index]
                                                                .categoryImageData!,
                                                            height: AppSize.s60,
                                                            width: AppSize.s60,
                                                            fit: BoxFit
                                                                .scaleDown),
                                                  ),
                                                ),
                                                Text(
                                                  _homeViewGetXController
                                                      .categories[index].name!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: AppSize.s24,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: AppSize.s24,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.shortcut,
                                    style: getMediumStyle(
                                      color: ColorManager.primaryDark,
                                      fontSize: FontSize.s18,
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                              SizedBox(
                                height: AppSize.s24,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.137,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p16),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: typeOfShortcuts.length,
                                    itemBuilder: (context, index) {
                                      return ShortcutsWidget(
                                        bid: '',
                                        imageUrl: imageShortcuts[index],
                                        text: typeOfShortcuts[index],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(
                    height: AppSize.s24,
                  ),
                  // Most Popular
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.most_popular,
                          style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.allProductScreen);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.more,
                            style: getMediumStyle(
                              color: ColorManager.greyLight,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<HomeViewGetXController>(
                    // id: 'products',
                    builder: (controller) => Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(12),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.mostPopular.length,
                        itemBuilder: (context, index) {
                          return ProductItemNew(
                            index: index,
                            image: controller.mostPopular[index].productImages!
                                        .length ==
                                    0
                                ? ''
                                : controller.mostPopular[index]
                                        .productImages?[index] ??
                                    '',
                            name: controller.mostPopular[index].name ?? '',
                            price: controller.mostPopular[index].price ?? 0,
                            stars: controller.mostPopular[index].stars ?? 0,
                            idProduct: controller.mostPopular[index].id ?? '',
                            isFavorite:
                                controller.mostPopular[index].isFavorite ??
                                    false,
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.previous_order,
                          style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.allProductScreen);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.more,
                            style: getMediumStyle(
                              color: ColorManager.greyLight,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: GetBuilder<CheckOutGetxController>(
                      builder: (controller) => ListView.builder(
                        padding: EdgeInsets.all(8),

                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.customerOrder.length,
                        physics: const BouncingScrollPhysics(),
                        // gridDelegate:
                        //     SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: Constants.crossAxisCount,
                        //   mainAxisExtent: Constants.mainAxisExtent,
                        //   mainAxisSpacing: Constants.mainAxisSpacing,
                        // ),
                        itemBuilder: (context, index) {
                          return Builder(
                            builder: (context) {
                              // Get.put<Product>(
                              //   _homeViewGetXController.products[index],
                              //   tag:
                              //       '${_homeViewGetXController.products[index].id}home',
                              // );
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.11,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.27,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  ImageAssets.brStore),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 14,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        '${controller.customerOrder[index].branch!.storeName}',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: ColorManager.primaryDark)),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: ColorManager.grey,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text('20 min',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    ColorManager.primaryDark)),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  GetBuilder<HomeViewGetXController>(
                    builder: (controller) => controller.isAddsLoading
                        ? Container()
                        : Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.23,
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(
                              children: [
                                isArabic == 'en'
                                    ? Image.asset(ImageAssets.blueRectangle)
                                    : Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        child: Image.asset(
                                          ImageAssets.blueRectangle,
                                        ),
                                      ),
                                Positioned(
                                    top: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Image.asset(
                                        ImageAssets.brIcon,
                                        height: 40,
                                        width: 40,
                                      ),
                                    )),
                                Positioned(
                                    top: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        '${controller.addsList[0].addHeader}',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    )),
                                Positioned(
                                    top: 140,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        '${controller.addsList[0].addDescription}',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                  ),

                  SizedBox(
                    height: AppSize.s24,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.popular_cafe_nearby,
                          style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.allProductScreen);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.more,
                            style: getMediumStyle(
                              color: ColorManager.greyLight,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<HomeViewGetXController>(
                    id: 'nearbyStores',
                    builder: (controller) => Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: ListView.builder(
                        padding: EdgeInsets.all(8),

                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.nearbyStores.length,
                        physics: const BouncingScrollPhysics(),
                        // gridDelegate:
                        //     SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: Constants.crossAxisCount,
                        //   mainAxisExtent: Constants.mainAxisExtent,
                        //   mainAxisSpacing: Constants.mainAxisSpacing,
                        // ),
                        itemBuilder: (context, index) {
                          return Builder(
                            builder: (context) {
                              // Get.put<Product>(
                              //   _homeViewGetXController.products[index],
                              //   tag:
                              //       '${_homeViewGetXController.products[index].id}home',
                              // );
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => StoreView(
                                        branchId:
                                            controller.nearbyStores[index].id!),
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          _homeViewGetXController
                                                          .nearbyStores[index]
                                                          .branchLogoImage ==
                                                      null ||
                                                  _homeViewGetXController
                                                          .nearbyStores[index]
                                                          .branchLogoImage ==
                                                      ''
                                              ? Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.11,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.27,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          ImageAssets
                                                              .coffeeHouse),
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.11,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.27,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          _homeViewGetXController
                                                              .nearbyStores[
                                                                  index]
                                                              .branchLogoImage!),
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                            width: 14,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                          _homeViewGetXController
                                              .nearbyStores[index].branchName!,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: ColorManager.primaryDark)),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer,
                                            color: ColorManager.grey,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text('20 min',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorManager
                                                      .primaryDark)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  GetBuilder<HomeViewGetXController>(
                    builder: (controller) => Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isArabic == 'en'
                                ? Image.asset(
                                    ImageAssets.save,
                                    height: 150,
                                    width: 150,
                                  )
                                : Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: Image.asset(
                                      ImageAssets.save,
                                      height: 150,
                                      width: 150,
                                    ),
                                  ),
                          ),
                          Column(
                            children: [
                              Text(
                                '${AppLocalizations.of(context)!.save_up_to} ${AppLocalizations.of(context)!.aed} ${controller.storeAddsList.isEmpty ? 0 : controller.storeAddsList[0].saveValue}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                'limit time offer on resturants to try',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _customDialogProgress() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s258,
              width: AppSize.s258,
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s38,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo1,
                          height: AppSize.s26,
                          width: AppSize.s28,
                        ),
                        SizedBox(
                          width: AppSize.s12,
                        ),
                        Text(
                          AppLocalizations.of(context)!.ghaf,
                          style: getMediumStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p12,
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Dear Shorooq Mirdif, we havereceived your message andare currently working towardsa solution. We will get back toyou shortly. Thank you for yourpatience!',
                        style: getMediumStyle(
                            color: ColorManager.white, fontSize: FontSize.s12),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s24,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p55,
                          vertical: AppPadding.p8,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryDark,
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.close,
                          style: getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                  ]),
            ),
          );
        });
  }

  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.r8),
      borderSide: BorderSide(
        width: AppSize.s1,
        color: color,
      ),
    );
  }
}
