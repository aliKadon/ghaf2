import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/products_screen/products_screen_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/product_widget.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  final category;
  // final String categoryName;

  const ProductsScreen({
    Key? key,
    required this.category,
    // required this.categoryName
  }) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // controller.
  late final ProductsScreenGetXController _productsScreenGetXController =
      Get.put(ProductsScreenGetXController());

  // init state.
  @override
  void initState() {
    _productsScreenGetXController.init(
      context: context,
      categoryId: widget.category['id'].toString(),
    );

    super.initState();
  }

  // dispose.
  @override
  void dispose() {
    Get.delete<ProductsScreenGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category['name'].toString()),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.all(16.h),
        child: GetBuilder<ProductsScreenGetXController>(
          id: 'products',
          builder: (controller) => controller.isProductsLoading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                )
              : _productsScreenGetXController.products.isEmpty
                  ? Center(
                      child: Text(
                        'No products found',
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p8, vertical: AppPadding.p4),
                      itemCount: _productsScreenGetXController.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Constants.crossAxisCount,
                        mainAxisExtent: Constants.mainAxisExtent,
                        mainAxisSpacing: Constants.mainAxisSpacing,
                      ),
                      itemBuilder: (context, index) {
                        return Builder(
                          builder: (context) {
                            Get.put<Product>(
                              _productsScreenGetXController.products[index],
                              tag:
                                  '${_productsScreenGetXController.products[index].id}products',
                            );
                            return ProductWidget(
                              tag:
                                  '${_productsScreenGetXController.products[index].id}products',
                            );
                          },
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
