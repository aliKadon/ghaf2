import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/product_view/product_view_new.dart';

import '../../app/utils/app_shared_data.dart';
import '../../domain/model/product.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../screens/home_view/home_view_getx_controller.dart';

class MostPopularProductWidget extends StatefulWidget {
  final String image;
  final String name;
  final num price;
  final num stars;
  final int index;
  final String idProduct;
  final bool isFavorite;
  final List controller;

  MostPopularProductWidget(
      {required this.image,
      required this.name,
      required this.stars,
      required this.index,
      required this.price,
      required this.isFavorite,
      required this.controller,
      required this.idProduct});

  @override
  State<MostPopularProductWidget> createState() =>
      _MostPopularProductWidgetState();
}

class _MostPopularProductWidgetState extends State<MostPopularProductWidget> with Helpers {
  late final Product _product = Get.find<Product>();

  HomeViewGetXController _homeViewGetXController =
      Get.find<HomeViewGetXController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductViewNew(
            idProduct: widget.idProduct,
          ),
        ));
      },
      child: Padding(
          padding: EdgeInsets.all(AppSize.s8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      widget.image == '' ? Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s15),
                          image: DecorationImage(
                            image: AssetImage(ImageAssets.pizza),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ) : Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s15),
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.cover,
                          ),

                        ),
                      ),
                      GetBuilder<Product>(
                        id: 'isFavorite',
                        builder: (controller) => InkWell(
                          onTap: () {
                            if(AppSharedData.currentUser == null) {
                              showSignInSheet(role: 'Customer',context: context);
                            }else {
                              _product.toggleIsFavorite(
                                context: context, id: widget.idProduct,);
                            }

                          },
                          child: Padding(
                            padding: EdgeInsets.all(AppSize.s8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppRadius.r100),
                                  color: Colors.black54),
                              padding: EdgeInsets.all(AppSize.s8),
                              child: widget.controller[widget.index].isFavorite ?? false
                                  ? Image.asset(
                                      IconsAssets.heart1,
                                      height: AppSize.s24,
                                      width: AppSize.s24,
                                      color: ColorManager.red,
                                    )
                                  : Image.asset(
                                      IconsAssets.heart,
                                      height: AppSize.s24,
                                      width: AppSize.s24,
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
              Text(widget.name,
                  style: TextStyle(
                      fontSize: FontSize.s18,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primaryDark)),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text(
                        '${widget.price.toDouble()} ${AppLocalizations.of(context)!.aed}',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primaryDark)),
                  ),
                  SizedBox(
                    width: AppSize.s28,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(widget.stars.toString(),
                      style: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.primaryDark)),
                ],
              ),
            ],
          )),
    );
  }
}
