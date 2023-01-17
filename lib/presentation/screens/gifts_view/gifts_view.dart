import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/screens/gifts_view/gifts_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/product_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class GiftsView extends StatefulWidget {
  const GiftsView({Key? key}) : super(key: key);

  @override
  State<GiftsView> createState() => _GiftsViewState();
}

class _GiftsViewState extends State<GiftsView> {
  // controller.
  late final GiftsViewGetXController _giftsViewGetXController =
      Get.find<GiftsViewGetXController>();

  // dispose.
  @override
  void dispose() {
    Get.delete<GiftsViewGetXController>();
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
                    AppLocalizations.of(context)!.gifts,
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
                child: GetBuilder<GiftsViewGetXController>(
                  id: 'isGiftsLoading',
                  builder: (controller) => controller.isGiftsLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        )
                      : _giftsViewGetXController.gifts.isEmpty
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!.no_gift_found,
                              ),
                            )
                          : GridView.builder(
                              padding:
                                  EdgeInsets.symmetric(vertical: AppPadding.p4),
                              shrinkWrap: true,
                              itemCount: _giftsViewGetXController.gifts.length,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Constants.crossAxisCount,
                                mainAxisExtent: Constants.mainAxisExtent,
                                mainAxisSpacing: Constants.mainAxisSpacing,
                              ),
                              itemBuilder: (context, index) => Builder(
                                builder: (context) {
                                  Get.put<Product>(
                                    _giftsViewGetXController
                                        .gifts[index].products!,
                                    tag:
                                        '${_giftsViewGetXController.gifts[index].products!.id}gift',
                                  );
                                  return ProductWidget(
                                    tag:
                                        '${_giftsViewGetXController.gifts[index].products!.id}gift',
                                    minProductCountForGift:
                                        _giftsViewGetXController
                                            .gifts[index].minProductCount,
                                    giftCount: _giftsViewGetXController
                                        .gifts[index].giftCount,
                                  );
                                },
                              ),
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
