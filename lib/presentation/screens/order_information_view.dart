import 'package:flutter/material.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderInformationView extends StatefulWidget {
  const OrderInformationView({Key? key}) : super(key: key);

  @override
  State<OrderInformationView> createState() => _OrderInformationViewState();
}

class _OrderInformationViewState extends State<OrderInformationView> {
  late TextEditingController _orderDetailsTextController;
  @override
  void initState() {
    super.initState();
    _orderDetailsTextController = TextEditingController();
  }
  @override
  void dispose() {
    _orderDetailsTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()=>Navigator.pop(context),
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.order_information,
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
                  height: AppSize.s65,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageAssets.orderInformation,
                    height: AppSize.s161,
                    width: AppSize.s161,
                  ),
                ),
                SizedBox(
                  height: AppSize.s18,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    AppLocalizations.of(context)!.your_order_has_been_received,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s20,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      IconsAssets.selected,
                      height: AppSize.s32,
                      width: AppSize.s32,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p6),
                        width: AppSize.s52,
                        child: Divider(color: ColorManager.grey,height: AppSize.s2,)),
                    Container(
                      padding: EdgeInsets.all( AppPadding.p6),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(AppRadius.r39),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.grey,
                            blurRadius: AppSize.s2,
                            offset: Offset(AppSize.s0, AppSize.s2), // Shadow position
                          ),
                        ],
                      ),
                      child: Image.asset(
                        IconsAssets.hotel,
                        height: AppSize.s21,
                        width: AppSize.s23,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: AppPadding.p6),
                        width: AppSize.s52,
                        child: Divider(color: ColorManager.grey,height: AppSize.s2,)),

                    Container(
                      padding: EdgeInsets.all( AppPadding.p6),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(AppRadius.r39),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.grey,
                            blurRadius: AppSize.s2,
                            offset: Offset(AppSize.s0, AppSize.s2), // Shadow position
                          ),
                        ],
                      ),
                      child: Image.asset(
                        IconsAssets.motorcycleDelivery,
                        height: AppSize.s21,
                        width: AppSize.s23,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: AppPadding.p6),
                        width: AppSize.s52,
                        child: Divider(color: ColorManager.grey,height: AppSize.s2,)),
                    Container(
                      padding: EdgeInsets.all( AppPadding.p6),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(AppRadius.r39),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.grey,
                            blurRadius: AppSize.s2,
                            offset: Offset(AppSize.s0, AppSize.s2), // Shadow position
                          ),
                        ],
                      ),
                      child: Image.asset(
                        IconsAssets.bag1,
                        height: AppSize.s21,
                        width: AppSize.s23,
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p22),
                  child: Text(
                    textAlign: TextAlign.start,
                   'Hello Zidan, your order will be delivered from \nthe store (address) to your address',
                    style: getRegularStyle(
                      color: ColorManager.grey,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),

                Text(
                  AppLocalizations.of(context)!.order_summary,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(height: AppSize.s12,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppRadius.r8),  border:
                  Border.all(width: AppSize.s1, color: ColorManager.grey),),
                  child: Column(
                    children: [
                      SizedBox(height: AppSize.s14,),
                      Row(children: [
                        Text(
                          AppLocalizations.of(context)!.subtotal,
                          style: getRegularStyle(
                            color: ColorManager.grey,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '100 AED',
                          style: getRegularStyle(
                            color: ColorManager.primaryDark,
                          ),
                        ),
                      ]),
                      SizedBox(height: AppSize.s10,),
                      Row(children: [
                        Text(
                          AppLocalizations.of(context)!.discount,
                          style: getRegularStyle(
                            color: ColorManager.grey,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '20 AED',
                          style: getRegularStyle(
                            color: ColorManager.primaryDark,
                          ),
                        ),
                      ]),
                      Divider(height: 1,color: ColorManager.grey),
                      SizedBox(height: AppSize.s10,),
                      Row(children: [
                        Text(
                          AppLocalizations.of(context)!.total,
                          style: getSemiBoldStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s16,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '200 AED',
                          style: getSemiBoldStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s16,

                          ),
                        ),
                      ]),
                      SizedBox(height: AppSize.s10,),
                    ],
                  ),
                ),
                SizedBox(height: AppSize.s20,),
                Text(
                  AppLocalizations.of(context)!.address,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(height: AppSize.s12,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppRadius.r8),  border:
                  Border.all(width: AppSize.s1, color: ColorManager.grey),),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSize.s14,),
                      Text(
                        AppLocalizations.of(context)!.home,
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      SizedBox(height: AppSize.s10,),
                      Row(children: [
                        Image.asset(
                          IconsAssets.location1,
                          height: AppSize.s15,
                          width: AppSize.s11,
                        ),
                        SizedBox(width: AppSize.s8,),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur.',
                          style: getRegularStyle(
                            color: ColorManager.black,
                          ),
                        ),
                      ]),
                      SizedBox(height: AppSize.s10,),
                      Row(children: [
                        Image.asset(
                          IconsAssets.person,
                          height: AppSize.s15,
                          width: AppSize.s14,
                        ),
                        SizedBox(width: AppSize.s8,),
                        Text(
                          'zidan zidan',
                          style: getRegularStyle(
                            color: ColorManager.black,
                          ),
                        ),
                      ]),
                      SizedBox(height: AppSize.s10,),
                      Row(children: [
                        Image.asset(
                          IconsAssets.call,
                          height: AppSize.s18,
                          width: AppSize.s18,
                        ),
                        SizedBox(width: AppSize.s8,),
                        Text(
                          '123456789',
                          style: getRegularStyle(
                            color: ColorManager.black,
                          ),
                        ),
                      ]),
                      SizedBox(height: AppSize.s10,),
                    ],
                  ),
                ),
                SizedBox(height: AppSize.s12,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppRadius.r8),  border:
                  Border.all(width: AppSize.s1, color: ColorManager.grey),),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSize.s10,),
                      Row(children: [
                        Image.asset(
                          IconsAssets.motorcycleDelivery,
                          height: AppSize.s28,
                          width: AppSize.s28,
                        ),
                        SizedBox(width: AppSize.s8,),
                        Text(
                          'It takes 11 minutes',
                          style: getRegularStyle(
                            color: ColorManager.black,
                          ),
                        ),
                      ]),
                      SizedBox(height: AppSize.s10,),

                    ],
                  ),
                ),
                SizedBox(height: AppSize.s12,),
                Text(
                  AppLocalizations.of(context)!.order_details,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(
                  height: AppSize.s4,
                ),
                AppTextField(textController: _orderDetailsTextController, hint: '',lines: Constants.orderDetailsLines),
                SizedBox(
                  height: AppSize.s22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
