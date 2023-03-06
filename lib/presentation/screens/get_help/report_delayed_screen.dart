import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/checkout/cancelling_order_screen.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ReportDelayedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSize.s6),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                      color: ColorManager.primaryDark,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  AppLocalizations.of(context)!.report_delayed_delivery,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                Spacer(),
              ],
            ),
            Divider(
              thickness: 1,
              color: ColorManager.greyLight,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: AppSize.s110,
                    width: AppSize.s110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(ImageAssets.pizza))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'pizza neew pizza',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: AppSize.s14,
                      ),
                      Text(
                        'ordered on 9 dec 2022',
                        style: TextStyle(
                            color: ColorManager.greyLight,
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize.s14),
                      ),
                      SizedBox(
                        height: AppSize.s14,
                      ),
                      Text(
                        AppLocalizations.of(context)!.review_order,
                        style: TextStyle(
                            color: ColorManager.primaryDark,
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize.s14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s24,
            ),
            Text(
              AppLocalizations.of(context)!.order_Number,
              style: TextStyle(
                  color: ColorManager.primaryDark,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s18),
            ),
            Text(
              '# 1212',
              style: TextStyle(
                  color: ColorManager.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s16),
            ),
            SizedBox(
              height: AppSize.s24,
            ),
            Text(
              AppLocalizations.of(context)!.address,
              style: TextStyle(
                  color: ColorManager.primaryDark,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s18),
            ),
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: AppPadding.p8),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
                border: Border.all(
                    width: AppSize.s1, color: ColorManager.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSize.s14,
                  ),
                  Row(
                    children: [
                      Text(
                        'home',
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      Spacer(),
                      Visibility(
                        visible: false,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.lightGreenAccent,
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(children: [
                    Image.asset(
                      IconsAssets.location,
                      height: AppSize.s15,
                      width: AppSize.s11,
                    ),
                    SizedBox(
                      width: AppSize.s8,
                    ),
                    Text(
                      'home',
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ]),
                  // Row(children: [
                  //   Image.asset(
                  //     IconsAssets.person,
                  //     height: AppSize.s15,
                  //     width: AppSize.s14,
                  //   ),
                  //   SizedBox(
                  //     width: AppSize.s8,
                  //   ),
                  //   Text(
                  //     'zidan zidan',
                  //     style: getRegularStyle(
                  //       color: ColorManager.black,
                  //     ),
                  //   ),
                  // ]),
                  SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(children: [
                    Image.asset(
                      IconsAssets.person,
                      height: AppSize.s18,
                      width: AppSize.s18,
                    ),
                    SizedBox(
                      width: AppSize.s8,
                    ),
                    Text(
                      'zidan zidan',
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(children: [
                    Image.asset(
                      IconsAssets.call,
                      height: AppSize.s18,
                      width: AppSize.s18,
                    ),
                    SizedBox(
                      width: AppSize.s8,
                    ),
                    Text(
                      '55267',
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: AppSize.s22,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s22,
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      // canLaunchUrl('tel://+1234567890'),
                      // await call(
                      //     Telephone: widget.orderId['branch']
                      //         ['telephone']);
                    },
                    child: Container(
                      width: AppSize.s60,
                      height: AppSize.s110,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            IconsAssets.call2,
                            color: Colors.white,
                            height: AppSize.s22,
                            width: AppSize.s22,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Call Shop',
                            style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CancellingOrderScreen(),));
                      // canLaunchUrl('tel://+1234567890'),
                      // await call(
                      //     Telephone: widget.orderId['branch']
                      //         ['telephone']);
                    },
                    child: Container(
                      width: AppSize.s60,
                      height: AppSize.s110,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageAssets.x,
                            color: Colors.white,
                            height: AppSize.s22,
                            width: AppSize.s22,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            AppLocalizations.of(context)!.canceling_order,
                            style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      // canLaunchUrl('tel://+1234567890'),
                      // await call(
                      //     Telephone: widget.orderId['branch']
                      //         ['telephone']);
                    },
                    child: Container(
                      width: AppSize.s60,
                      height: AppSize.s110,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone_callback, color: Colors.white,),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Request a call back',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
