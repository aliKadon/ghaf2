import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/home_view/home_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/product_item_new.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../../domain/model/product.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class TrendingView extends StatefulWidget {
  String? bid;

  TrendingView({this.bid});

  @override
  State<TrendingView> createState() => _TrendingViewState();
}

class _TrendingViewState extends State<TrendingView> {
  //controller
  late final HomeViewGetXController _homeViewGetXController =
      Get.put(HomeViewGetXController());

  @override
  void initState() {
    // TODO: implement initState
    _homeViewGetXController.getMostPopularProduct(bid: widget.bid);
    _homeViewGetXController.getProducts(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeViewGetXController>(
        builder: (controller) => controller.isLoadingPopular
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Padding(
                    padding:
                        EdgeInsets.only(left: AppSize.s12, right: AppSize.s12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.038,
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: Image.asset(
                              SharedPrefController().lang1 == 'ar'
                                  ? IconsAssets.arrow2
                                  : IconsAssets.arrow,
                              height: AppSize.s18,
                              width: AppSize.s10,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          AppLocalizations.of(context)!.trending,
                          style: getSemiBoldStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Divider(
                    color: ColorManager.greyLight,
                    thickness: 1,
                  ),
                  controller.mostPopular.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Center(
                            child: Text(
                                AppLocalizations.of(context)!.no_product_found,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.s18,
                                    color: ColorManager.primary)),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.85,
                          padding: EdgeInsets.all(AppSize.s12),
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.mostPopular.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: AppSize.s311),
                            itemBuilder: (context, index) {
                              return Builder(builder: (context) {
                                Get.put<Product>(
                                  controller.mostPopular[index],
                                  tag:
                                      '${controller.mostPopular[index].id}trending',
                                );
                                return ProductItemNew(
                                    tag:
                                        '${controller.mostPopular[index].id}trending',
                                    image: controller.mostPopular[index]
                                                .productImages?.length ==
                                            0
                                        ? ''
                                        : controller.mostPopular[index]
                                            .productImages![0],
                                    name: controller.mostPopular[index].name!,
                                    stars: controller.mostPopular[index].stars!,
                                    index: index,
                                    price: controller.mostPopular[index].price!,
                                    isFavorite: controller
                                        .mostPopular[index].isFavorite!,
                                    // controller: _homeViewGetXController.mostPopular,
                                    idProduct:
                                        controller.mostPopular[index].id!);
                              });
                            },
                          ),
                        ),
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.08,
                  //   padding:EdgeInsets.all(AppSize.s5),
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     child: Row(
                  //       children: [
                  //         Text('30 AED'),
                  //         Spacer(),
                  //         Icon(Icons.shopping_bag_outlined),
                  //         Text(AppLocalizations.of(context)!.add_to_cart)
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
      ),
    );
  }
}
