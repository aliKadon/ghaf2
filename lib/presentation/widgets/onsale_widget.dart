import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/screens/offers_view/offers_screen_getx_controller.dart';

import '../../app/utils/app_shared_data.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import '../screens/product_view/product_view_new.dart';

class OnsaleWidget extends StatefulWidget {
  String tag;
  num minOrder;
  String discount;

  OnsaleWidget({required this.tag,required this.minOrder,required this.discount});

  @override
  State<OnsaleWidget> createState() => _OnsaleWidgetState();
}

class _OnsaleWidgetState extends State<OnsaleWidget> with Helpers {
  //controller
  late final Product _product = Get.find<Product>(tag: widget.tag);
  final OffersScreenGetXController _offersScreenGetXController =
  Get.find<OffersScreenGetXController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('====================click1');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductViewNew(idProduct: _product.id!,minOrder: widget.minOrder),
        ));
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      _product.productImages!.length == 0
                          ? Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.29,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: AssetImage(ImageAssets.pizza),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GridTile(
                            footer: GridTileBar(

                                backgroundColor: ColorManager.primaryDark,
                                title:
                                Text('Save ${((_product.price!) * (num.parse(widget.discount) / 100)).toInt()} AED')),
                            child: Container(),
                          ),
                        ),
                      )
                          : Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.29,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image:
                            NetworkImage(_product.productImages![0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GridTile(
                            footer: GridTileBar(
                                backgroundColor: ColorManager.primaryDark,
                                title:
                                Center(child: Text('Save 12 AED'))),
                            child: Container(),
                          ),
                        ),
                      ),
                      GetBuilder<Product>(
                        tag: widget.tag,
                        builder: (controller) =>
                            InkWell(
                              onTap: () {
                                if (AppSharedData.currentUser == null) {
                                  showSignInSheet(
                                      context: context, role: 'Customer');
                                } else {
                                  _product.toggleIsFavorite(
                                    context: context,
                                    id: _product.id!,
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.black54),
                                  padding: EdgeInsets.all(8),
                                  child: _product.isFavorite!
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
                    width: 14,
                  )
                ],
              ),
              Text(_product.name!,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primaryDark)),
              Row(
                children: [
                  Text('${_product.price} ${_product.isoCurrencySymbol}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primaryDark)),
                  SizedBox(
                    width: 28,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('${_product.stars}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.primaryDark)),
                ],
              ),
            ],
          )),
    );
  }
}
