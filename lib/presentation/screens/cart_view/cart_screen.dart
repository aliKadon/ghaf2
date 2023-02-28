import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/screens/checkout/checkout_view.dart';
import 'package:ghaf_application/presentation/widgets/cart_widget.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var a = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: a == 2
            ? Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                  SizedBox(
                    height: AppSize.s75,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.welcome_to_the} ',
                            style: TextStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s14),
                          ),
                          Text(
                            AppLocalizations.of(context)!.ghaf_application,
                            style: TextStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s14,fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Text(
                        AppLocalizations.of(context)!.in_order_to_add,
                        style: TextStyle(
                            color: ColorManager.grey, fontSize: FontSize.s14),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s75,
                  ),
                  Image.asset(ImageAssets.emptyCard),
                  SizedBox(
                    height: AppSize.s46,
                  ),
                  Container(
                    height: AppSize.s58,
                    width: double.infinity,
                    padding: EdgeInsets.all(4),
                    child: ElevatedButton(onPressed: () {
                      
                    }, child: Text(AppLocalizations.of(context)!.getting_started)),
                  )
                ],
              )
            : Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return CartWidget(index: index);
                      },
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: ColorManager.greyLight,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'order summary',
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'subtotal',
                              style: TextStyle(
                                  color: ColorManager.greyLight,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                            Spacer(),
                            Text(
                              '100 AED',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'discount',
                              style: TextStyle(
                                  color: ColorManager.greyLight,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                            Spacer(),
                            Text(
                              '20 AED',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: ColorManager.greyLight,
                        ),
                        Row(
                          children: [
                            Text(
                              'total',
                              style: TextStyle(
                                  color: ColorManager.primaryDark,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            Spacer(),
                            Text(
                              '80 AED',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: ColorManager.primaryDark),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: AppSize.s82,
                    padding: EdgeInsets.all(AppSize.s16),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CheckOutView(),
                          ));
                        },
                        child: Text('Place Order')),
                  )
                ],
              ),
      ),
    );
  }
}
