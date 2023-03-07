import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ghaf_application/domain/model/product.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/screens/product_view/product_view_new.dart';
import 'package:ghaf_application/presentation/screens/store_view/onsale_view.dart';
import 'package:ghaf_application/presentation/widgets/most_popular_product_widget.dart';
import 'package:ghaf_application/presentation/widgets/shortcuts_widget.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';

class StoreView extends StatefulWidget {


  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {

  @override
  void initState() {
    // Provider.of<ProductProvider>(context,listen: false).getProducts();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     GestureDetector(
            //       onTap: () => Navigator.pop(context),
            //       child: Image.asset(
            //         IconsAssets.arrow,
            //         height: AppSize.s18,
            //         width: AppSize.s10,
            //       ),
            //     ),
            //     Spacer(),
            //     Text(
            //       AppLocalizations.of(context)!.share_your_opinion,
            //       style: getSemiBoldStyle(
            //         color: ColorManager.primaryDark,
            //         fontSize: FontSize.s18,
            //       ),
            //     ),
            //     Spacer(),
            //   ],
            // ),
            // SizedBox(
            //   height: AppSize.s12,
            // ),
            // Divider(height: 1, color: ColorManager.greyLight),
            // SizedBox(
            //   height: AppSize.s12,
            // ),
            Container(
              height: MediaQuery.of(context).size.height * 0.22,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(180),
                          bottomRight: Radius.circular(180),
                        ),
                      ),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImageAssets.imageStoreView),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    bottom: AppSize.s92,
                    start: 0,
                    end: 0,
                    child: Row(
                      children: [
                        SizedBox(
                          width: AppSize.s50,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            IconsAssets.arrow,
                            height: AppSize.s18,
                            width: AppSize.s10,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: AppSize.s92,
                        ),
                        RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
                          itemSize: 20,
                          updateOnDrag: true,
                          allowHalfRating: true,
                          ignoreGestures: false,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                            // setState(() {
                            //   star = rating;
                            // });
                          },
                        ),
                        SizedBox(
                          width: AppSize.s14,
                        ),
                        Text('25', style: TextStyle(color: Colors.white)),
                        Spacer(),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 0,
                    start: 0,
                    end: 0,
                    child: Image.asset(
                      ImageAssets.coffeeHouse,
                      height: AppSize.s84,
                      width: AppSize.s84,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Cafeteria House',
              style: TextStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s20,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'coffee,sweets',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Container(
              height: AppSize.s84,
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        ImageAssets.carDelivery,
                        height: AppSize.s17,
                        width: AppSize.s17,
                      );
                    },
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: ColorManager.grey,
                  ),
                  Column(
                    children: [
                      SizedBox(height: AppSize.s10),
                      Text(
                        AppLocalizations.of(context)!.open_close_time,
                        style: TextStyle(color: ColorManager.primary),
                      ),
                      SizedBox(height: AppSize.s10),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: ColorManager.primary,
                          ),
                          Text('today 10 :AM-12 AM'),
                        ],
                      ),
                    ],
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: ColorManager.grey,
                  ),
                  Column(
                    children: [
                      SizedBox(height: AppSize.s10),
                      Text(
                        AppLocalizations.of(context)!.minimum_order,
                        style: TextStyle(color: ColorManager.primary),
                      ),
                      SizedBox(height: AppSize.s10),
                      Text('AED 30 '),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: ColorManager.greyLight,
                thickness: 1,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: ShortcutsWidget(
                      imageUrl: ImageAssets.trending,
                      text: 'Trending',
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Divider(
                color: ColorManager.greyLight,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.recommended_for_you,
                    style: TextStyle(
                        fontSize: FontSize.s20,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.primaryDark),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return MostPopularProductWidget(image: '',stars: 0,price: 0,name: '',idProduct: '',);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Divider(
                color: ColorManager.greyLight,
                thickness: 1,
              ),
            ),
            Container(
                height: AppSize.s50,
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemExtent: 100,
                  itemBuilder: (context, index) {
                    return Text(
                      'Cold Coffee',
                      style: TextStyle(
                          color: ColorManager.primaryDark,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.s14),
                    );
                  },
                )),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return MostPopularProductWidget(image: '',stars: 0,price: 0,name: '',idProduct: '',);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
