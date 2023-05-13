import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/offers/widgets/offers_widget.dart';
import 'package:ghaf_application/presentation/screens/offers_view/offers_screen_getx_controller.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class OffersScreenNew extends StatefulWidget {
  String? bid;

  OffersScreenNew({this.bid});

  @override
  State<OffersScreenNew> createState() => _OffersScreenNewState();
}

class _OffersScreenNewState extends State<OffersScreenNew> {
  late final OffersScreenGetXController _offersScreenGetXController =
      Get.put<OffersScreenGetXController>(OffersScreenGetXController());

  @override
  void initState() {
    _offersScreenGetXController.getOffers(
        context: context, bid: widget.bid ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OffersScreenGetXController>(
        builder: (controller) => controller.isOffersLoading
            ? Center(
                child: Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              )
            : SingleChildScrollView(
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
                              height:
                                  MediaQuery.of(context).size.height * 0.038,
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
                          AppLocalizations.of(context)!.offers,
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
                    controller.offers.length == 0
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: Center(
                              child: Text(
                                  AppLocalizations.of(context)!.no_offer_found,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: FontSize.s16,
                                      color: ColorManager.primary)),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.84,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  _offersScreenGetXController.offers.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    OffersWidget(
                                        idProduct: _offersScreenGetXController
                                            .offers[index].id!,
                                        branchName: _offersScreenGetXController
                                            .offers[index].branch!.branchName!,
                                        productImages:
                                            _offersScreenGetXController
                                                        .offers[index]
                                                        .productImages!
                                                        .length !=
                                                    0
                                                ? _offersScreenGetXController
                                                    .offers[index]
                                                    .productImages![0]
                                                : '',
                                        discountDescription:
                                            _offersScreenGetXController
                                                    .offers[index]
                                                    .discountDescription ??
                                                ''),
                                    Padding(
                                      padding: EdgeInsets.all(AppSize.s14),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                  ],
                ),
              ),
      ),
    );
  }
}
