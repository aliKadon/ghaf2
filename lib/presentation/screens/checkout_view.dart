import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/screens/checkout_confirm_view.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({Key? key}) : super(key: key);

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  late TextEditingController _paymentMethodTextController;
  @override
  void initState() {
    super.initState();
    _paymentMethodTextController = TextEditingController();
  }

  @override
  void dispose() {
    _paymentMethodTextController.dispose();
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
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.checkout,
                      style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: AppSize.s12,),
                Divider(height: 1,color: ColorManager.greyLight),
                SizedBox(height: AppSize.s12,),
                Text(
                  AppLocalizations.of(context)!.delivery_method,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(height: AppSize.s12,),
                Container(
                  height: AppSize.s110,
                  child: ListView.builder(
                    shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                    itemCount: 10,
                      itemBuilder: (context,index){
                    return Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: AppSize.s8,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: AppSize.s75,
                            width: AppSize.s75,
                            padding: EdgeInsets.all(AppPadding.p12),
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              border: Border.all(
                                  width: AppSize.s1,
                                  color: ColorManager.greyLight),
                              borderRadius:
                              BorderRadius.circular(AppRadius.r4),
                            ),
                            child: Image.asset(
                              IconsAssets.cart,
                              height: AppSize.s36,
                              width: AppSize.s36,
                            ),
                          ),
                          SizedBox(
                            height: AppSize.s7,
                          ),
                          Text(
                            'Pickup',
                            style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s12,
                            ),
                          ),
                        ],
                      ),
                    );

                  }),
                ),
                SizedBox(height: AppSize.s22,),
                Text(
                  AppLocalizations.of(context)!.delivery_method,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(height: AppSize.s12,),
                Container(
                  margin: EdgeInsets.only(
                      bottom: AppMargin.m16,
                      right: AppMargin.m16,
                      left: AppMargin.m16),
                  child: TextField(
                    controller: _paymentMethodTextController,
                    textInputAction: TextInputAction.search,
                    textAlign: TextAlign.start,
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
                        child: Image.asset(
                          IconsAssets.selected,
                          width: AppSize.s18,
                          height: AppSize.s18,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p16,
                          vertical: AppPadding.p16),
                      hintText: AppLocalizations.of(context)!.hint_payment_method,
                      hintStyle: getMediumStyle(
                        color: ColorManager.hintTextFiled,
                      ),
                      enabledBorder: buildOutlineInputBorder(
                        color: ColorManager.grey,
                      ),
                      focusedBorder: buildOutlineInputBorder(
                        color: ColorManager.grey,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: AppSize.s20,),

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
                Row(children: [
                  Text(
                    AppLocalizations.of(context)!.address,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    IconsAssets.plus2,
                    height: AppSize.s22,
                    width: AppSize.s22,
                  ),
                ]),
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


                SizedBox(height: AppSize.s44,),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => CheckOutConfirmView()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.checkout,
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s24,),


              ],
            ),
          ),
        ),
      ),
    );
  }
  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.r8),
      borderSide: BorderSide(
        width: AppSize.s1,
        color: color,
      ),
    );
  }
}

