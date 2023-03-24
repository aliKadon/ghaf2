import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/categories_view/categories_getx_controller.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class StoreByCategory extends StatefulWidget {
  final String cid;

  StoreByCategory({required this.cid});

  @override
  State<StoreByCategory> createState() => _StoreByCategoryState();
}

class _StoreByCategoryState extends State<StoreByCategory> {
  //controller
  late final CategoriesGetxController _categoriesGetxController =
      Get.put(CategoriesGetxController());

  @override
  void initState() {
    // TODO: implement initState
    _categoriesGetxController.getBranches(cid: widget.cid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.all_stores,
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
            GetBuilder<CategoriesGetxController>(
              builder: (controller) => controller.branches.length == 0
                  ? Center(
                      child: Text(AppLocalizations.of(context)!.no_stores_found,
                          style: TextStyle(
                              fontSize: FontSize.s18,
                              fontWeight: FontWeight.w600,
                              color: ColorManager.primary)),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.branches.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => StoreView(),
                            // ));
                          },
                          child: Column(
                            children: [
                              Container(
                                color: ColorManager.greyLight,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      // _categoriesGetxController.branches[index]
                                      //             .branchLogoImage ==
                                      //         null
                                      //     ? Image.asset(
                                      //         ImageAssets.brIcon,
                                      //         height: 80,
                                      //         width: 80,
                                      //       )
                                      //     : Image.network(
                                      //         _categoriesGetxController
                                      //             .branches[index]
                                      //             .branchLogoImage!,
                                      //         height: 80,
                                      //         width: 80,
                                      //       ),
                                      SizedBox(width: 10),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${_categoriesGetxController.branches[index].storeName} (${_categoriesGetxController.branches[index].branchName})',
                                                style: TextStyle(
                                                    color: ColorManager
                                                        .primaryDark,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.22,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.timer,
                                                    color: ColorManager.primary,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    '12 min',
                                                    style: TextStyle(
                                                        color:
                                                            ColorManager.grey,
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // Text(
                                              //   'Ice cream',
                                              //   style: TextStyle(
                                              //       color: ColorManager.grey,
                                              //       fontSize: 14),
                                              // ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.22,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '${_categoriesGetxController.branches[index].storeStars}.0',
                                                style: TextStyle(
                                                    color: ColorManager
                                                        .primaryDark,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '(${_categoriesGetxController.branches[index].reviewCount}+)',
                                                style: TextStyle(
                                                    color: ColorManager.grey,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          GetBuilder<CategoriesGetxController>(
                                            builder: (controller) => Container(
                                              height: 40,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .branches[index]
                                                    .storeDeliveryCost!
                                                    .length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index1) {
                                                  return Row(
                                                    children: [
                                                      _categoriesGetxController
                                                                  .branches[
                                                                      index]
                                                                  .storeDeliveryCost![
                                                                      index1]
                                                                  .methodImage ==
                                                              null
                                                          ? Image.asset(
                                                              ImageAssets
                                                                  .carDelivery,
                                                              height: 20,
                                                              width: 20,
                                                            )
                                                          : Image.network(
                                                              _categoriesGetxController
                                                                  .branches[
                                                                      index]
                                                                  .storeDeliveryCost![
                                                                      index1]
                                                                  .methodImage!,
                                                              height: 20,
                                                              width: 20,
                                                            ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                          '${_categoriesGetxController.branches[index].storeDeliveryCost![index1].cost} ${AppLocalizations.of(context)!.aed}'),
                                                      SizedBox(
                                                        width: 10,
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Text(
                                              // 'open - closed at 10 am',
                                              '${_categoriesGetxController.branches[index].todayWorkHoursToString}')
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
