import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class OrderWidget2 extends StatelessWidget {
  const OrderWidget2({
    Key? key,
    required String name,
    required String amount,
    required String date,
    required String orderType,
    required String orderStatus,
  })  : _name = name,
        _amount = amount,
        _date = date,
        _orderType = orderType,
        _orderStatus = orderStatus,
        super(key: key);

  final String _name;
  final String _amount;
  final String _date;
  final String _orderType;
  final String _orderStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: AppSize.s344,
      // height: AppSize.s129,
      margin: EdgeInsets.only(
          bottom: AppMargin.m12, left: AppMargin.m16, right: AppMargin.m16),
      padding: EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border.all(width: AppSize.s0_5, color: ColorManager.red),
        boxShadow: [
          BoxShadow(
            color: ColorManager.red,
            blurRadius: AppSize.s2,
            offset: Offset(AppSize.s0, AppSize.s2), // Shadow position
          ),
        ],
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _name,
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s12,
                ),
              ),
              Spacer(),
              Text(
                _amount,
                style: getRegularStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s14,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s6),
          Text(
            _date,
            style: getRegularStyle(
              color: ColorManager.black,
              fontSize: FontSize.s12,
            ),
          ),
          SizedBox(height: AppSize.s12),
          Divider(
            color: ColorManager.grey,
            height: AppSize.s1,
          ),
          SizedBox(height: AppSize.s10),
          Row(
            children: [
              Text(
                'نوع الطلب : ',
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s12,
                ),
              ),
              SizedBox(height: AppSize.s4),
              Text(
                _orderType,
                style: getBoldStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s6),
          Row(
            children: [
              Text(
                'حالة الطلب : ',
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s12,
                ),
              ),
              SizedBox(height: AppSize.s4),
              Text(
                _orderStatus,
                style: getBoldStyle(
                  color: ColorManager.red,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
