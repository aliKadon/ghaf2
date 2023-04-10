import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/screens/home_view/home_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/store_view/store_view.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/store_widget.dart';
import 'categories_getx_controller.dart';

class CategoriesViewNew extends StatefulWidget {
  @override
  State<CategoriesViewNew> createState() => _CategoriesViewNewState();
}

class _CategoriesViewNewState extends State<CategoriesViewNew> with Helpers {
  //controller
  late final HomeViewGetXController _homeViewGetXController =
      Get.put(HomeViewGetXController());
  late final CategoriesGetxController _categoriesGetxController =
      Get.put(CategoriesGetxController());

  var selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    _homeViewGetXController.getCategories();
    _categoriesGetxController.getBranches(
        cid: SharedPrefController().firstStoreName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.categories_by_store,
                style: getSemiBoldStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s18,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSize.s12,
          ),
          Divider(height: 1, color: ColorManager.greyLight),
          SizedBox(
            height: AppSize.s10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.03,
            child: GetBuilder<HomeViewGetXController>(
              builder: (controller) => ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: selected == index
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = index;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                    _homeViewGetXController
                                        .categories[index].name!,
                                    style: TextStyle(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: FontSize.s14)),
                                SizedBox(
                                  width: AppSize.s30,
                                )
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              _categoriesGetxController.getBranches(
                                  cid: _homeViewGetXController
                                      .categories[index].id);
                              setState(() {
                                selected = index;
                              });
                            },
                            child: Row(
                              children: [
                                Text(_homeViewGetXController
                                    .categories[index].name!),
                                SizedBox(
                                  width: AppSize.s30,
                                )
                              ],
                            ),
                          ),
                  );
                },
              ),
            ),
          ),
          Divider(thickness: 1, color: ColorManager.greyLight),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showSortBySheet(
                        context: context,
                        cid: _homeViewGetXController.categories[selected].id!,
                        categoriesGetxController: _categoriesGetxController);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorManager.grey,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Image.asset(ImageAssets.sorted, height: AppSize.s20),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.sort_by,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: ColorManager.primaryDark),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: AppSize.s6,
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.68,
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     scrollDirection: Axis.horizontal,
                //     physics: BouncingScrollPhysics(),
                //     itemCount: 5,
                //     itemBuilder: (context, index) {
                //       return Row(
                //         children: [
                //           Container(
                //             padding: EdgeInsets.all(8),
                //             decoration: BoxDecoration(
                //                 border: Border.all(
                //                   color: ColorManager.grey,
                //                 ),
                //                 borderRadius: BorderRadius.circular(15)),
                //             child: Text('Delivery type'),
                //           ),
                //           SizedBox(
                //             width: AppSize.s6,
                //           )
                //         ],
                //       );
                //     },
                //   ),
                // )
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.store,
                  style: TextStyle(
                      color: ColorManager.black,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.s20),
                ),
              ),
            ],
          ),
          GetBuilder<CategoriesGetxController>(
            builder: (controller) => _categoriesGetxController.branches.length ==
                    0
                ? Center(
                    child: Text(AppLocalizations.of(context)!.no_stores_found,
                        style: TextStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeight.w600)),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.57,
                    decoration: BoxDecoration(color: ColorManager.greyLight),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.branches.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => StoreView(
                              //       branchId: _categoriesGetxController
                              //           .branches[index].id!),
                              // ));
                              if (controller.branches[index].isOpen!) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StoreView(
                                      branchId: controller
                                          .branches[index].id!),
                                ));
                              } else if (controller.branches[index].isOpen ==
                                  false) {
                                showStoreClosedPreOrderSheet(context: context,bid: controller.branches[index].id!,homeViewGetXController: _homeViewGetXController);
                              }
                            },
                            child: StoreWidget(
                              storeName:
                                  controller.branches[index].branchName ?? '',
                              storeImageUrl:
                                  controller.branches[index].branchLogoImage!,
                              storeStars: controller.branches[index].storeStars!,
                              imageDeliveryUrl:
                                  controller.branches[index].storeDeliveryCost!,
                              isOpen: controller.branches[index].isOpen!,
                              workTime: controller
                                  .branches[index].todayWorkHoursToString!,
                              reviewCount:
                                  controller.branches[index].reviewCount!,
                            ));
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
