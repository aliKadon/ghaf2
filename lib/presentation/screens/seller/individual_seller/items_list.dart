import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/presentation/screens/seller/controller/create_link_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/item_widget_for_individual_seller.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';

class ItemsList extends StatefulWidget {
  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  //controller
  late final CreateLinkGetxController _createLinkGetxController =
      Get.find<CreateLinkGetxController>();

  @override
  void initState() {
    _createLinkGetxController.getIndividualProducts(
        context: context, isNotDetailed: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: AppSize.s33,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _createLinkGetxController.productId = [];
                    _createLinkGetxController.productCount = [];
                    print('==================productId');
                    print(_createLinkGetxController.productId);
                    print('==================productCount');
                    print(_createLinkGetxController.productCount);
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
                  AppLocalizations.of(context)!.items_list,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s12,
          ),
          Divider(height: 1, color: ColorManager.greyLight),
          SizedBox(
            height: AppSize.s12,
          ),
          GetBuilder<CreateLinkGetxController>(
            builder: (controller) => Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.individualProducts.length,
                itemBuilder: (context, index) {
                  return ItemWidgetForIndividualSeller(
                    index: index,
                    isoCurrencySymbol: controller
                        .individualProducts[index].isoCurrencySymbol!,
                    price: controller.individualProducts[index].price!,
                    name: controller.individualProducts[index].name!,
                    idProduct: controller.individualProducts[index].id!,
                    image: controller.individualProducts[index]
                                .ghafImageIndividual ==
                            null
                        ? ''
                        : controller.individualProducts[index]
                            .ghafImageIndividual![0].data!,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: AppSize.s16),
          Row(
            children: [
              Spacer(),
              Container(
                height: AppSize.s46,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStatePropertyAll(RoundedRectangleBorder(
                                side: BorderSide(
                                  color: ColorManager.primaryDark,
                                ),
                                borderRadius: BorderRadius.circular(12))),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.add_item,
                      style: TextStyle(color: ColorManager.primaryDark),
                    )),
              ),
              Spacer(),
              Container(
                height: AppSize.s46,
                child: ElevatedButton(
                    onPressed: () {
                      _createLinkGetxController.createLink(
                          withDetails: true,
                          context: context,
                          productId: '',
                          amount: 0);
                      // _createLinkGetxController.createLink(
                      //     withDetails: true,
                      //     context: context,
                      //     productId: _createLinkGetxController.productId[0],
                      //     amount: _createLinkGetxController.productCount[0]);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.confirm,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Spacer()
            ],
          )
        ],
      ),
    );
  }
}
