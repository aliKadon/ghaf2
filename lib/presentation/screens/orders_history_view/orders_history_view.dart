import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class OrdersHistoryView extends StatefulWidget {
  const OrdersHistoryView({Key? key}) : super(key: key);

  @override
  State<OrdersHistoryView> createState() => _OrdersHistoryViewState();
}

class _OrdersHistoryViewState extends State<OrdersHistoryView> {

  @override
  void initState() {
    Provider.of<ProductProvider>(context,listen: false).getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var order = Provider.of<ProductProvider>(context);
    var unpaidCount = order.unPaidCount;
    var paidCount = order.paidCount;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      paidCount = 0;
                      unpaidCount = 0;
                      Navigator.pop(context);
                    } ,
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Orders History',
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
                height: AppSize.s17,
              ),
              Text(
                'Orders Statistics',
                style: getSemiBoldStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s16,
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 90.h,
                ),
                children: [
                  {
                    'status': 'Pending',
                    'count': '0',
                  },
                  {
                    'status': 'Completed',
                    'count': '${paidCount}',
                  },
                  {
                    'status': 'Canceled',
                    'count': '0',
                  },
                  {
                    'status': 'Delivery',
                    'count': '0',
                  },
                  {
                    'status': 'In Progress',
                    'count': '0',
                  },
                  {
                    'status': 'Un Paid',
                    'count': '${unpaidCount}',
                  },
                ]
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          if (e['status'] == 'Un Paid') {
                            Navigator.pushNamed(context, Routes.ordersToPay);
                          }
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      IconsAssets.newOrder,
                                      width: 20.h,
                                      height: 20.h,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      e['status']!,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      e['count']!,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 5.h,
              ),
              // Row(
              //
              //   children: [
              //     Text(
              //       AppLocalizations.of(context)!.my_orders,
              //       style: getSemiBoldStyle(
              //         color: ColorManager.primaryDark,
              //         fontSize: FontSize.s16,
              //       ),
              //     ),
              //     Spacer(),
              //     Text(
              //       AppLocalizations.of(context)!.see_all,
              //       style: getMediumStyle(
              //         color: ColorManager.grey,
              //         fontSize: FontSize.s14,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: AppSize.s10,
              // ),
              // Container(
              //   padding: EdgeInsets.all(AppRadius.r12),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(AppRadius.r8),
              //     border: Border.all(
              //         width: AppSize.s1, color: ColorManager.greyLight),
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           ClipRRect(
              //             borderRadius: BorderRadius.circular(AppRadius.r14),
              //             child: Image.asset(
              //               fit: BoxFit.cover,
              //               ImageAssets.test,
              //               height: AppSize.s86,
              //               width: AppSize.s86,
              //             ),
              //           ),
              //           SizedBox(
              //             width: AppSize.s10,
              //           ),
              //           Column(
              //             children: [
              //               Text(
              //                 'mini flower',
              //                 style: getMediumStyle(
              //                   color: ColorManager.primaryDark,
              //                   fontSize: FontSize.s16,
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: AppSize.s6,
              //               ),
              //               Text(
              //                 '1x black flower',
              //                 style: getMediumStyle(
              //                   color: ColorManager.grey,
              //                   fontSize: FontSize.s14,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Spacer(),
              //           Text(
              //             'Delivered',
              //             style: getMediumStyle(
              //               color: ColorManager.grey,
              //               fontSize: FontSize.s14,
              //             ),
              //           ),
              //         ],
              //       ),
              //       SizedBox(height: AppSize.s35),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Column(
              //             children: [
              //               Container(
              //                 padding: EdgeInsets.symmetric(
              //                     horizontal: AppRadius.r10,
              //                     vertical: AppPadding.p8),
              //                 decoration: BoxDecoration(
              //                   color: ColorManager.primary,
              //                   borderRadius:
              //                       BorderRadius.circular(AppRadius.r8),
              //                 ),
              //                 child: Image.asset(
              //                   IconsAssets.recepel,
              //                   height: AppSize.s28,
              //                   width: AppSize.s22,
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: AppSize.s6,
              //               ),
              //               Text(
              //                 AppLocalizations.of(context)!.recepel,
              //                 style: getRegularStyle(
              //                   color: ColorManager.primaryDark,
              //                   fontSize: FontSize.s14,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Column(
              //             children: [
              //               Container(
              //                 padding: EdgeInsets.symmetric(
              //                     horizontal: AppRadius.r10,
              //                     vertical: AppPadding.p8),
              //                 decoration: BoxDecoration(
              //                   color: ColorManager.primary,
              //                   borderRadius:
              //                       BorderRadius.circular(AppRadius.r8),
              //                 ),
              //                 child: Image.asset(
              //                   IconsAssets.rate,
              //                   height: AppSize.s28,
              //                   width: AppSize.s22,
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: AppSize.s6,
              //               ),
              //               Text(
              //                 AppLocalizations.of(context)!.rate,
              //                 style: getRegularStyle(
              //                   color: ColorManager.primaryDark,
              //                   fontSize: FontSize.s14,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Column(
              //             children: [
              //               Container(
              //                 padding: EdgeInsets.symmetric(
              //                     horizontal: AppRadius.r10,
              //                     vertical: AppPadding.p8),
              //                 decoration: BoxDecoration(
              //                   color: ColorManager.primary,
              //                   borderRadius:
              //                       BorderRadius.circular(AppRadius.r8),
              //                 ),
              //                 child: Image.asset(
              //                   IconsAssets.reOrder,
              //                   height: AppSize.s28,
              //                   width: AppSize.s22,
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: AppSize.s6,
              //               ),
              //               Text(
              //                 AppLocalizations.of(context)!.re_order,
              //                 style: getRegularStyle(
              //                   color: ColorManager.primaryDark,
              //                   fontSize: FontSize.s14,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: AppSize.s18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
