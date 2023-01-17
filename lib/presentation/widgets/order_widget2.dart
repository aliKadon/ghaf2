import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';


import '../../domain/model/unpaid_order.dart';
import '../../providers/product_provider.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class OrderWidget2 extends StatefulWidget {
  final UnpaidOrder order;
  final String isOrderToPay;

  OrderWidget2(this.order, this.isOrderToPay);

  @override
  State<OrderWidget2> createState() => _OrderWidget2State();
}

class _OrderWidget2State extends State<OrderWidget2> {
  // OrderWidget(
  List a = [];

  @override
  void initState() {
    Provider.of<ProductProvider>(context,listen: false).getOrderById(widget.order.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var orderById = Provider.of<ProductProvider>(context,listen: false).orderById;
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
              widget.order.items!.length,
              (index) => Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/product_image.png',
                        fit: BoxFit.cover,
                        height: 70.h,
                        width: 70.h,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.order.items![index]['name'] ?? '',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'X${widget.order.items![index]['quanity']}   ${widget.order.items![index]['price']} ${widget.order.items![index]['isoCurrencySymbol']}',
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
                AppLocalizations.of(context)!.total,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              Spacer(),
              Text(
                '${widget.order.totalCostForItems!.toStringAsFixed(1)} ${widget.order.items![0]['isoCurrencySymbol']}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (widget.order.canPayLaterValue != 0)
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.can_pay_later,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                Spacer(),
                Text(
                  '${widget.order.canPayLaterValue!.toStringAsFixed(1)} ${widget.order.items![0]['isoCurrencySymbol']}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (widget.order.totalCostForItems! != widget.order.orderCostForCustomer!) ...[
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
                  AppLocalizations.of(context)!.dear_customer,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 11.sp,
                  ),
                ),
                Text(
                  '${(widget.order.totalCostForItems! - widget.order.orderCostForCustomer!).toStringAsFixed(1)} ${widget.order.items![0]['isoCurrencySymbol']}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.as_discount,
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
                if (widget.isOrderToPay == 'orderTrack') {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.orderTrackingScreen, arguments: widget.order);
                } else {
                  widget.isOrderToPay == 'orderTrack' ||
                      widget.isOrderToPay == 'In Progress' ||
                      widget.isOrderToPay == 'Delivery' ||
                      widget.isOrderToPay == 'Completed' ||
                      widget.isOrderToPay == 'Pending'
                      ? Navigator.pushReplacementNamed(context, Routes.orderTrackingScreen,
                      arguments: {
                        'orderId': widget.order.id,
                        'order': orderById
                      }):Navigator.pushReplacementNamed(context, Routes.checkOutRoute,
                      arguments: widget.order);
                }

                print("it is here: ${widget.order.id}");
              },
              child: widget.isOrderToPay == 'orderTrack' ||
                      widget.isOrderToPay == 'In Progress' ||
                      widget.isOrderToPay == 'Delivery' ||

                      widget.isOrderToPay == 'Pending'
                  ? Text(
                      AppLocalizations.of(context)!.track_order,
                      style: getSemiBoldStyle(
                        color: ColorManager.white,
                        fontSize: FontSize.s18,
                      ),
                    )
                  :widget.isOrderToPay == 'Completed' ? Text(
                AppLocalizations.of(context)!.review,
                style: getSemiBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s18,
                ),
              ) : Text(
                AppLocalizations.of(context)!.checkout,
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
