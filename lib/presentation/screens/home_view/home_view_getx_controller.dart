import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/auth_api_controller.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/category.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/domain/model/product_type.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/screens/home_view/sheets/filter_sheet_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../../data/api/controllers/adds_api_controller.dart';
import '../../../domain/model/adds.dart';
import '../../../domain/model/nearby_stores.dart';
import '../../../domain/model/reg_status.dart';
import '../../../domain/model/store_adds.dart';
import '../checkout/check_out_getx_controller.dart';

class HomeViewGetXController extends GetxController with Helpers {
  String address = '';
  var city = 'your address'.obs;
  var isLoadingPopular = true;
  var isFave = false;

  // var durationForNearByStore = [];

  // controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());

  // #############################################
  //get all information from latitude and longitude
  // #############################################
  Future<void> GetAddressFromLatLong(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    print('======================================my address');
    print(placemarks[0]);
    Placemark place = placemarks[0];
    city.value = (place.locality)!;
    SharedPrefController().setCity(city.value);
    print('=====================city');
    print(city);
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  // ##############################################
  // ##############################################

  // notifiable.
  bool _isCategoriesLoading = true;
  bool _isProductsLoading = true;
  bool _isSearching = false;
  bool _isNearbyStoresLoading = true;
  bool isAddsLoading = true;

  bool get isCategoryLoading => _isCategoriesLoading;

  set isCategoryLoading(bool value) {
    _isCategoriesLoading = value;
    update(['categories']);
  }

  bool get isProductsLoading => _isProductsLoading;

  set isProductsLoading(bool value) {
    _isProductsLoading = value;
    // update(['products']);
    update();
  }

  var isFilterProductLoading = true;

  bool get isSearching => _isSearching;

  set isSearching(bool value) {
    _isSearching = value;
    update(['isSearching']);
  }

  // vars.
  late BuildContext context;
  late final StoreApiController _storeApiController = StoreApiController();
  late final AddsApiController _addsApiController = AddsApiController();
  late final AuthApiController _regStatus = AuthApiController();
  List<Category> categories = [];
  List<Product> products = [];
  List<Product> payLaterProduct = [];
  List<Product> mostPopular = [];
  List<Product> freeDeliveryProduct = [];
  List<Product> recommendedProduct = [];
  List<Product> onlyOnghaf = [];
  List<Product> productByType = [];
  List<Adds> addsList = [];
  List<StoreAdds> storeAddsList = [];
  List<NearbyStores> nearbyStores = [];
  List<ProductType> productType = [];
  RegStatus regStatus = RegStatus(status: true,id: 'llllll');
  List<Product> product = [];
  String search = '';
  var isLoadingRecommended = true;
  var isLoadingProductByType = true;

  // filter.
  num? minPrice;
  num? maxPrice;
  String? filterBy;

  // num? minDiscount;
  // num? maxDiscount;

  // init.
  void init({
    required BuildContext context,
  }) {
    this.context = context;
    getAdds(context: context);
    getMostPopularProduct();
    getCategories();
    getProducts(context: context);
    getStoreAdds(context: context);

  }

  void getRegStatus({required BuildContext context}) async {
    try {
      regStatus = (await _regStatus.getRegStatus())!;
      update();
    } catch (e) {
      showSnackBar(context, message: e.toString(), error: true);
    }
  }

  void getFreeDeliveryProduct({required BuildContext context}) async {
    freeDeliveryProduct = await _storeApiController.getFreeDeliveryProducts();
    isFilterProductLoading = false;
    update();
    // try {
    //   freeDeliveryProduct = await _storeApiController.getFreeDeliveryProducts();
    //   isFilterProductLoading = false;
    //   update();
    // } catch (e) {
    //   showSnackBar(context, message: e.toString(), error: true);
    // }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();
  }

  void getMostPopularProduct({String? bid}) async {
    try {
      mostPopular = await _storeApiController.getMostPopularProduct(bid: bid);
      isLoadingPopular = false;
      product = mostPopular;
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  // get categories.
  void getCategories() async {
    categories = await _storeApiController.getCategories();
    print('================category');
    print(categories[0].id!);
    SharedPrefController().setFirstStoreName(categories[0].id!);
    isCategoryLoading = false;
    update();
    // try {
    //   categories = await _storeApiController.getCategories();
    //   print('================category');
    //   print(categories[0].id!);
    //   SharedPrefController().setFirstStoreName(categories[0].id!);
    //   isCategoryLoading = false;
    //   update();
    // } catch (error) {
    //   // error.
    //   showSnackBar(context,
    //       message: 'An Error Occurred, Please Try again', error: true);
    // }
  }

  //get recommended product
  void getRecommendedProductForBranch(
      {required BuildContext context, required String bid}) async {
    try {
      recommendedProduct =
          await _storeApiController.getRecommendedProduct(bid: bid);
      isLoadingRecommended = false;
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  //get product by type
  void getProductByType(
      {required BuildContext context,
      String? bid = '',
      String? productTypeId = ''}) async {
    // productByType = await _storeApiController.getProductByType(
    //     bid: bid, productTypeId: productTypeId,);
    // update();
    try {
      productByType = await _storeApiController.getProductByType(
        bid: bid,
        productTypeId: productTypeId,
      );
      isLoadingProductByType = false;
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  //get only on ghaf
  void getOnlyOnGhaf({required BuildContext context}) async {
    try {
      onlyOnghaf = await _storeApiController.getOnlyOnGhaf();
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  //get product type
  void getProductType({required BuildContext context, String? bid = ''}) async {
    try {
      productType = await _storeApiController.getProductType(bid: bid);
      print(productType);
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  // get products.
  void getFilterProducts({
    required BuildContext context,
    String? sid,
    String search = '',
    num? minPrice,
    num? maxPrice,
    String? filterBy,
    String? stars,
    String? did,
    bool notifyLoading = true,
  }) async {
    // if (notifyLoading) isProductsLoading = true;
    try {
      // if (notifyLoading) isProductsLoading = true;
      // print('NEWWWWWWWWWWWWWWWWWWWWWWWWEWWWWWWWWWWWWWWWWWW');
      // print(ModalRoute.of(context)?.settings.arguments as String);
      products = await _storeApiController.getFilterProducts(
        did: did,
        search: search,
        maxPrice: maxPrice,
        minPrice: minPrice,
        filterBy: filterBy,
        stars: stars,
        // filterBy: ModalRoute.of(context)?.settings.arguments as String,
      );
      isFilterProductLoading = false;
      update();
    } on DioError catch (error) {
      // error.
      print(error.response?.data);
      print(error.toString());
      showSnackBar(context,
          message: 'An Error Occurred, Please Try again', error: true);
    } catch (error) {
      // error.
      debugPrint(error.toString());
      print(error);
      // showSnackBar(context,
      //     message: 'An Error Occurred, Please Try again!!', error: true);
    }
  }

  // get products.
  void getProducts({
    required BuildContext context,
    String? bid,
    bool notifyLoading = true,
  }) async {
    // products = await _storeApiController.getProducts(
    //   bid: bid,
    //   search: search,
    //   maxPrice: maxPrice,
    //   minPrice: minPrice,
    //   filterBy: filterBy,
    //   // filterBy: ModalRoute.of(context)?.settings.arguments as String,
    // );
    // for (Product product in products) {
    //   if (product.canPayLater!) {
    //     payLaterProduct.removeWhere((element) => element.id == product.id);
    //     payLaterProduct.add(product);
    //   }
    // }
    // isProductsLoading = false;

    try {
      if (notifyLoading) isProductsLoading = true;
      // print('NEWWWWWWWWWWWWWWWWWWWWWWWWEWWWWWWWWWWWWWWWWWW');
      // print(ModalRoute.of(context)?.settings.arguments as String);
      products = await _storeApiController.getProducts(
        bid: bid,
        search: search,
        maxPrice: maxPrice,
        minPrice: minPrice,
        filterBy: filterBy,
        // filterBy: ModalRoute.of(context)?.settings.arguments as String,
      );
      for (Product product in products) {
        if (product.canPayLater!) {
          payLaterProduct.removeWhere((element) => element.id == product.id);
          payLaterProduct.add(product);
        }
      }
      isProductsLoading = false;
    } on DioError catch (error) {
      // error.
      print(error.response?.data);
      print(error.toString());
      showSnackBar(context,
          message: 'An Error Occurred, Please Try again', error: true);
    } catch (error) {
      // error.
      debugPrint(error.toString());
      showSnackBar(context,
          message: 'An Error Occurred, Please Try again!!', error: true);
    }
  }

  void getAdds({required BuildContext context}) async {
    try {
      addsList = await _addsApiController.getAdds();
      isAddsLoading = false;
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void getStoreAdds({required BuildContext context}) async {
    try {
      storeAddsList = await _addsApiController.getStoreAdds();
      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void getNearbyStores(
      {
      // required BuildContext context,
      required String lat,
      required String long,
      String? distance}) async {
    try {
      nearbyStores = await _storeApiController.getNearbyStores(
          lat: lat, long: long, distance: distance);
      _isNearbyStoresLoading = false;
      update();
    } catch (error) {
      // showSnackBar(context, message: error.toString(),error: true);
    }
  }

  // // get products By Discount.
  // void getProductsByDiscount({
  //   bool notifyLoading = false,
  // }) async {
  //   try {
  //     if (notifyLoading) isProductsLoading = true;
  //     products = await _storeApiController.getProductsSortedDiscount(
  //       search: search,
  //       maxDiscount: maxPrice,
  //       minDiscount: minPrice,
  //     );
  //     isProductsLoading = false;
  //   } on DioError catch (error) {
  //     // error.
  //     debugPrint(error.response?.data);
  //     debugPrint(error.toString());
  //     showSnackBar(context, message: error.toString(), error: true);
  //   } catch (error) {
  //     // error.
  //     debugPrint(error.toString());
  //     showSnackBar(context, message: error.toString(), error: true);
  //   }
  // }

  // on search.
  void onSearch(String? value) {
    if (value == null || value.isEmpty) {
      isSearching = false;
      search = '';
      getProducts(notifyLoading: true, context: context);
    } else {
      search = value;
      isSearching = true;
      getProducts(notifyLoading: true, context: context);
    }
  }

  // on filter button tapped.
  void onFilterButtonTapped() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      builder: (_) => Builder(
        builder: (context) {
          // Get.put<FilterSheetWidgetGetXController>(
          //   FilterSheetWidgetGetXController(
          //     context: context,
          //     onFilter: filter,
          //     minPrice: minPrice,
          //     maxPrice: maxPrice,
          //     filterBy: filterBy,
          //   ),
          // );
          return FilterSheetWidget();
        },
      ),
    );
  }

  // filter.
  void filter({
    num? minPrice,
    num? maxPrice,
    String? filterBy,
  }) {
    this.minPrice = minPrice;
    this.maxPrice = maxPrice;
    this.filterBy = filterBy;
    getProducts(notifyLoading: true, context: context);
  }

  // on ghaf icon tapped.
  void onGhafIconTapped() {
    Navigator.pushNamed(context, Routes.subscribeFromHomePage);
  }
}
