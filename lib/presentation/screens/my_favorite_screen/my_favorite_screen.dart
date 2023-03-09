import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/my_favorite_screen/my_favorite_screen_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/most_popular_product_widget.dart';
import 'package:ghaf_application/presentation/widgets/product_widget.dart';

import '../home_view/home_view_getx_controller.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({Key? key}) : super(key: key);

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  // controller.
  late final MyFavoriteScreenGetXController _myFavoriteScreenGetXController =
      Get.put(MyFavoriteScreenGetXController());
  HomeViewGetXController _homeViewGetXController =
  Get.put<HomeViewGetXController>(HomeViewGetXController());

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
        title: Text('${AppLocalizations.of(context)!.my_favorite}',
            style: TextStyle(color: ColorManager.primaryDark)),
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
                  ? Column(
                      children: [
                        SizedBox(
                          height: AppSize.s110,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              Image.asset(
                                ImageAssets.tt,
                                height: AppSize.s192,
                                width: AppSize.s192,
                              ),
                              Image.asset(
                                ImageAssets.heartFavorite,
                                height: AppSize.s192,
                                width: AppSize.s192,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.add_to_your_favorite,
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: AppSize.s20,
                        ),
                        Text(AppLocalizations.of(context)!.save_the_restaurant,
                            style: TextStyle(
                                color: ColorManager.greyLight, fontSize: 12)),
                        SizedBox(
                          height: AppSize.s110,
                        ),
                        Container(
                          height: AppSize.s50,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  side:  BorderSide(color: ColorManager.primary),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),backgroundColor: MaterialStatePropertyAll(Colors.white)),
                              onPressed: () {},
                              child: Text(
                                  AppLocalizations.of(context)!.find_restaurant,style: TextStyle(color: ColorManager.primary),)),
                        )
                      ],
                    )
                  : GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p8, vertical: AppPadding.p4),
                      itemCount:
                          _myFavoriteScreenGetXController.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                        crossAxisCount: Constants.crossAxisCount,
                        mainAxisExtent: 350,
                        mainAxisSpacing: Constants.mainAxisSpacing,
                      ),
                      itemBuilder: (context, index) {
                        return Builder(builder: (context) {
                          return MostPopularProductWidget(
                              image: _homeViewGetXController
                                  .products[index].productImages![0],
                              name: _homeViewGetXController
                                  .products[index].name!,
                              price: _homeViewGetXController
                                  .products[index].price!,
                              stars: _homeViewGetXController
                                  .products[index].stars!,
                              index: index,
                              idProduct:
                              _homeViewGetXController.products[index].id!,
                              isFavorite: _homeViewGetXController.products[index].isFavorite!,
                          );
                        });
                      },
                    ),
        ),
      ),
    );
  }
}
