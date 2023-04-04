import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/product_item_new.dart';
import 'home_view_getx_controller.dart';

class FilterScreen extends StatefulWidget {
  String? sid;
  String? filterBy;
  num? maxPrice;
  num? minPrice;
  String search = '';
  String? stars;

  FilterScreen(
      {this.sid,
      required this.search,
      this.filterBy,
      this.maxPrice,
        this.stars,
      this.minPrice});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  //controller
  late final HomeViewGetXController _homeViewGetXController =
      Get.put(HomeViewGetXController());

  @override
  void initState() {
    // TODO: implement initState
    _homeViewGetXController.getFilterProducts(
      context: context,
      sid: widget.sid,
      filterBy: widget.filterBy,
      maxPrice: widget.maxPrice,
      minPrice: widget.minPrice,
      search: widget.search,
      stars:widget.stars,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppSize.s6),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                        color: ColorManager.primaryDark,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.past_order,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Divider(
                thickness: 1,
                color: ColorManager.greyLight,
              ),
              GetBuilder<HomeViewGetXController>(
                builder: (controller) => controller.isFilterProductLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.products.length == 0
                        ? Center(
                            child: Text(
                                AppLocalizations.of(context)!.no_product_found,
                                style: TextStyle(
                                    color: ColorManager.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.s18)),
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 300,
                            ),
                            shrinkWrap: true,
                            itemCount: controller.products.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ProductItemNew(
                                  image: controller.products[index]
                                              .productImages?.length ==
                                          0
                                      ? ''
                                      : controller
                                          .products[index].productImages![0],
                                  name: controller.products[index].name!,
                                  stars: controller.products[index].stars!,
                                  price: controller.products[index].price!,
                                  index: index,
                                  isFavorite:
                                      controller.products[index].isFavorite!,
                                  idProduct: controller.products[index].id!);
                            },
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
