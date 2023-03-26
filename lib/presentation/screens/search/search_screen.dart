import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/screens/search/search_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/most_popular_product_widget.dart';
import 'package:ghaf_application/presentation/widgets/product_item_new.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../home_view/home_view_getx_controller.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with Helpers {
  // controller.
  HomeViewGetXController _homeViewGetXController =
      Get.put<HomeViewGetXController>(HomeViewGetXController());
  SearchGetxController _searchGetxController =
      Get.put<SearchGetxController>(SearchGetxController());

  @override
  void initState() {
    _searchGetxController.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppSize.s22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        textAlign: TextAlign.start,
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s14,
                        ),
                        onChanged: _homeViewGetXController.onSearch,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p12),
                            child: Image.asset(
                              IconsAssets.search,
                              width: AppSize.s16,
                              height: AppSize.s16,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: AppPadding.p16,
                              vertical: AppPadding.p16),
                          hintText: AppLocalizations.of(context)!.search_flower,
                          hintStyle: getMediumStyle(
                            color: ColorManager.hintTextFiled,
                          ),
                          enabledBorder: buildOutlineInputBorder(
                            color: ColorManager.grey,
                          ),
                          focusedBorder: buildOutlineInputBorder(
                            color: ColorManager.grey,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    // Spacer(),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                GetBuilder<SearchGetxController>(
                  id: 'recentSearch',
                  builder: (controller) =>  _searchGetxController.recentSearch == null ||
                          _searchGetxController.recentSearch == []
                      ? Container()
                      : Text(
                          AppLocalizations.of(context)!.recent_search,
                          style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s18,
                          ),
                        ),
                ),
                GetBuilder<SearchGetxController>(
                  id: 'recentSearch',
                  builder: (controller) => controller.isLoadingRecentSearches
                      ? Container()
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p16),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                // childAspectRatio: 0.4,
                                mainAxisExtent: 40,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 20,
                              ),
                              physics: BouncingScrollPhysics(),
                              itemCount: controller.recentSearch!.length < 4 ? controller.recentSearch!.length : 4,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    _homeViewGetXController.onSearch(_searchGetxController
                                        .recentSearch![index]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: ColorManager.greyLight)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.av_timer_rounded,
                                          color: ColorManager.greyLight,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.02,
                                        ),
                                        Flexible(
                                          child: Text(
                                            _searchGetxController
                                                .recentSearch![index],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ),
                GetBuilder<SearchGetxController>(
                  id: 'recentSearch',
                  builder: (controller) =>  _searchGetxController.recentSearch == null ||
                      _searchGetxController.recentSearch == []
                      ? Container()
                      : Divider(color: ColorManager.greyLight, thickness: 4),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                GetBuilder<SearchGetxController>(
                  id: 'popularSearches',
                  builder: (controller) =>  _searchGetxController.popularSearch == null ||
                      _searchGetxController.popularSearch == []
                      ? Container()
                      : Text(
                    AppLocalizations.of(context)!.popular_search,
                    style: getMediumStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                ),
                GetBuilder<SearchGetxController>(
                  id: 'popularSearches',
                  builder: (controller) => controller.isLoadingPopularSearches
                      ? Container()
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p16),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                // childAspectRatio: 0.4,
                                mainAxisExtent: 40,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 20,
                              ),
                              physics: BouncingScrollPhysics(),
                              itemCount:
                                  _searchGetxController.popularSearch?.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    _homeViewGetXController.onSearch(_searchGetxController
                                        .popularSearch?[index]
                                        .productName);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: ColorManager.greyLight)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.stacked_line_chart,
                                          color: ColorManager.greyLight,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.02,
                                        ),
                                        Flexible(
                                          child: Text(
                                            _searchGetxController
                                                    .popularSearch?[index]
                                                    .productName ??
                                                '',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ),
                GetBuilder<SearchGetxController>(
                  id: 'popularSearches',
                  builder: (controller) =>  _searchGetxController.popularSearch == null ||
                      _searchGetxController.popularSearch == []
                      ? Container()
                      : Divider(color: ColorManager.greyLight, thickness: 4),
                ),
                GetBuilder<HomeViewGetXController>(
                  builder: (controller) =>  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 350,
                        crossAxisSpacing: 0),
                    itemCount: controller.products.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductItemNew(
                            image: controller
                                .products[index].productImages?.length == 0 ? '' : controller
                                .products[index].productImages?[0] ?? '',
                            name: controller.products[index].name!,
                            stars: controller.products[index].stars!,
                            price: controller.products[index].price!,
                            idProduct:
                            controller.products[index].id!,
                        isFavorite: controller.products[index].isFavorite!,
                        index: index),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
