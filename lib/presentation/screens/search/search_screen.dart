import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../home_view/home_view_getx_controller.dart';

class SearchScreen extends StatelessWidget {
  // controller.
  HomeViewGetXController _homeViewGetXController =
      Get.put<HomeViewGetXController>(HomeViewGetXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.s22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      textAlign: TextAlign.start,
                      style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s14,
                      ),
                      onChanged: _homeViewGetXController.onSearch,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppPadding.p12),
                          child: Image.asset(
                            IconsAssets.search,
                            width: AppSize.s16,
                            height: AppSize.s16,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p16,
                            vertical: AppPadding.p16),
                        hintText: AppLocalizations.of(context)!.search_flower,
                        hintStyle: getMediumStyle(
                          color: ColorManager.hintTextFiled,
                        ),
                        enabledBorder: buildOutlineInputBorder(
                          color: ColorManager.grey,
                        ),
                        focusedBorder: buildOutlineInputBorder(
                          color: ColorManager.grey,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  // Spacer(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                AppLocalizations.of(context)!.recent_search,
                style: getMediumStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s18,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.17,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // childAspectRatio: 0.4,
                      mainAxisExtent: 40,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                    ),
                    physics: BouncingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorManager.greyLight)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.av_timer_rounded,
                              color: ColorManager.greyLight,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Flexible(
                              child: Text(
                                'Food',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Divider(color: ColorManager.greyLight,thickness: 4),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                AppLocalizations.of(context)!.popular_search,
                style: getMediumStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s18,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.17,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // childAspectRatio: 0.4,
                      mainAxisExtent: 40,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                    ),
                    physics: BouncingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorManager.greyLight)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.stacked_line_chart,
                              color: ColorManager.greyLight,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Flexible(
                              child: Text(
                                'Cake',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Divider(color: ColorManager.greyLight,thickness: 4),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.r8),
      borderSide: BorderSide(
        width: AppSize.s1,
        color: color,
      ),
    );
  }
}
