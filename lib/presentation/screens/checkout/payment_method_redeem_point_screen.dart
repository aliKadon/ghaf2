import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/checkout/checkout_view.dart';
import 'package:ghaf_application/presentation/screens/checkout/edit_payment_method.dart';
import 'package:ghaf_application/presentation/screens/checkout/snapsheet_screen.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../profile/profile_setting/profile_setting_getx_controller.dart';

class PaymentMethodRedeemPointScreen extends StatefulWidget {
  @override
  State<PaymentMethodRedeemPointScreen> createState() =>
      _PaymentMethodRedeemPointScreenState();
}

class _PaymentMethodRedeemPointScreenState
    extends State<PaymentMethodRedeemPointScreen> {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.find<CheckOutGetxController>();
  late final ProfileSettingGetxController _profileGetxController =
      Get.find<ProfileSettingGetxController>();

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getPaymentMethod(context: context);
    _checkOutGetxController.getPromoCode(context: context,status: -1);
    _profileGetxController.init(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.only(top: AppSize.s60, right: AppSize.s12, left: AppSize.s12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckOutView(),
                        )),
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
                  Container(
                    width: AppSizeWidth.s233,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        AppLocalizations.of(context)!.payment_method_screen,
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s18,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditPaymentMethod(),
                      ));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.edit,
                      style: getSemiBoldStyle(
                        color: ColorManager.greyLight,
                        fontSize: FontSize.s18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Divider(height: 1, color: ColorManager.greyLight),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.017,
              // ),
              // Row(
              //   children: [
              //     Text(
              //       AppLocalizations.of(context)!.redeem_point,
              //       style: getSemiBoldStyle(
              //         color: ColorManager.primaryDark,
              //         fontSize: FontSize.s20,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.017,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     // setState(() {
              //     //   if (useRedeemPoint == false) {
              //     //     useRedeemPoint = true;
              //     //   } else {
              //     //     useRedeemPoint = false;
              //     //   }
              //     // });
              //   },
              //   child: Container(
              //     width: double.infinity,
              //     padding: EdgeInsets.all(AppSize.s8),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       color: Colors.white,
              //       border: Border.all(
              //         color: Color(0xff125051),
              //       ),
              //     ),
              //     child: Row(
              //       children: [
              //         Padding(
              //           padding: EdgeInsets.all(AppSize.s15),
              //           child: Text(
              //             AppLocalizations.of(context)!.point,
              //             style: getSemiBoldStyle(
              //               color: ColorManager.primary,
              //               fontSize: FontSize.s20,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: MediaQuery.of(context).size.width * 0.15,
              //         ),
              //         Column(
              //           children: [
              //             Text(
              //               '${_checkOutGetxController.orderToPay[_checkOutGetxController.orderToPay.length -1].customerPoints} ${AppLocalizations.of(context)!.point}',
              //               style: getSemiBoldStyle(
              //                 color: ColorManager.primaryDark,
              //                 fontSize: FontSize.s16,
              //               ),
              //             ),
              //             Text(
              //               '${AppLocalizations.of(context)!.expiry_date} 2\\2023',
              //               style: getSemiBoldStyle(
              //                 color: ColorManager.greyLight,
              //                 fontSize: FontSize.s12,
              //               ),
              //             ),
              //           ],
              //         ),
              //         Spacer(),
              //         Visibility(
              //             visible: false,
              //             child: Icon(
              //               Icons.check_circle,
              //               color: Colors.green,
              //             )),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.017,
              // ),
              // Row(
              //   children: [
              //     Text(
              //       AppLocalizations.of(context)!.promo_code,
              //       style: getSemiBoldStyle(
              //         color: ColorManager.primaryDark,
              //         fontSize: FontSize.s20,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: MediaQuery
              //       .of(context)
              //       .size
              //       .height * 0.017,
              // ),
              // GetBuilder<CheckOutGetxController>(
              //   builder: (controller) {
              //     return controller.paymentMethod == 0
              //         ? Padding(
              //             padding: const EdgeInsets.only(top: 225.0),
              //             child: Text(
              //                 AppLocalizations.of(context)!.no_payment_method,
              //                 style: TextStyle(
              //                     color: ColorManager.primaryDark,
              //                     fontSize: FontSize.s20,
              //                     fontWeight: FontWeight.w400)),
              //           )
              //         : ListView.builder(
              //             shrinkWrap: true,
              //             itemCount: controller.promoCodes.length,
              //             itemBuilder: (context, index) {
              //               return Column(
              //                 children: [
              //                   GestureDetector(
              //                     onTap: () {
              //                       // Navigator.of(context)
              //                       //     .pushReplacement(
              //                       //     MaterialPageRoute(
              //                       //       builder: (context) => CheckOutView(
              //                       //           paymentMethod:
              //                       //           'Card : **** **** **** **** ${cubit.getPaymentMethods[index].last4Digits}',
              //                       //           paymentMethodId: cubit
              //                       //               .getPaymentMethods[
              //                       //           index]
              //                       //               .id!,
              //                       //           useRedeemPoints:
              //                       //           useRedeemPoint),
              //                       //     ));
              //                     },
              //                     child: Container(
              //                       width: double.infinity,
              //                       padding: EdgeInsets.all(AppSize.s8),
              //                       decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(12),
              //                         color: Colors.white,
              //                         border: Border.all(
              //                           color: ColorManager.greyLight,
              //                         ),
              //                       ),
              //                       child: Row(
              //                         children: [
              //                           Text(
              //                               _checkOutGetxController
              //                                   .promoCodes[index].storeName!,
              //                               style: TextStyle(
              //                                   color: ColorManager.primaryDark,
              //                                   fontSize: FontSize.s16,
              //                                   fontWeight: FontWeight.w600)),
              //                           SizedBox(
              //                             width: MediaQuery.of(context)
              //                                     .size
              //                                     .width *
              //                                 0.1,
              //                           ),
              //                           Column(
              //                             children: [
              //                               Row(
              //                                 children: [
              //                                   Text(
              //                                     _checkOutGetxController
              //                                         .promoCodes[index].code!,
              //                                     style: TextStyle(
              //                                         fontWeight:
              //                                             FontWeight.bold),
              //                                   ),
              //                                 ],
              //                               ),
              //                               Text(
              //                                 '${AppLocalizations.of(context)!.discount} : ${_checkOutGetxController.promoCodes[index].discount}%',
              //                                 style: getSemiBoldStyle(
              //                                   color: ColorManager.greyLight,
              //                                   fontSize: FontSize.s12,
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                           Spacer(),
              //                           InkWell(
              //                               onTap: () {
              //                                 Clipboard.setData(ClipboardData(
              //                                     text: _checkOutGetxController
              //                                         .promoCodes[index].code));
              //                               },
              //                               child: Text(
              //                                 AppLocalizations.of(context)!
              //                                     .copy,
              //                                 style: TextStyle(
              //                                     fontSize: FontSize.s14,
              //                                     fontWeight: FontWeight.w600,
              //                                     color: ColorManager.primary),
              //                               ))
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: MediaQuery.of(context).size.height *
              //                         0.017,
              //                   ),
              //                 ],
              //               );
              //             },
              //           );
              //   },
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.017,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.payment_method,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s20,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => PaymentScreen(
                      //       isBankInformationScreen: false),
                      // ));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SnapsheetScreen(),
                      ));
                    },
                    child: Icon(
                      Icons.add_circle,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
              // cubit.getPaymentMethods.isEmpty
              //     ? Padding(
              //   padding: const EdgeInsets.only(top: 225.0),
              //   child: Text(AppLocalizations.of(context)!.no_payment_method,
              //       style: TextStyle(
              //           color: ColorManager.primaryDark,
              //           fontSize: FontSize.s20,
              //           fontWeight: FontWeight.w400)),
              // )
              //     :
              GetBuilder<CheckOutGetxController>(
                builder: (controller) {
                  return controller.paymentMethod == 0
                      ? Padding(
                          padding:  EdgeInsets.only(top: AppSize.s225),
                          child: Text(
                              AppLocalizations.of(context)!.no_payment_method,
                              style: TextStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s20,
                                  fontWeight: FontWeight.w400)),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.paymentMethod.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (_) {
                                    _checkOutGetxController.deletePaymentMethod(
                                        context: context,
                                        id: _checkOutGetxController
                                            .paymentMethod[index].id!);
                                    // cubit.deletePaymentMethod(
                                    //     id: cubit
                                    //         .getPaymentMethods[index]
                                    //         .id!,
                                    //     context: context);
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: GestureDetector(
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop({
                                          'cardNumber':controller
                                              .paymentMethod[index]
                                              .last4Digits,
                                          'paymentMethodId' : controller
                                              .paymentMethod[index].id
                                        });
                                        // Navigator.of(context)
                                        //     .pushReplacement(MaterialPageRoute(
                                        //   builder: (context) => CheckOutView(
                                        //       cardNumber: controller
                                        //           .paymentMethod[index]
                                        //           .last4Digits,
                                        //       paymentMethodId: controller
                                        //           .paymentMethod[index].id),
                                        // ));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(AppSize.s8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(AppSize.s12),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: ColorManager.greyLight,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            _checkOutGetxController
                                                        .paymentMethod[index]
                                                        .image ==
                                                    null
                                                ? Image.asset(ImageAssets.visa,
                                                    height: 55, width: 55)
                                                : Image.network(
                                                    _checkOutGetxController
                                                        .paymentMethod[index]
                                                        .image!,
                                                    height: 55,
                                                    width: 55),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '**** **** **** **** ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      _checkOutGetxController
                                                          .paymentMethod[index]
                                                          .last4Digits!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${AppLocalizations.of(context)!.expiry_date} ${_checkOutGetxController.paymentMethod[index].expMonth}\\${_checkOutGetxController.paymentMethod[index].expYear}',
                                                  style: getSemiBoldStyle(
                                                    color:
                                                        ColorManager.greyLight,
                                                    fontSize: FontSize.s12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.017,
                                ),
                              ],
                            );
                          },
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
