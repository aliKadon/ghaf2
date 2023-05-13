import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../checkout/check_out_getx_controller.dart';

class DisicountScreen extends StatefulWidget {

  @override
  State<DisicountScreen> createState() => _DisicountScreenState();
}

class _DisicountScreenState extends State<DisicountScreen> {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
  Get.put(CheckOutGetxController());

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getPromoCode(context: context, status: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
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
                ),
                Spacer(),
                Text(
                  AppLocalizations.of(context)!.discount,
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
                  physics: NeverScrollableScrollPhysics(),
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
                                              .promoCodes[index].code));
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
}