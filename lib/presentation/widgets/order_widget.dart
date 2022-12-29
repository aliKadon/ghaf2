import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/domain/model/order.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

class OrderWidget extends StatelessWidget {
  final Order order;

  const OrderWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

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
              order.items!.length,
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
                              order.items![index].name ?? '',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'X${order.items![index].quanity}   ${order.items![index].price} ${order.items![index].isoCurrencySymbol}',
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
                '${order.orderCostForCustomer!.toStringAsFixed(1)} ${order.items![0].isoCurrencySymbol}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (order.canPayLaterValue != 0)
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
                  '${order.canPayLaterValue!.toStringAsFixed(1)} ${order.items![0].isoCurrencySymbol}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (order.totalCostForItems! != order.orderCostForCustomer!) ...[
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
                  '${(order.totalCostForItems! - order.orderCostForCustomer!).toStringAsFixed(1)} ${order.items![0].isoCurrencySymbol}',
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
                Navigator.pushNamed(context, Routes.checkOutRoute);
              },
              child: Text(
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
