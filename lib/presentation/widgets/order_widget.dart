import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

import '../../domain/model/available_delevey_method.dart';

class OrderWidget extends StatelessWidget {
  final OrderAllInformation order;
  final String isOrderToPay;

  OrderWidget(this.order,this.isOrderToPay);

  // OrderWidget(
  //   Key? key,
  //   this.order,
  //   this.isOrderToPay,
  // ) : super(key: key);

  // OrderWidget(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Column(
            children: List.generate(
              1,
              (index) => Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 70.h,
                        width: 70.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderDetails['items']![index]['name'] ?? '',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'X${order.orderDetails['items']![index]['quanity']}   ${order.orderDetails['items']![index]['price']} ${order.orderDetails['items']![index]['isoCurrencySymbol']}',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Row(
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              Spacer(),
              Text(
                '${order.orderDetails['orderCostForCustomer']!.toStringAsFixed(1)} ${order.orderDetails['items']![0]['isoCurrencySymbol']}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (order.orderDetails['canPayLaterValue'] != 0)
            Row(
              children: [
                Text(
                  'You can pay later',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                Spacer(),
                Text(
                  '${order.orderDetails['canPayLaterValue']!.toStringAsFixed(1)} ${order.orderDetails['items']![0]['isoCurrencySymbol']}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (order.orderDetails['totalCostForItems']! !=
              order.orderDetails['orderCostForCustomer']!) ...[
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.info,
                  color: Theme.of(context).primaryColor,
                  size: 15.h,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Dear customer you will get ',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 11.sp,
                  ),
                ),
                Text(
                  '${(order.orderDetails['totalCostForItems']! - order.orderDetails['orderCostForCustomer']!).toStringAsFixed(1)} ${order.orderDetails['items']![0]['isoCurrencySymbol']}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
                Text(
                  ' as discount',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            )
          ],
          SizedBox(
            height: 5.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppMargin.m16,
            ),
            width: double.infinity,
            height: 45.h,
            child: ElevatedButton(
              onPressed: () {
                if (isOrderToPay == 'orderTrack') {
                  Navigator.of(context)
                      .pushNamed(Routes.orderTrackingScreen, arguments: order.orderDetails);
                }else {
                  Navigator.pushNamed(context, Routes.checkOutRoute,
                      arguments: order);
                }

                print("it is here: ${order.orderDetails['id']}");
              },
              child: isOrderToPay == 'orderTrack' ? Text(
                'Track Order',
                style: getSemiBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s18,
                ),
              ) : Text(
                'Checkout',
                style: getSemiBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
