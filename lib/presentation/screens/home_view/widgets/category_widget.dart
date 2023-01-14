import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghaf_application/domain/model/category.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;

  const CategoryWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(category.name == 'Restuarants'){
          _customDialogProgress(context);

        }else if(category.name == 'Supermarkets'){
          _customDialogSuperMarkets(context);

        } else {
          Navigator.pushNamed(
            context,
            Routes.products,
            arguments: {
              'id' : category.id,
              'name' : category.name
            },
          );
        }


        print("===========================================");
        print(category.name);


      },
      child: Container(
        width: AppSize.s92,
        padding: EdgeInsetsDirectional.only(
          end: AppSize.s8,
        ),
        child: Column(
          children: [
            Container(
              height: AppSize.s60,
              width: AppSize.s60,
              padding: EdgeInsets.all(AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                border: Border.all(
                    width: AppSize.s0_5, color: ColorManager.greyLight),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.greyLight,
                    blurRadius: AppSize.s4,
                    offset: Offset(AppSize.s0, AppSize.s4), // Shadow position
                  ),
                ],
                borderRadius: BorderRadius.circular(AppRadius.r4),
              ),
              child: Image.network(
                // base64Decode(category.categoryImage ?? ''),
                category.categoryImage!,
                width: AppSize.s60,
                height: AppSize.s60,
                fit: BoxFit.fill,
              ),


              // Image.asset(
              //   IconsAssets.cart,
              //   height: AppSize.s36,
              //   width: AppSize.s36,
              // ),
            ),
            SizedBox(
              height: AppSize.s6,
            ),
            Flexible(
              child: Text(
                category.name ?? '',
                overflow: TextOverflow.ellipsis,
                style: getMediumStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  void _customDialogProgress(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s258,
              width: AppSize.s360,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Restaurants',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
                      ),
                    ),

                    Text('Delicious food near you',style: TextStyle(fontSize: AppSize.s24),),
                    // Text('Your favorites food\ndelivered at your doorstep',style: TextStyle(fontSize: AppSize.s14),),
                    // Text('Order food to be delivered\n\tor schedule delivery time',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('Schedule your food order in advance',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for breakfast ',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('What do you like for dinner ',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for lunch ',style: TextStyle(fontSize: AppSize.s14),),
                    SizedBox(
                      height: AppSize.s10,
                    ),

                    SizedBox(
                      height: AppSize.s20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _customDialogProgress1(context);

                      },
                      child: Container(
                        width: AppSize.s110,
                        height: AppSize.s38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryDark,
                          borderRadius:
                          BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          'Ok',
                          textAlign: TextAlign.center,
                          style:
                          getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }

  void _customDialogProgress1(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s258,
              width: AppSize.s360,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Restaurants',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
                      ),
                    ),

                    // Text('Delicious food near you',style: TextStyle(fontSize: AppSize.s24),),
                    Text('Your favorites food delivered at your doorstep',style: TextStyle(fontSize: AppSize.s20),),
                    // Text('Order food to be delivered\n\tor schedule delivery time',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('Schedule your food order in advance',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for breakfast ',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('What do you like for dinner ',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for lunch ',style: TextStyle(fontSize: AppSize.s14),),
                    SizedBox(
                      height: AppSize.s10,
                    ),

                    SizedBox(
                      height: AppSize.s20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _customDialogProgress2(context);
                      },
                      child: Container(
                        width: AppSize.s110,
                        height: AppSize.s38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryDark,
                          borderRadius:
                          BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          'Ok',
                          textAlign: TextAlign.center,
                          style:
                          getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }
  void _customDialogProgress2(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s258,
              width: AppSize.s360,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Restaurants',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
                      ),
                    ),

                    // Text('Delicious food near you',style: TextStyle(fontSize: AppSize.s24),),
                    // Text('Your favorites food\ndelivered at your doorstep',style: TextStyle(fontSize: AppSize.s14),),
                    Text('Order food to be delivered or schedule delivery time',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('Schedule your food order in advance',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for breakfast ',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('What do you like for dinner ',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for lunch ',style: TextStyle(fontSize: AppSize.s14),),
                    SizedBox(
                      height: AppSize.s10,
                    ),

                    SizedBox(
                      height: AppSize.s20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.products,
                          arguments: {
                            'id' : category.id,
                            'name' : category.name
                          },
                        );
                      },
                      child: Container(
                        width: AppSize.s110,
                        height: AppSize.s38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryDark,
                          borderRadius:
                          BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          'Ok',
                          textAlign: TextAlign.center,
                          style:
                          getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }

  void _customDialogSuperMarkets(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s326,
              width: AppSize.s360,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Supermarkets',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
                      ),
                    ),

                    // Text('Delicious food near you',style: TextStyle(fontSize: AppSize.s24),),
                    // Text('Your favorites food\ndelivered at your doorstep',style: TextStyle(fontSize: AppSize.s14),),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('We deliver grocery at your door step',style: TextStyle(fontSize: AppSize.s18),),
                    ),
                    Text('Order from the best of snack',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('Schedule your food order in advance',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for breakfast ',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('What do you like for dinner ',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for lunch ',style: TextStyle(fontSize: AppSize.s14),),
                    SizedBox(
                      height: AppSize.s10,
                    ),

                    SizedBox(
                      height: AppSize.s20,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.products,
                          arguments: {
                            'id' : category.id,
                            'name' : category.name
                          },
                        );
                      },

                      child: Container(
                        width: AppSize.s110,
                        height: AppSize.s38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryDark,
                          borderRadius:
                          BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          'Ok',
                          textAlign: TextAlign.center,
                          style:
                          getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }
}
