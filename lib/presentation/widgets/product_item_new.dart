import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/app/utils/helpers.dart';

import '../../domain/model/product.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
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
  late final Product _product = Get.find<Product>(tag: widget.tag);
  HomeViewGetXController _homeViewGetXController =
      Get.find<HomeViewGetXController>();

  @override
  void initState() {
    // TODO: implement initState
    print('=====================isFromCheckOut');
    print(widget.isFromCheckOut);
    print(widget.orderId);
    super.initState();
  }

  // dispose.
  @override
  void dispose() {
    Get.delete<Product>(tag: widget.tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductViewNew(
            idProduct: widget.idProduct,
            isFromChekOut: widget.isFromCheckOut,
            orderId: widget.orderId,
          ),
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
                      widget.image == ''
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(ImageAssets.logo1),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(widget.image),
                                  fit: BoxFit.scaleDown,
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
                              _product.toggleIsFavorite(
                                context: context,
                                id: widget.idProduct,
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
              Text(widget.name,
                  style: TextStyle(
                      fontSize: 18,
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primaryDark)),
                  ),
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
                  Text(widget.stars.toString(),
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
