import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/helpers.dart';

import '../../app/utils/app_shared_data.dart';
import '../../domain/model/product.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import '../screens/product_view/product_view_new.dart';

class FreeDeliveryProductWidget extends StatefulWidget {
  final String tag;

  FreeDeliveryProductWidget({required this.tag});

  @override
  State<FreeDeliveryProductWidget> createState() => _FreeDeliveryProductWidgetState();
}

class _FreeDeliveryProductWidgetState extends State<FreeDeliveryProductWidget> with Helpers {

  late final Product _product = Get.find<Product>(tag: widget.tag);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductViewNew(idProduct: _product.id!),
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
                      _product.productImages!.length == 0 ? Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(ImageAssets.pizza),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ) : Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(_product.productImages![0]),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
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
                                height: AppSize.s20,
                                width: AppSize.s20,
                                color: ColorManager.red,
                              )
                                  : Image.asset(
                                IconsAssets.heart,
                                height: AppSize.s20,
                                width: AppSize.s20,
                              ),),
                        ),
                      ),
                      PositionedDirectional(
                        bottom: 0,
                        end: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: AppSize.s30,
                            // width: AppSize.s60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delivery_dining,
                                  color: ColorManager.primaryDark,
                                ),
                                SizedBox(width: AppSize.s10),
                                Text(
                                  AppLocalizations.of(context)!.free_delivery,
                                  style: TextStyle(
                                      color: ColorManager.primaryDark,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 14,
                  )
                ],
              ),
              Text('${_product.name}',
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
                  Text('${_product.stars}.0',
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
