import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class Vouchers extends StatefulWidget {
  @override
  State<Vouchers> createState() => _VouchersState();
}

class _VouchersState extends State<Vouchers> {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());
  var selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getPromoCode(context: context, status: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List vouchersType = [
      AppLocalizations.of(context)!.active,
      AppLocalizations.of(context)!.used,
      AppLocalizations.of(context)!.expired
    ];
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSize.s12),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // allRedeemPoint = 0;
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.038,
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Image.asset(
                      SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  AppLocalizations.of(context)!.vouchers,
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
              height: AppSize.s30,
            ),
            Card(
              elevation: 3,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                padding: EdgeInsets.all(AppSize.s14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  border: Border.all(color: ColorManager.greyLight),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      ImageAssets.percent,
                    ),
                    SizedBox(
                      width: AppSize.s20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.got_a_code,
                          style: TextStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          AppLocalizations.of(context)!.add_your_code_and_save,
                          style: TextStyle(
                              color: ColorManager.greyLight,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: vouchersType.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selected = index;
                      });
                      _checkOutGetxController.getPromoCode(context: context, status: index);
                    },
                    child: selected == index
                        ? Row(
                            children: [
                              VouchersType(context, vouchersType[index],
                                  ColorManager.primary),
                              SizedBox(
                                width: AppSize.s30,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              VouchersType(context, vouchersType[index],
                                  ColorManager.greyLight),
                              SizedBox(
                                width: AppSize.s30,
                              ),
                            ],
                          ),
                  );
                },
              ),
            ),
            SizedBox(
              height: AppSize.s30,
            ),
            GetBuilder<CheckOutGetxController>(
              builder: (controller) {
                return controller.promoCodes.isEmpty
                    ? Column(
                        children: [
                          Image.asset(
                            ImageAssets.voucher,
                            height: AppSize.s222,
                          ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          Text(
                            AppLocalizations.of(context)!.no_vouchers_available,
                            style: TextStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .you_can_find_your_vouchers_available,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.promoCodes.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.of(context)
                                  //     .pushReplacement(
                                  //     MaterialPageRoute(
                                  //       builder: (context) => CheckOutView(
                                  //           paymentMethod:
                                  //           'Card : **** **** **** **** ${cubit.getPaymentMethods[index].last4Digits}',
                                  //           paymentMethodId: cubit
                                  //               .getPaymentMethods[
                                  //           index]
                                  //               .id!,
                                  //           useRedeemPoints:
                                  //           useRedeemPoint),
                                  //     ));
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(AppSize.s8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: ColorManager.greyLight,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                          _checkOutGetxController
                                              .promoCodes[index].storeName!,
                                          style: TextStyle(
                                              color: ColorManager.primaryDark,
                                              fontSize: FontSize.s16,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                _checkOutGetxController
                                                    .promoCodes[index].code!,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${AppLocalizations.of(context)!.discount} : ${_checkOutGetxController.promoCodes[index].discount}%',
                                            style: getSemiBoldStyle(
                                              color: ColorManager.greyLight,
                                              fontSize: FontSize.s12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      InkWell(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                text: _checkOutGetxController
                                                    .promoCodes[index].code!));
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!.copy,
                                            style: TextStyle(
                                                fontSize: FontSize.s14,
                                                fontWeight: FontWeight.w600,
                                                color: ColorManager.primary),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.017,
                              ),
                            ],
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget VouchersType(BuildContext context, String text, Color color) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color)),
      padding: EdgeInsets.all(AppSize.s14),
      child: Text(text, style: TextStyle(color: color)),
    );
  }
}
