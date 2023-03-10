import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/widgets/free_delivery_product_widget.dart';

import '../../../domain/model/product.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/most_popular_product_widget.dart';
import '../offers_view/offers_screen_getx_controller.dart';
import 'how_it_work_rewards_screen.dart';

class RewardsViewNew extends StatefulWidget {
  @override
  State<RewardsViewNew> createState() => _RewardsViewNewState();
}

class _RewardsViewNewState extends State<RewardsViewNew> {
  late final OffersScreenGetXController _offersScreenGetXController =
      Get.put<OffersScreenGetXController>(OffersScreenGetXController());

  @override
  void initState() {
    _offersScreenGetXController.getOffers(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // allRedeemPoint = 0;
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
                    AppLocalizations.of(context)!.rewards,
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
              SizedBox(
                height: AppSize.s30,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: ColorManager.greyLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(
                      ImageAssets.gift,
                      height: AppSize.s40,
                    ),
                  ),
                  SizedBox(
                    width: AppSize.s20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('355 point',
                              style: TextStyle(
                                  color: ColorManager.primaryDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontSize.s14)),
                          SizedBox(
                            width: AppSize.s82,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HowItWorkRewardsScreen(),
                              ));
                            },
                            child: Text(
                              AppLocalizations.of(context)!.how_it_works,
                              style: TextStyle(
                                  color: ColorManager.primary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize.s16),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.67,
                        child: Text(
                          AppLocalizations.of(context)!.the_more_you_order,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color: ColorManager.greyLight,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.s14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: AppSize.s30,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorManager.greyLight,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(14),
                child: Row(children: [
                  Text(
                    '90 points spent',
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s16,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      AppLocalizations.of(context)!.view_history,
                      style: TextStyle(
                        fontSize: FontSize.s16,
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: AppSize.s30,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.free_delivery_rewards,
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.more,
                    style: TextStyle(
                        color: ColorManager.greyLight,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return FreeDeliveryProductWidget();
                  },
                ),
              ),
              SizedBox(
                height: AppSize.s30,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.offers,
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.more,
                    style: TextStyle(
                        color: ColorManager.greyLight,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16),
                  ),
                ],
              ),
              GetBuilder<OffersScreenGetXController>(
                id: 'isOffersLoading',
                builder: (controller) =>  _offersScreenGetXController.isOffersLoading ? Container() : Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    itemCount: _offersScreenGetXController.offers.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MostPopularProductWidget(
                        image: _offersScreenGetXController
                                    .offers[index].productImages!.length !=
                                0
                            ? _offersScreenGetXController
                                .offers[index].productImages![0]
                            : '',
                        stars: _offersScreenGetXController.offers[index].stars!,
                        price: _offersScreenGetXController.offers[index].price!,
                        name: _offersScreenGetXController.offers[index].name!,
                        idProduct: _offersScreenGetXController.offers[index].id!,
                        isFavorite:
                            _offersScreenGetXController.offers[index].isFavorite!,
                        index: index,
                        controller: _offersScreenGetXController.offers,
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
