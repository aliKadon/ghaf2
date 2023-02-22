import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';

import '../../../app/utils/app_shared_data.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';


class ProductViewNew extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12),
                        child: Image.asset(
                          IconsAssets.arrow,
                          height:
                          MediaQuery.of(context).size.height *
                              0.03,
                          width: MediaQuery.of(context).size.width *
                              0.03,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.my_cart,
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

                Container(
                  height: MediaQuery.of(context).size.height *0.9,
                  child: Stack(
                    children: [
                      Image.asset(ImageAssets.pizza),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 300,
                        // bottom: -10,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadiusDirectional.circular(50),
                            color: Colors.white,
                          ),
                          height:
                          MediaQuery.of(context).size.height * 1,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.7,
                                        child: Text(
                                          'Lorem Ipsum is simply dummy',
                                          overflow: TextOverflow.clip,

                                          style: getSemiBoldStyle(
                                            color: ColorManager.primaryDark,
                                            fontSize: FontSize.s22,
                                          ),
                                        ),
                                      ),
                                        Text(
                                          '100 ${AppLocalizations.of(context)!.aed}',
                                          style: getSemiBoldStyle(
                                            color: ColorManager.primary,
                                            fontSize: FontSize.s20,
                                          ),
                                        ),

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                          initialRating: 4,
                                          minRating: 1,
                                          itemSize: 20,
                                          updateOnDrag: false,
                                          allowHalfRating: true,
                                          ignoreGestures: true,
                                          itemBuilder: (context, _) =>
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          }),

                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.02,
                                      ),
                                      Text(
                                        '(100 reviews)',
                                        style: getSemiBoldStyle(
                                          color: ColorManager.greyLight,
                                          fontSize: FontSize.s10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.02,
                                  ),
                                  Text(
                                    'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
                                    style: getSemiBoldStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 20,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              height: AppSize.s46,
                              width: AppSize.s110,
                              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Icon(Icons.timer,color: ColorManager.primaryDark),
                                  Text('20 - 40 min')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  topLeft: Radius.circular(50)),
                              color: Colors.white,
                            ),
                            height: MediaQuery.of(context).size.height *
                                0.1,
                            width: 50,
                            child: Row(
                              children: [

                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    // if (AppSharedData.currentUser == null ) {
                                    //   showSheet(context);
                                    // }else {
                                    //   cubit.addOrRemoveToCart(
                                    //       id: widget.id,
                                    //       context: context);
                                    // }

                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10)))),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .add_to_cart,
                                    // 'Login',
                                    style: getSemiBoldStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s18),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}