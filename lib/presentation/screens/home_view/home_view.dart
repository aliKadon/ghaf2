import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../app/constants.dart';
import '../../../app/preferences/shared_pref_controller.dart';
import '../../../app/utils/app_shared_data.dart';
import '../../../app/utils/helpers.dart';
import '../../../domain/model/product.dart';
import '../../../providers/product_provider.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/nearby_widget.dart';
import '../../widgets/previous_order_widget.dart';
import '../../widgets/product_item_new.dart';
import '../../widgets/shortcuts_widget.dart';
import '../../widgets/slider_image.dart';
import '../addresses_view/addresses_view_getx_controller.dart';
import '../checkout/check_out_getx_controller.dart';
import '../checkout/order_tracking_screen.dart';
import '../login_view/login_view_getx_controller.dart';
import '../orders/orders_screen.dart';
import '../products_screen/all_products_screen.dart';
import '../profile/notification/notification_view.dart';
import '../profile/profile_setting/profile_setting_getx_controller.dart';
import '../search/search_screen.dart';
import '../store_by_category/store_by_category.dart';
import '../subscribe_view/subscribe_view_getx_controller.dart';
import 'address_home.dart';
import 'home_view_getx_controller.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static var result = null;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with Helpers {
  // controller.

  var isLoading = true;
  var language = SharedPrefController().lang1;

  late Position position;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  // ScrollPhysics phisics = BouncingScrollPhysics();

  // ScrollController _scrollController = ScrollController();
  // ScrollDirection _scrollDirection = ScrollDirection.idle;

  // final _innerListKey = GlobalKey();
  // final _scrollController = ScrollController();
  // final _innerScrollController = ScrollController();
  //
  // void _scrollListener() {
  //   // Get the position of the inner ListView
  //   final innerPosition =
  //       _innerListKey.currentContext?.findRenderObject() as RenderBox;
  //   final innerOffset = innerPosition?.localToGlobal(Offset.zero);
  //
  //   // If the inner ListView has reached the end, scroll the outer widget
  //   if (_innerScrollController.offset >=
  //           _innerScrollController.position.minScrollExtent &&
  //       !_innerScrollController.position.outOfRange) {
  //     // print('================================== new scroll');
  //     final double outerOffset = _scrollController.position.maxScrollExtent -
  //         innerPosition.size.height;
  //     _scrollController.jumpTo(-(AppSize.s50));
  //   }
  //
  //   if (_innerScrollController.offset >=
  //           _innerScrollController.position.maxScrollExtent &&
  //       !_innerScrollController.position.outOfRange) {
  //     // print('================================== new scroll');
  //     final double outerOffset = _scrollController.position.maxScrollExtent -
  //         innerPosition.size.height;
  //     _scrollController.jumpTo(AppSize.s110);
  //   }
  // }

  //***********************************//
  //check if it is the bottom of grid
  // void scrollListener() {
  //   print('you in listner');
  //
  //   if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
  //     if (phisics is BouncingScrollPhysics) {
  //       setState(() {
  //         phisics = NeverScrollableScrollPhysics();
  //       });
  //       print('one');
  //     }else {
  //       setState(() {
  //         phisics == BouncingScrollPhysics();
  //       });
  //       print('two');
  //     }
  //   }
  //
  //
  //   if(_scrollController.offset >=
  //       _scrollController.position.minScrollExtent &&
  //       !_scrollController.position.outOfRange) {
  //     print('==============================up');
  //     if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
  //       if (phisics is BouncingScrollPhysics) {
  //         setState(() {
  //           phisics = NeverScrollableScrollPhysics();
  //         });
  //         print('one');
  //       }else {
  //         setState(() {
  //           phisics == BouncingScrollPhysics();
  //         });
  //         print('two');
  //       }
  //     }
  //
  //     print(phisics);
  //
  //   }
  //   if (_scrollController.offset >=
  //       _scrollController.position.maxScrollExtent &&
  //       !_scrollController.position.outOfRange) {
  //     print("reached the bottom");
  //
  //     if(_scrollController.position.userScrollDirection ==
  //         ScrollDirection.reverse) {
  //       print('========================it is ok');
  //     }
  //
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.reverse ) {
  //       print('=========================scroll down');
  //       if (phisics is BouncingScrollPhysics) {
  //         setState(() {
  //           phisics = NeverScrollableScrollPhysics();
  //         });
  //         print('one');
  //       }else {
  //         setState(() {
  //           phisics = BouncingScrollPhysics();
  //         });
  //         print('two');
  //       }
  //
  //       print(phisics);
  //
  //     }
  //   }
  // }
  //*******************************************//

  Future<Position> getLocation() async {
    position = await _geolocatorPlatform.getCurrentPosition();
    print('===================my position');
    print(
      position.toString(),
    );
    SharedPrefController().setLocationLat(locationLat: position.latitude);
    SharedPrefController().setLocationLong(locationLong: position.longitude);
    return position;
  }

  // controller.
  HomeViewGetXController _homeViewGetXController =
      Get.put<HomeViewGetXController>(HomeViewGetXController());
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());

  // final Product _product = Get.put(Product());
  late final ProfileSettingGetxController _profileSettingGetxController =
      Get.put(ProfileSettingGetxController());
  late final AddressesViewGetXController _addressesViewGetXController =
      Get.put(AddressesViewGetXController(context: context));

  bool _doubleBackToExitPressedOnce = false;

  // init state.
  @override
  void initState() {
    _homeViewGetXController.getRegStatus(context: context);
    _homeViewGetXController.init(context: context);
    _addressesViewGetXController.onInit();

    // Get.put(Product());
    Get.put(LoginViewGetXController(context: context));
    if (AppSharedData.currentUser != null) {
      // _profileSettingGetxController.getUserDetails(context);
      _profileSettingGetxController.init(context: context);
      _checkOutGetxController.getCustomerOrder(context: context);
    }

    _homeViewGetXController.determinePosition().then((value) => getLocation()
        .then((value) => _homeViewGetXController.GetAddressFromLatLong(
                LatLng(position.latitude, position.longitude))
            .then((value) => _homeViewGetXController.getNearbyStores(
                lat: position.latitude.toString(),
                long: position.longitude.toString()))));
    super.initState();
    // _scrollController.addListener(scrollListener);
    // _innerScrollController.addListener(_scrollListener);
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

  var updateWidget;

  List<String> imageShortcuts = [
    ImageAssets.trending,
    ImageAssets.homeOffers,
    ImageAssets.homePastOrder,
    ImageAssets.logo2,
    ImageAssets.warranty,
    ImageAssets.faster,
  ];

  @override
  Widget build(BuildContext context) {
    print("============================my address1");
    print(HomeView.result);
    // if (AppSharedData.currentUser == null) {
    //   setState(() {
    //     HomeView.result = null;
    //   });
    // }
    print(HomeView.result);
    List<String> typeOfShortcuts = [
      AppLocalizations.of(context)!.trending,
      AppLocalizations.of(context)!.offers,
      AppLocalizations.of(context)!.past_order,
      AppLocalizations.of(context)!.only_on_ghaf,
      AppLocalizations.of(context)!.top_rated,
      AppLocalizations.of(context)!.fastest_delivery,
    ];
    SubscribeViewGetXController _subscribeViewGetXController =
        Get.put(SubscribeViewGetXController(context: context));
    var isArabic = SharedPrefController().lang1;
    return ChangeNotifierProvider.value(
      value: ProductProvider(),
      child: Scaffold(
        floatingActionButton: AppSharedData.currentUser == null
            ? Container()
            : Container(
                width: AppSize.s73,
                height: AppSize.s73,
                child: FloatingActionButton(
                  onPressed: () {
                    // Add your onPressed code here!
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OrdersScreen(),
                    ));
                  },
                  backgroundColor: ColorManager.primary,
                  child: Padding(
                    padding: EdgeInsets.all(AppSize.s6),
                    child: Image.asset(
                      ImageAssets.delivery_gif,
                      color: Colors.white,
                      width: AppSize.s55,
                      height: AppSize.s55
                    ),
                  ),
                ),
              ),
        body: WillPopScope(
          onWillPop: _onWillPop,
          child: SafeArea(
            child: SingleChildScrollView(
              // controller: _scrollController,
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
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p16,),
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
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.826,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        //NotificationView
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationView(),
                                        ));
                                      },
                                      child: Image.asset(
                                        'assets/icons/bell.png',
                                        height: AppSize.s26,
                                        width: AppSize.s26,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 8.w,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.hello_welcome,
                                    style: getRegularStyle(
                                        color: ColorManager.blackLight,
                                    fontSize: AppSize.s15,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width:
                                  //       MediaQuery.of(context).size.width * 0.38,
                                  // ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.44,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        ImageAssets.homePoints,
                                        height: AppSize.s18,
                                        width: AppSize.s20,
                                      ),

                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.16,
                                        child: Text(
                                            '${AppSharedData.currentUser?.customerPoints ?? 0} ${AppLocalizations.of(context)!.point}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: ColorManager.primaryDark,
                                                fontWeight: FontWeight.bold,
                                                fontSize: FontSize.s14)),
                                      ),
                                      // SizedBox(
                                      //   width: MediaQuery.of(context).size.width *
                                      //       0.03,
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.myFavorite);
                                        },
                                        child: Image.asset(
                                          IconsAssets.heart,
                                          height: AppSize.s20,
                                          width: AppSize.s20,
                                          color: ColorManager.primaryDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GetBuilder<AddressesViewGetXController>(
                                    id: 'isAddressesLoading',
                                    builder: (controller) => Container(
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (AppSharedData.currentUser ==
                                              null) {
                                            showSignInSheet(
                                                context: context,
                                                role: Constants
                                                    .roleRegisterCustomer);
                                          } else {
                                            HomeView.result =
                                                await Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  AddressHome(),
                                            ));
                                            setState(() {
                                              updateWidget = HomeView.result;
                                            });
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            AppSharedData.currentUser == null
                                                ? Text(
                                                    '${AppLocalizations.of(context)!.shipping} ${AppLocalizations.of(context)!.address}',
                                                    style: getRegularStyle(
                                                        color: ColorManager
                                                            .primaryDark,
                                                      fontSize: FontSize.s14
                                                    ),
                                                  )
                                                : Text(
                                                    '${AppLocalizations.of(context)!.shipping} ${HomeView.result == null ? controller.addresses == null || controller.addresses.length == 0 ? AppLocalizations.of(context)!.address : controller.addresses[0].addressName : HomeView.result['addressName']}',
                                                    style: getRegularStyle(
                                                        color: ColorManager
                                                            .primaryDark,
                                                        fontSize: FontSize.s14
                                                    ),
                                                  ),
                                            Icon(Icons.arrow_drop_down,
                                            size: AppSize.s24,
                                            )
                                          ],
                                        ),
                                      ),
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
                                  left: AppMargin.m16,),
                              child: Container(
                                  padding: EdgeInsets.all(AppSize.s10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s10),
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
                                        Icon(Icons.search,
                                        size: AppSize.s30,
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .search_flower,
                                          style: TextStyle(
                                            fontSize: AppSize.s15
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                        InkWell(
                          onTap: _homeViewGetXController.onFilterButtonTapped,
                          child: Image.asset(
                            IconsAssets.filter,
                            width: AppSize.s40,
                            height: AppSize.s55,
                            color: ColorManager.primary,
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
                                _homeViewGetXController.regStatus.status!
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: [
                                            Image.asset(
                                              ImageAssets.main4,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.21,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.55,
                                              fit: BoxFit.fill,
                                            ),
                                            isArabic == 'en'
                                                ? Positioned(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.35,
                                                    top: AppSize.s65,
                                                    child: Image.asset(
                                                      ImageAssets.imageInMain4,
                                                      height: AppSize.s110,
                                                      width: AppSize.s110,
                                                      fit: BoxFit.fill,
                                                    ))
                                                : Positioned(
                                                    right: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.37,
                                                    top: AppSize.s65,
                                                    child: Image.asset(
                                                      ImageAssets.imageInMain4,
                                                      height: AppSize.s110,
                                                      width: AppSize.s110,
                                                    )),
                                            PositionedDirectional(
                                              top: AppSize.s24,
                                              start: AppSize.s10,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text for image up
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .upgrade_your_shopping_experience,
                                                    style: TextStyle(
                                                        height: AppSize.s1,
                                                        fontSize: FontSize.s20,
                                                        fontFamily:
                                                            FontConstants
                                                                .fontFamily,
                                                        color: ColorManager
                                                            .primaryDark,
                                                        fontWeight:
                                                            FontWeightManager
                                                                .medium),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .easy_and_comfortable,
                                                    style: getMediumStyle(
                                                        color: ColorManager
                                                            .primaryDark,
                                                        fontSize: FontSize.s16),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02),
                                                  AppSharedData.currentUser
                                                              ?.ghafGold ??
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
                                                                    context:
                                                                        context);
                                                          },
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .unSubscribe,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    FontSize
                                                                        .s14),
                                                          ))
                                                      : ElevatedButton(
                                                          // onPressed: () {},
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStatePropertyAll(
                                                                      ColorManager
                                                                          .primaryDark)),
                                                          onPressed: () {
                                                            if (AppSharedData
                                                                    .currentUser ==
                                                                null) {
                                                              showSignInSheet(
                                                                  context:
                                                                      context,
                                                                  role:
                                                                      'Customer');
                                                            } else {
                                                              _homeViewGetXController
                                                                  .onGhafIconTapped();
                                                            }
                                                          },
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .subscribe_to_ghaf_gold,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    FontSize
                                                                        .s14),
                                                          ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: AppSize.s24,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p16),
                                  child: GetBuilder<HomeViewGetXController>(
                                    id: 'categories',
                                    builder:
                                        (HomeViewGetXController controller) {
                                      return Container(
                                        child: GridView.builder(
                                          // key: _innerListKey,
                                          // controller: _innerScrollController,
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisSpacing: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01,
                                                  // childAspectRatio: AppDimensions.getHeight(0.4,context),
                                                  childAspectRatio: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.0001,
                                                  crossAxisSpacing: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.01,
                                                  mainAxisExtent:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.14),
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: _homeViewGetXController
                                              .categories.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      StoreByCategory(
                                                          nameStore:
                                                              _homeViewGetXController
                                                                  .categories[
                                                                      index]
                                                                  .name!,
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
                                                      padding: EdgeInsets
                                                              .all(MediaQuery.of(context).size.height * 0.0015),
                                                      child: _homeViewGetXController
                                                                  .categories[
                                                                      index]
                                                                  .categoryImageData ==
                                                              null
                                                          ? Image.asset(
                                                              ImageAssets
                                                                  .grocery,
                                                              fit: BoxFit
                                                                  .scaleDown)
                                                          : Image.network(
                                                              _homeViewGetXController
                                                                  .categories[
                                                                      index]
                                                                  .categoryImageData!,
                                                              height:
                                                                  AppSize.s70,
                                                              width:
                                                                  AppSize.s92,
                                                              fit: BoxFit
                                                                  .scaleDown),
                                                    ),
                                                  ),
                                                  Text(
                                                    language == 'en'
                                                        ? _homeViewGetXController
                                                            .categories[index]
                                                            .name!
                                                        : _homeViewGetXController
                                                                    .categories[
                                                                        index]
                                                                    .categoriesAr?.name ==
                                                                null
                                                            ? _homeViewGetXController
                                                                .categories[
                                                                    index]
                                                                .name!
                                                            : _homeViewGetXController
                                                                .categories[
                                                                    index]
                                                                .categoriesAr!.name!,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            FontSize.s10),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                // SizedBox(
                                //   height: AppSize.s16,
                                // ),
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
                                  height: AppSize.s8,
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.137,
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
                      height: AppSize.s16,
                    ),
                    // Most Popular
                    GetBuilder<HomeViewGetXController>(
                      builder: (controller) => Padding(
                        padding: controller.mostPopular.length == 0
                            ? EdgeInsets.symmetric(horizontal: 0)
                            : EdgeInsets.symmetric(horizontal: AppPadding.p24),
                        child: controller.mostPopular.length == 0
                            ? Container()
                            : Row(
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
                                          context, Routes.allProductScreen,
                                          arguments: 'mostPopular');
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
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context)
                              .size
                              .height *
                              0.012,
                        ),
                        Container(
                          child: GetBuilder<HomeViewGetXController>(
                            // id: 'products',
                            builder: (controller) => Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: controller.mostPopular.length == 0
                                  ? 0
                                  : MediaQuery.of(context).size.height * 0.34,
                              child: controller.mostPopular.length == 0
                                  ? Container()
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.0050),
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: controller.mostPopular.length,
                                      itemBuilder: (context, index) {
                                        return Builder(builder: (context) {
                                          Get.put<Product>(
                                            controller.mostPopular[index],
                                            tag:
                                                '${controller.mostPopular[index].id}',
                                          );
                                          return ProductItemNew(
                                            tag:
                                                '${controller.mostPopular[index].id}',
                                            index: index,
                                            image: controller
                                                        .mostPopular[index]
                                                        .productImages!
                                                        .length ==
                                                    0
                                                ? ''
                                                : controller.mostPopular[index]
                                                        .productImages?[0] ??
                                                    '',
                                            name: controller
                                                    .mostPopular[index].name ??
                                                '',
                                            price: controller
                                                    .mostPopular[index].price ??
                                                0,
                                            stars: controller
                                                    .mostPopular[index].stars ??
                                                0,
                                            idProduct: controller
                                                    .mostPopular[index].id ??
                                                '',
                                            isFavorite: controller
                                                    .mostPopular[index]
                                                    .isFavorite ??
                                                false,
                                          );
                                        });
                                      },
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSharedData.currentUser == null
                        ? Container()
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppPadding.p24),
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .previous_order,
                                      style: getMediumStyle(
                                        color: ColorManager.primaryDark,
                                        fontSize: FontSize.s18,
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.allProductScreen,
                                            arguments: 'order');
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
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                child: GetBuilder<CheckOutGetxController>(
                                  builder: (controller) => ListView.builder(
                                    padding:
                                        controller.customerOrder.length == 0
                                            ? EdgeInsets.all(0)
                                            : EdgeInsets.all(MediaQuery.of(context).size.height * 0.005,),

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
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                OrderTrackingScreen(
                                                    orderId: controller
                                                        .customerOrder[index]
                                                        .id!,
                                                    source: controller
                                                            .customerOrder[
                                                                index]
                                                            .deliveryPoint ??
                                                        controller
                                                            .customerOrder[
                                                                index]
                                                            .branch!
                                                            .branchAddress!,
                                                    destination: controller
                                                        .customerOrder[index]
                                                        .branch!
                                                        .branchAddress!),
                                          ));
                                        },
                                        child: Builder(
                                          builder: (context) {
                                            // Get.put<Product>(
                                            //   _homeViewGetXController.products[index],
                                            //   tag:
                                            //       '${_homeViewGetXController.products[index].id}home',
                                            // );
                                            return _addressesViewGetXController
                                                    .isAddressesLoading
                                                ? Container()
                                                : PreviousOrderWidget(
                                                    addressLat: HomeView
                                                                .result ==
                                                            null
                                                        ? _addressesViewGetXController
                                                                    .addresses
                                                                    .length ==
                                                                0
                                                            ? null
                                                            : _addressesViewGetXController
                                                                .addresses[0]
                                                                .altitude
                                                        : HomeView
                                                            .result['lat'],
                                                    addressLong: HomeView
                                                                .result ==
                                                            null
                                                        ? _addressesViewGetXController
                                                                    .addresses
                                                                    .length ==
                                                                0
                                                            ? null
                                                            : _addressesViewGetXController
                                                                .addresses[0]
                                                                .longitude
                                                        : HomeView
                                                            .result['long'],
                                                    storeName: controller
                                                        .customerOrder[index]
                                                        .branch!
                                                        .storeName!,
                                                    storeAddress: controller
                                                        .customerOrder[index]
                                                        .branch!
                                                        .branchAddress!,
                                                    storeImage: controller
                                                        .customerOrder[index]
                                                        .branch!
                                                        .branchLogoImage!,
                                                  );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                    GetBuilder<HomeViewGetXController>(
                        builder: (controller) => controller.isAddsLoading
                            ? Container()
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.addsList.length,
                                itemBuilder: (context, index) {
                                  return SliderImage(

                                      listAdds: controller.addsList,
                                      imagesUrl: controller
                                          .addsList[index].imageToShow!,
                                      header:
                                          controller.addsList[index].addHeader!,
                                      addDescription: controller
                                          .addsList[index].addDescription!,
                                      addFooter: controller
                                          .addsList[index].addFooter!);
                                },
                              )),

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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AllProductScreen(
                                        type: 'near',
                                        addressLong: HomeView.result == null
                                            ? _addressesViewGetXController
                                                        .addresses.length ==
                                                    0
                                                ? null
                                                : _addressesViewGetXController
                                                    .addresses[0].longitude
                                            : HomeView.result['long'],
                                        addressLat: HomeView.result == null
                                            ? _addressesViewGetXController
                                                        .addresses.length ==
                                                    0
                                                ? null
                                                : _addressesViewGetXController
                                                    .addresses[0].altitude
                                            : HomeView.result['lat'],
                                      )));
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
                      builder: (controller) => Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: ListView.builder(
                          padding: EdgeInsets.all(AppSize.s8),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.nearbyStores.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Builder(
                              builder: (context) {
                                return _addressesViewGetXController
                                        .isAddressesLoading
                                    ? Container()
                                    : NearByWidget(
                                        addressLat: HomeView.result == null
                                            ? _addressesViewGetXController
                                                        .addresses.length ==
                                                    0
                                                ? null
                                                : _addressesViewGetXController
                                                    .addresses[0].altitude
                                            : HomeView.result['lat'],
                                        addressLong: HomeView.result == null
                                            ? _addressesViewGetXController
                                                        .addresses.length ==
                                                    0
                                                ? null
                                                : _addressesViewGetXController
                                                    .addresses[0].longitude
                                            : HomeView.result['long'],
                                        is24: controller.nearbyStores[index]
                                                .is24Hours ??
                                            false,
                                        details: controller
                                                .nearbyStores[index].details ??
                                            '',
                                        index: index,
                                        imageUrl: controller
                                                        .nearbyStores[index]
                                                        .branchLogoImage
                                                        ?.length ==
                                                    0 ||
                                                controller.nearbyStores[index]
                                                        .branchLogoImage ==
                                                    null
                                            ? ''
                                            : controller.nearbyStores[index]
                                                .branchLogoImage!,
                                        storeName: controller
                                            .nearbyStores[index].branchName!,
                                        branchId:
                                            controller.nearbyStores[index].id!,
                                        address: controller
                                            .nearbyStores[index].branchAddress!,
                                      );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    GetBuilder<HomeViewGetXController>(
                      builder: (controller) =>
                          controller.storeAddsList.length == 0
                              ? Container()
                              : Card(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.all(AppSize.s9),
                                        child: isArabic == 'en'
                                            ? Image.asset(
                                                ImageAssets.save,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                              )
                                            : Transform(
                                                alignment: Alignment.center,
                                                transform:
                                                    Matrix4.rotationY(math.pi),
                                                child: Image.asset(
                                                  ImageAssets.save,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                ),
                                              ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${controller.storeAddsList[0].addHeader} ${AppLocalizations.of(context)!.aed} ${controller.storeAddsList.isEmpty ? 0 : controller.storeAddsList[0].saveValue}',
                                            style: TextStyle(
                                                fontSize: FontSize.s16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          Text(
                                            '${controller.storeAddsList[0].addDescription}',
                                            style: TextStyle(
                                                fontSize: FontSize.s12,
                                                fontWeight: FontWeight.w700),
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
      ),
    );
  }

  // void _customDialogProgress() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           child: Container(
  //             height: AppSize.s258,
  //             width: AppSize.s258,
  //             decoration: BoxDecoration(
  //               color: ColorManager.primary,
  //               borderRadius: BorderRadius.circular(AppRadius.r8),
  //             ),
  //             child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   SizedBox(
  //                     height: AppSize.s38,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Image.asset(
  //                         ImageAssets.logo1,
  //                         height: AppSize.s26,
  //                         width: AppSize.s28,
  //                       ),
  //                       SizedBox(
  //                         width: AppSize.s12,
  //                       ),
  //                       Text(
  //                         AppLocalizations.of(context)!.ghaf,
  //                         style: getMediumStyle(
  //                             color: ColorManager.primaryDark,
  //                             fontSize: FontSize.s20),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: AppSize.s30,
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.symmetric(
  //                       horizontal: AppPadding.p12,
  //                     ),
  //                     child: Text(
  //                       textAlign: TextAlign.center,
  //                       'Dear Shorooq Mirdif, we havereceived your message andare currently working towardsa solution. We will get back toyou shortly. Thank you for yourpatience!',
  //                       style: getMediumStyle(
  //                           color: ColorManager.white, fontSize: FontSize.s12),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: AppSize.s24,
  //                   ),
  //                   GestureDetector(
  //                     onTap: () => Navigator.pop(context),
  //                     child: Container(
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: AppPadding.p55,
  //                         vertical: AppPadding.p8,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: ColorManager.primaryDark,
  //                         borderRadius: BorderRadius.circular(AppRadius.r8),
  //                       ),
  //                       child: Text(
  //                         AppLocalizations.of(context)!.close,
  //                         style: getMediumStyle(color: ColorManager.white),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: AppSize.s12,
  //                   ),
  //                 ]),
  //           ),
  //         );
  //       });
  // }

  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.r8),
      borderSide: BorderSide(
        width: AppSize.s1,
        color: color,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_doubleBackToExitPressedOnce) {
      return true;
    }

    _doubleBackToExitPressedOnce = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Press back again to exit')),
    );

    Timer(Duration(seconds: 2), () {
      _doubleBackToExitPressedOnce = false;
    });

    return false;
  }
}
