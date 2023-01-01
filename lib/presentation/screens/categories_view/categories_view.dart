import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/domain/model/category.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/screens/categories_view/categories_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/product_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  // controller.
  late final CategoriesViewGetXController _categoriesViewGetXController =
      Get.put(CategoriesViewGetXController());

  // init state.
  @override
  void initState() {
    _categoriesViewGetXController.init(
      context: context,
    );
    Provider.of<ProductProvider>(context,listen: false).getProducts();
    super.initState();
  }

  // dispose.
  @override
  void dispose() {
    Get.delete<CategoriesViewGetXController>();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProductProvider>(context).product;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.categories,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Divider(height: 1, color: ColorManager.greyLight),
                SizedBox(
                  height: AppSize.s12,
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1,
                    width: MediaQuery.of(context).size.width * 1,
                    child: GetBuilder<CategoriesViewGetXController>(
                      id: 'isLoading',
                      builder: (controller) => controller.isLoading
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                ),
                              ),
                            )
                          : _categoriesViewGetXController.data.isEmpty
                              ? Center(
                                  child: Text(
                                    'No categories found',
                                  ),
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppPadding.p4),
                                    shrinkWrap: true,
                                    itemCount: _categoriesViewGetXController
                                        .data.length,
                                    physics: const BouncingScrollPhysics(),
                                    separatorBuilder: (_, index) => SizedBox(
                                      height: 5.h,
                                    ),
                                    itemBuilder: (context, index) {
                                      final Category category =
                                          _categoriesViewGetXController
                                                  .data[index]['category']
                                              as Category;
                                      final List<Product> products =
                                          _categoriesViewGetXController
                                                  .data[index]['products']
                                              as List<Product>;
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  category.name ?? '',
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Routes.products,
                                                    arguments: products[index].category,
                                                  );
                                                },
                                                child: Text(
                                                  'More',
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          SizedBox(
                                            height: 300.h,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 1,
                                              child: ListView.separated(
                                                itemCount: products.length,
                                                scrollDirection: Axis.horizontal,
                                                separatorBuilder: (_, index) =>
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                itemBuilder: (_, index) =>
                                                    Builder(
                                                      builder: (context) {
                                                        Get.put<Product>(
                                                          products[index],
                                                          tag:
                                                          '${products[index].id}categories',
                                                        );
                                                        return SizedBox(
                                                          width: 150.w,
                                                          child: ProductWidget(
                                                            tag:
                                                            '${products[index].id}categories',
                                                          ),
                                                        );
                                                      },
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
