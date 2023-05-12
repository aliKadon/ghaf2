import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/home_view/home_view.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/presentation/screens/my_favorite_screen/my_favorite_screen_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/search/search_screen.dart';

import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../widgets/product_item_new.dart';
import '../home_view/home_view_getx_controller.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({Key? key}) : super(key: key);

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> with Helpers{
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
    // Get.delete<MyFavoriteScreenGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainView(),
        ));
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('${AppLocalizations.of(context)!.my_favorite}',
        //       style: TextStyle(color: ColorManager.primaryDark)),
        //   iconTheme: IconThemeData(color: Colors.black),
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppSize.s6),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MainView(),
                        ));
                        // Navigator.of(context).pop();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.038,
                        width: MediaQuery.of(context).size.width * 0.08,
                        child: Image.asset(
                          IconsAssets.arrow,
                          height: AppSize.s18,
                          width: AppSize.s10,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.my_favorite,
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
              Container(
                padding: EdgeInsets.all(16.h),
                child: GetBuilder<MyFavoriteScreenGetXController>(
                  builder: (controller) => controller.isMyFavoriteLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        )
                      : controller.products.isEmpty
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
                                  AppLocalizations.of(context)!
                                      .add_to_your_favorite,
                                  style: TextStyle(
                                      color: ColorManager.primaryDark,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  height: AppSize.s20,
                                ),
                                Text(
                                    AppLocalizations.of(context)!
                                        .save_the_restaurant,
                                    style: TextStyle(
                                        color: ColorManager.greyLight,
                                        fontSize: 12)),
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
                                              side: BorderSide(
                                                  color: ColorManager.primary),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.white)),
                                      onPressed: () {
                                        if(AppSharedData.currentUser == null) {
                                          showSignInSheet(context: context, role: Constants.roleRegisterCustomer);
                                        }else {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeView(),));
                                        }
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .find_restaurant,
                                        style: TextStyle(
                                            color: ColorManager.primary),
                                      )),
                                )
                              ],
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppPadding.p8,
                                  vertical: AppPadding.p4),
                              itemCount: controller.products.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: AppSize.s300,
                                crossAxisSpacing: AppSize.s16,

                                // mainAxisSpacing: Constants.mainAxisSpacing,
                              ),
                              itemBuilder: (context, index) {
                                return Builder(builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Builder(
                                      builder: (context) {
                                        Get.put<Product>(
                                          controller.products[index],
                                          tag:
                                              '${controller.products[index].id}',
                                        );
                                        return ProductItemNew(
                                            tag:
                                                '${controller.products[index].id}',
                                            image: controller
                                                        .products[index]
                                                        .productImages
                                                        ?.length ==
                                                    0
                                                ? ''
                                                : controller.products[index]
                                                        .productImages?[0] ??
                                                    '',
                                            name: controller
                                                .products[index].name!,
                                            stars: controller
                                                .products[index].stars!,
                                            price: controller
                                                .products[index].price!,
                                            idProduct:
                                                controller.products[index].id!,
                                            isFavorite: controller
                                                .products[index].isFavorite!,
                                            index: index);
                                      },
                                    ),
                                  );
                                });
                              },
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
