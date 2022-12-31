import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/home_view/home_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/home_view/widgets/category_widget.dart';
import 'package:ghaf_application/presentation/widgets/product_widget.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // controller.
  HomeViewGetXController _homeViewGetXController =
  Get.put<HomeViewGetXController>(HomeViewGetXController());

  // init state.
  @override
  void initState() {
    _homeViewGetXController.init(context: context);
    super.initState();
  }

  // dispose.
  @override
  void dispose() {
    Get.delete<HomeViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ProductProvider(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        IconsAssets.location,
                        height: AppSize.s20,
                        width: AppSize.s14,
                      ),
                      SizedBox(
                        width: AppSize.s17,
                      ),
                      Text(
                        'Shipping to Dubai',
                        style: getRegularStyle(color: ColorManager.primaryDark),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: _homeViewGetXController.onGhafIconTapped,
                          child: SvgPicture.asset(
                            '${Constants.vectorsPath}ghaf.svg',
                            width: 40.h,
                            height: 40.h,
                            color: AppSharedData.currentUser!.ghafGold ?? false
                                ? Theme
                                .of(context)
                                .primaryColor
                                : null,
                          ),

                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.hello_welcome,
                              style:
                              getRegularStyle(color: ColorManager.blackLight),
                            ),
                            Text(
                              '${AppSharedData.currentUser!
                                  .firstName} ${AppSharedData.currentUser!
                                  .lastName}',
                              style: getBoldStyle(
                                color: ColorManager.blackLight,
                                fontSize: FontSize.s12,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.myFavorite);
                          },
                          child: Image.asset(
                            IconsAssets.heart,
                            height: AppSize.s20,
                            width: AppSize.s20,
                            color: Theme
                                .of(context)
                                .primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Image.asset(
                          ImageAssets.person,
                          height: AppSize.s40,
                          width: AppSize.s40,
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
                              hintText:
                              AppLocalizations.of(context)!.search_flower,
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
                    builder: (controller) =>
                    controller.isSearching
                        ? SizedBox()
                        : Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Image.asset(
                                ImageAssets.main,
                                height: AppSize.s148,
                                width: AppSize.s360,
                                fit: BoxFit.fill,
                              ),
                              PositionedDirectional(
                                top: AppSize.s30,
                                start: AppSize.s30,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .stay_home_we_deliver,
                                      style: TextStyle(
                                          height: 1,
                                          fontSize: FontSize.s30,
                                          fontFamily:
                                          FontConstants.fontFamily,
                                          color: ColorManager.white,
                                          fontWeight:
                                          FontWeightManager.medium),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .any_where_any_time,
                                      style: getMediumStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSize.s12),
                                    ),
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
                          height: AppSize.s85,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p16),
                            child: GetBuilder<HomeViewGetXController>(
                              id: 'categories',
                              builder: (HomeViewGetXController controller) {
                                if (controller.isCategoryLoading) {
                                  return Center(
                                    child: Container(
                                      width: 20.h,
                                      height: 20.h,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      ),
                                    ),
                                  );
                                } else if (controller
                                    .categories.isNotEmpty) {
                                  return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.categories.length,
                                    itemBuilder: (context, index) {
                                      return CategoryWidget(
                                        category:
                                        controller.categories[index],
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      'No categories found',
                                    ),
                                  );
                                }
                              },
                            ),
                            /*
                        ListView.builder(
                            itemCount: controller.listCategory.length,
                            itemBuilder: (context,index){
                          return  Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: AppSize.s8,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: AppSize.s60,
                                  width: AppSize.s60,
                                  padding: EdgeInsets.all(AppPadding.p12),
                                  decoration: BoxDecoration(
                                    color: ColorManager.white,
                                    border: Border.all(
                                        width: AppSize.s0_5,
                                        color: ColorManager.greyLight),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorManager.greyLight,
                                        blurRadius: AppSize.s4,
                                        offset: Offset(AppSize.s0,
                                            AppSize.s4), // Shadow position
                                      ),
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(AppRadius.r4),
                                  ),
                                  child: Image.asset(
                                    IconsAssets.cart,
                                    height: AppSize.s36,
                                    width: AppSize.s36,
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.s6,
                                ),
                                Text(
                                  'Supermarkets',
                                  style: getMediumStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                       */
                            /*
                        ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: AppSize.s8,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: AppSize.s60,
                                    width: AppSize.s60,
                                    padding: EdgeInsets.all(AppPadding.p12),
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      border: Border.all(
                                          width: AppSize.s0_5,
                                          color: ColorManager.greyLight),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorManager.greyLight,
                                          blurRadius: AppSize.s4,
                                          offset: Offset(AppSize.s0,
                                              AppSize.s4), // Shadow position
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(AppRadius.r4),
                                    ),
                                    child: Image.asset(
                                      IconsAssets.cart,
                                      height: AppSize.s36,
                                      width: AppSize.s36,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppSize.s6,
                                  ),
                                  Text(
                                    'Supermarkets',
                                    style: getMediumStyle(
                                      color: ColorManager.primary,
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: AppSize.s8,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: AppSize.s60,
                                    width: AppSize.s60,
                                    padding: EdgeInsets.all(AppPadding.p12),
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      border: Border.all(
                                          width: AppSize.s0_5,
                                          color: ColorManager.greyLight),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorManager.greyLight,
                                          blurRadius: AppSize.s4,
                                          offset: Offset(AppSize.s0,
                                              AppSize.s4), // Shadow position
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(AppRadius.r4),
                                    ),
                                    child: Image.asset(
                                      IconsAssets.cart,
                                      height: AppSize.s36,
                                      width: AppSize.s36,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppSize.s6,
                                  ),
                                  Text(
                                    'Pharmacies',
                                    style: getMediumStyle(
                                      color: ColorManager.primary,
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: AppSize.s8,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: AppSize.s60,
                                    width: AppSize.s60,
                                    padding: EdgeInsets.all(AppPadding.p12),
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      border: Border.all(
                                          width: AppSize.s0_5,
                                          color: ColorManager.greyLight),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorManager.greyLight,
                                          blurRadius: AppSize.s4,
                                          offset: Offset(AppSize.s0,
                                              AppSize.s4), // Shadow position
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(AppRadius.r4),
                                    ),
                                    child: Image.asset(
                                      IconsAssets.cart,
                                      height: AppSize.s36,
                                      width: AppSize.s36,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppSize.s6,
                                  ),
                                  Text(
                                    'Flower shops',
                                    style: getMediumStyle(
                                      color: ColorManager.primary,
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        */
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s4,
                  ),
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
                            Navigator.pushNamed(context, Routes.products);
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
                    id: 'products',
                    builder: (controller) =>
                    controller.isProductsLoading
                        ? Center(
                      child: Container(
                        width: 20.h,
                        height: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ),
                    )
                        : _homeViewGetXController.products.isEmpty
                        ? Center(
                      child: Text(
                        'No products found',
                      ),
                    )
                        : GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p8,
                          vertical: AppPadding.p4),
                      shrinkWrap: true,
                      itemCount:
                      _homeViewGetXController.products.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Constants.crossAxisCount,
                        mainAxisExtent: Constants.mainAxisExtent,
                        mainAxisSpacing: Constants.mainAxisSpacing,
                      ),
                      itemBuilder: (context, index) {
                        return Builder(
                          builder: (context) {
                            Get.put<Product>(
                              _homeViewGetXController.products[index],
                              tag:
                              '${_homeViewGetXController.products[index].id}home',
                            );
                            return ProductWidget(
                              tag:
                              '${_homeViewGetXController.products[index].id}home',
                            );
                          },
                        );
                      },
                    ),
                  ),
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
