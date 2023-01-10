import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/screens/offers_view/offers_screen_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/product_widget.dart';

import '../../../app/constants.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class OffersView extends StatefulWidget {
  const OffersView({Key? key}) : super(key: key);

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  // controller.
  late final OffersScreenGetXController _offersScreenGetXController =
      Get.find<OffersScreenGetXController>();

  // dispose.
  @override
  void dispose() {
    Get.delete<OffersScreenGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
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
                  Text(
                    AppLocalizations.of(context)!.offers,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: AppSize.s12,
              ),
              Divider(height: 1, color: ColorManager.greyLight),
              Expanded(
                child: GetBuilder<OffersScreenGetXController>(
                  id: 'isOffersLoading',
                  builder: (controller) => controller.isOffersLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        )
                      : _offersScreenGetXController.offers.isEmpty
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!.no_offer_found,
                              ),
                            )
                          : GridView.builder(
                              padding:
                                  EdgeInsets.symmetric(vertical: AppPadding.p4),
                              shrinkWrap: true,
                              itemCount:
                                  _offersScreenGetXController.offers.length,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Constants.crossAxisCount,
                                mainAxisExtent: Constants.mainAxisExtent,
                                mainAxisSpacing: Constants.mainAxisSpacing,
                              ),
                              itemBuilder: (context, index) {
                                return Builder(
                                  builder: (context) {
                                    Get.put<Product>(
                                      _offersScreenGetXController.offers[index],
                                      tag:
                                          '${_offersScreenGetXController.offers[index].id}offers',
                                    );
                                    return ProductWidget(
                                      tag:
                                          '${_offersScreenGetXController.offers[index].id}offers',
                                    );
                                  },
                                );
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
