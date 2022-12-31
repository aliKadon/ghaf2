import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/category.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/screens/home_view/sheets/filter_sheet_widget.dart';
import 'package:ghaf_application/presentation/screens/home_view/sheets/filter_sheet_widget_getx_controller.dart';

class HomeViewGetXController extends GetxController with Helpers {
  // notifiable.
  bool _isCategoriesLoading = true;
  bool _isProductsLoading = true;
  bool _isSearching = false;

  bool get isCategoryLoading => _isCategoriesLoading;

  set isCategoryLoading(bool value) {
    _isCategoriesLoading = value;
    update(['categories']);
  }

  bool get isProductsLoading => _isProductsLoading;

  set isProductsLoading(bool value) {
    _isProductsLoading = value;
    update(['products']);
  }

  bool get isSearching => _isSearching;

  set isSearching(bool value) {
    _isSearching = value;
    update(['isSearching']);
  }

  // vars.
  late BuildContext context;
  late final StoreApiController _storeApiController = StoreApiController();
  List<Category> categories = [];
  List<Product> products = [];
  String search = '';

  // filter.
  num? minPrice;
  num? maxPrice;

  // init.
  void init({
    required BuildContext context,
  }) {
    this.context = context;
    getCategories();
    getProducts();
  }

  // get categories.
  void getCategories() async {
    try {
      categories = await _storeApiController.getCategories();
      isCategoryLoading = false;
    } catch (error) {
      // error.
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  // get products.
  void getProducts({
    bool notifyLoading = false,
  }) async {
    try {
      if (notifyLoading) isProductsLoading = true;
      products = await _storeApiController.getProducts(
        search: search,
        maxPrice: maxPrice,
        minPrice: minPrice,
      );
      isProductsLoading = false;
    } on DioError catch (error) {
      // error.
      debugPrint(error.response?.data);
      debugPrint(error.toString());
      showSnackBar(context, message: error.toString(), error: true);
    } catch (error) {
      // error.
      debugPrint(error.toString());
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  // on search.
  void onSearch(String? value) {
    if (value == null || value.isEmpty) {
      isSearching = false;
      search = '';
      getProducts(notifyLoading: true);
    } else {
      search = value;
      isSearching = true;
      getProducts(notifyLoading: true);
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
          Get.put<FilterSheetWidgetGetXController>(
            FilterSheetWidgetGetXController(
              context: context,
              onFilter: filter,
              minPrice: minPrice,
              maxPrice: maxPrice,
            ),
          );
          return FilterSheetWidget();
        },
      ),
    );
  }

  // filter.
  void filter({
    num? minPrice,
    num? maxPrice,
  }) {
    this.minPrice = minPrice;
    this.maxPrice = maxPrice;
    getProducts(notifyLoading: true);
  }

  // on ghaf icon tapped.
  void onGhafIconTapped() {
    Navigator.pushNamed(context, Routes.subscribeFromHomePage);
  }
}
