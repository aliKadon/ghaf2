import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/app/utils/helpers.dart';

import '../../domain/model/product.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';
import '../screens/home_view/home_view_getx_controller.dart';
import '../screens/product_view/product_view_new.dart';

class ProductItemNew extends StatefulWidget {
  final String tag;
  final String image;
  final String name;
  final num price;
  final int index;
  final num stars;
  final String idProduct;
  final bool isFavorite;
  bool? isFromCheckOut;
  String? orderId;

  ProductItemNew(
      {required this.image,
      required this.name,
      required this.tag,
      this.isFromCheckOut,
      this.orderId,
      required this.stars,
      required this.price,
      required this.index,
      required this.isFavorite,
      required this.idProduct});

  @override
  State<ProductItemNew> createState() => _ProductItemNewState();
}

class _ProductItemNewState extends State<ProductItemNew> with Helpers {


  var language = SharedPrefController().lang1;


  // dispose.
  @override
  void dispose() {
    Get.delete<Product>(tag: widget.tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: AppSize.s206,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductViewNew(
              idProduct: widget.idProduct,
              isFromChekOut: widget.isFromCheckOut,
              orderId: widget.orderId,
            ),
          ));
        },
        child: GetBuilder<Product>(
          tag: widget.tag,
          builder: (controller) => Padding(
              padding:  EdgeInsets.all(AppSize.s4),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          widget.image == ''
                              ? Container(
                                  height: MediaQuery.of(context).size.height * 0.28,
                            width: MediaQuery.of(context).size.height * 0.28 / 1.71,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012),
                                    image: DecorationImage(
                                      // alignment: Alignment.center,
                                      image: AssetImage(ImageAssets.logo1),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: MediaQuery.of(context).size.height * 0.28,
                                  width: MediaQuery.of(context).size.height * 0.28 / 1.71,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.017),
                                    image: DecorationImage(
                                      // alignment: Alignment.bottomCenter,
                                      image: NetworkImage(widget.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          GetBuilder<Product>(
                            tag: widget.tag,
                            builder: (controller) => InkWell(
                              onTap: () {
                                if (AppSharedData.currentUser == null) {
                                  showSignInSheet(
                                      context: context, role: 'Customer');
                                } else {
                                  controller.toggleIsFavorite(
                                    context: context,
                                    id: controller.id!,
                                  );
                                }
                              },
                              child: Padding(
                                padding:  EdgeInsets.all(MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.017),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.10),
                                      color: Colors.black54),
                                  padding: EdgeInsets.all(MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.010),
                                  child: controller.isFavorite!
                                      ? Image.asset(
                                          IconsAssets.heart1,
                                          height: AppSize.s20,
                                          width: AppSize.s20,
                                          color: ColorManager.red,
                                        )
                                      : Image.asset(
                                          IconsAssets.heart,
                                          height: AppSize.s20,
                                          width: AppSize.s20,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: AppSize.s14,
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  Container(
                    width: AppSizeWidth.s138,
                    child: Text(language == 'en' ? widget.name : controller.nameAr ?? widget.name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primaryDark)),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(

                      right: MediaQuery.of(context).size.width * 0.021,
                      left: MediaQuery.of(context).size.width * 0.021,
                    ),
                    child: Container(
                      width: AppSizeWidth.s123,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                                '${widget.price.toDouble()} ${AppLocalizations.of(context)!.aed}',
                                overflow: TextOverflow.clip,

                                style: TextStyle(
                                    fontSize: FontSize.s10,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primaryDark)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .height *
                                0.00011,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .height *
                                0.00011,
                          ),
                          Text(widget.stars.toString(),
                              style: TextStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorManager.primaryDark)),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
