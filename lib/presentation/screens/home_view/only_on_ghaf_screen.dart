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

class OnlyOnGhafScreen extends StatefulWidget {
  @override
  State<OnlyOnGhafScreen> createState() => _OnlyOnGhafScreenState();
}

class _OnlyOnGhafScreenState extends State<OnlyOnGhafScreen> {
  //controller
  late final HomeViewGetXController _homeViewGetXController =
      Get.find<HomeViewGetXController>();

  @override
  void initState() {
    // TODO: implement initState
    _homeViewGetXController.getOnlyOnGhaf(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.038,
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Image.asset(
                        SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  AppLocalizations.of(context)!.only_on_ghaf,
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
              builder: (controller) => controller.onlyOnghaf.length == 0
                  ? Center(
                      child: Text(
                          AppLocalizations.of(context)!.no_product_found,
                          style: TextStyle(
                              color: ColorManager.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s18)),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      shrinkWrap: true,
                      itemCount: controller.onlyOnghaf.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Builder(
                          builder: (context) {
                            Get.put<Product>(
                              _homeViewGetXController
                                  .products[index],tag:
                            '${_homeViewGetXController.products[index].id}onlyOnGhaf',);
                            return ProductItemNew(
                               tag: '${_homeViewGetXController.products[index].id}onlyOnGhaf',
                                image: _homeViewGetXController
                                    .onlyOnghaf[index].productImages![0],
                                name:
                                _homeViewGetXController.onlyOnghaf[index].name!,
                                stars: _homeViewGetXController
                                    .onlyOnghaf[index].stars!,
                                price: _homeViewGetXController
                                    .onlyOnghaf[index].price!,
                                index: index,
                                isFavorite: _homeViewGetXController
                                    .onlyOnghaf[index].isFavorite!,
                                idProduct:
                                _homeViewGetXController.onlyOnghaf[index].id!);
                          },
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
