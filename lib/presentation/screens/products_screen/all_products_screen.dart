import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/products_screen/products_screen_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/product2_widget.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/constants.dart';
import '../../../domain/model/product.dart';
import '../../resources/values_manager.dart';

class AllProductScreen extends StatefulWidget {

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {

  // controller.
  late final ProductsScreenGetXController _productsScreenGetXController =
  Get.put(ProductsScreenGetXController());

  var isLoading = true;

  @override
  void initState() {
    // _productsScreenGetXController.init(
    //   context: context,
    //   categoryId: widget.category.id.toString(),
    // );
    Provider.of<ProductProvider>(context,listen: false).getProducts().then((value) => isLoading = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<ProductProvider>(context).product;
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.all(16.h),
        child: isLoading
              ? Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          )
              : product.isEmpty
              ? Center(
            child: Text(
              'No products found',
            ),
          )
              : GridView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p8, vertical: AppPadding.p4),
            itemCount: product.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Constants.crossAxisCount,
              mainAxisExtent: Constants.mainAxisExtent,
              mainAxisSpacing: Constants.mainAxisSpacing,
            ),
            itemBuilder: (context, index) {
              // Get.put<Product>(
              //   _productsScreenGetXController.products[index],
              //   tag:
              //   '${_productsScreenGetXController.products[index].id}products',
              // );
              return ProductWidget2(product[index]);

            },
          ),
        ),

    );
  }
}
