import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/my_favorite_screen/my_favorite_screen_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/product_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({Key? key}) : super(key: key);

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  // controller.
  late final MyFavoriteScreenGetXController _myFavoriteScreenGetXController =
      Get.put(MyFavoriteScreenGetXController());

  // init state.
  @override
  void initState() {
    _myFavoriteScreenGetXController.init(
      context: context,
    );
    super.initState();
  }

  // dispose.
  @override
  void dispose() {
    Get.delete<MyFavoriteScreenGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)!.my_favorite}'),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.all(16.h),
        child: GetBuilder<MyFavoriteScreenGetXController>(
          id: 'myFavorite',
          builder: (controller) => controller.isMyFavoriteLoading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                )
              : _myFavoriteScreenGetXController.products.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.no_product_found,
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p8, vertical: AppPadding.p4),
                      itemCount:
                          _myFavoriteScreenGetXController.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Constants.crossAxisCount,
                        mainAxisExtent: Constants.mainAxisExtent,
                        mainAxisSpacing: Constants.mainAxisSpacing,
                      ),
                      itemBuilder: (context, index) {
                        return Builder(builder: (context) {
                          Get.put<Product>(
                            _myFavoriteScreenGetXController.products[index],
                            tag:
                                '${_myFavoriteScreenGetXController.products[index].id}myFavorite',
                          );
                          return ProductWidget(
                            tag:
                                '${_myFavoriteScreenGetXController.products[index].id}myFavorite',
                          );
                        });
                      },
                    ),
        ),
      ),
    );
  }
}
