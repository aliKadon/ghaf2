import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/transaction.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/wallet_getx_controller.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import 'error_top_up.dart';

class EnterAmount extends StatefulWidget {
  //0 -> topUp , 1 -> sharePoint
  final int typeOfPage;
  final String paymentMethodId;

  EnterAmount({required this.typeOfPage, required this.paymentMethodId});

  @override
  State<EnterAmount> createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _amountTextController = TextEditingController();

  //controller
  late final WalletGetxController _walletGetxController =
  Get.put(WalletGetxController());

  @override
  Widget build(BuildContext context) {
    // if(_amountTextController.text == '') {
    //   _amountTextController.text = '00';
    // }
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(AppSize.s8),
          child: Column(
            children: [
              SizedBox(
                height: AppSize.s32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppSize.s6),
                    child: GestureDetector(
                      onTap: () {
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
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.enter_amount,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              Divider(
                thickness: 1,
                color: ColorManager.greyLight,
              ),
              SizedBox(
                height: AppSize.s46,
              ),
              widget.typeOfPage == 1
                  ? Column(
                children: [
                  Row(
                    children: [
                      Text(
                          AppLocalizations.of(context)!
                              .to_beneficiary_user_email,
                          style: TextStyle(
                              color: ColorManager.greyLight,
                              fontSize: FontSize.s16)),
                      SizedBox(
                        width: AppSize.s6,
                      ),
                      GestureDetector(
                        onTap: () {
                          _infoDialog(
                              context,
                              AppLocalizations.of(context)!
                                  .info_enter_amount);
                        },
                        child: Icon(Icons.info_outline,
                            color: ColorManager.greyLight),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * 0.6,
                            height:
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.06,
                            child: TextField(
                                controller: _emailTextController,
                                decoration: InputDecoration(
                                    label: Row(
                                      children: [
                                        Text(AppLocalizations.of(context)!
                                            .email_address),
                                      ],
                                    )),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.s16))),
                      ],
                    ),
                  ),
                ],
              )
                  : Container(),
              SizedBox(
                height: AppSize.s30,
              ),
              // Text(
              //   '00',
              //   style: TextStyle(
              //       color: ColorManager.black,
              //       fontSize: FontSize.s30,
              //       fontWeight: FontWeight.w600),
              // ),

              TextFormField(
                textAlign: TextAlign.center,
                controller: _amountTextController,
                style: TextStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s30,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '00',
                  hintStyle: TextStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s30,
                      fontWeight: FontWeight.w600),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.aed,
                style: TextStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s26,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: AppSize.s20),
              Text(
                AppLocalizations.of(context)!.enter_amount_text,
                style: TextStyle(
                    color: ColorManager.greyLight,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: AppSize.s46),
              Text(
                AppLocalizations.of(context)!.or_quick_select,
                style: TextStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: AppSize.s26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _amountTextController.text = '40';
                    },
                    child: Container(
                      width: AppSize.s84,
                      padding: EdgeInsets.all(AppSize.s12),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.primary,
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Text('40',
                              style: TextStyle(color: ColorManager.primary))),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _amountTextController.text = '50';
                    },
                    child: Container(
                      width: AppSize.s84,
                      padding: EdgeInsets.all(AppSize.s12),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.primary,
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Text('50',
                              style: TextStyle(color: ColorManager.primary))),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _amountTextController.text = '80';
                    },
                    child: Container(
                      width: AppSize.s84,
                      padding: EdgeInsets.all(AppSize.s12),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.primary,
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Text('80',
                              style: TextStyle(color: ColorManager.primary))),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.18,
              ),
              Container(
                height: AppSize.s73,
                width: double.infinity,
                padding: EdgeInsets.all(AppSize.s12),
                child: widget.typeOfPage == 0
                    ? ElevatedButton(
                    onPressed: () {
                      _walletGetxController.topUp(
                          context: context,
                          paymentMethodId: widget.paymentMethodId,
                          amount: int.parse(_amountTextController.text));


                      // _customDialogError(context);
                    },
                    child: Text(AppLocalizations.of(context)!.top_up))
                    : ElevatedButton(
                    onPressed: () {
                      _walletGetxController.sharePoint(context: context,
                          email: _emailTextController.text,
                          amount: int.parse(_amountTextController.text));
                      // _customDialogSuccess(context);
                      // _customDialogError(context);
                    },
                    child: Text(AppLocalizations.of(context)!.send)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _customDialogSuccess(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.success,
                              style: TextStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s22,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.03,
                        ),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.8,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.08,
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                AppLocalizations.of(context)!.success_text,
                                style: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s14),
                              ),
                            )),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01,
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorManager.primaryDark),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(AppSize.s10)))),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ErrorTopUp(),
                                ));
                              },
                              child: Text(AppLocalizations.of(context)!.close)),
                        ),
                      ]),
                ),
              );
            },
          );
        });
  }

  void _customDialogError(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.error,
                              style: TextStyle(
                                  color: ColorManager.red,
                                  fontSize: FontSize.s22,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.03,
                        ),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.8,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.08,
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                AppLocalizations.of(context)!.error_text,
                                style: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s14),
                              ),
                            )),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01,
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorManager.primaryDark),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(AppSize.s10)))),
                              onPressed: () {},
                              child: Text(AppLocalizations.of(context)!.close)),
                        ),
                      ]),
                ),
              );
            },
          );
        });
  }
}

void _infoDialog(BuildContext context, String text) async {
  showDialog(
    context: context,
    builder: (context) {
      return Stack(
        children: [
          SharedPrefController().lang1 == 'en'
              ? Positioned(
            top: 0,
            bottom: 0,
            child: Dialog(
              backgroundColor: ColorManager.greyLight,
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.14,
                width: 250,
                padding: EdgeInsets.all(AppSize.s8),
                decoration: BoxDecoration(
                    color: ColorManager.greyLight,
                    borderRadius: BorderRadius.circular(AppSize.s10)),
                child: Center(
                    child: Text(text,
                        style:
                        TextStyle(color: ColorManager.primaryDark))),
              ),
            ),
          )
              : Positioned(
            top: 0,
            bottom: -250,
            child: Dialog(
              backgroundColor: ColorManager.greyLight,
              child: Container(
                height: 85,
                width: 100,
                padding: EdgeInsets.all(AppSize.s8),
                decoration: BoxDecoration(
                    color: ColorManager.greyLight,
                    borderRadius: BorderRadius.circular(AppSize.s10)),
                child: Text(AppLocalizations.of(context)!.pay_later_text,
                    style: TextStyle(color: ColorManager.primaryDark)),
              ),
            ),
          ),
        ],
      );
    },
  );
}
