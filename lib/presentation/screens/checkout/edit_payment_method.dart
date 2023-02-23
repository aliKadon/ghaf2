import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class EditPaymentMethod extends StatelessWidget {

  var selected = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 60.0, right: 12.0, left: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // if (widget.isBankingScreen!) {
                      //   Navigator.of(context)
                      //       .pushReplacement(MaterialPageRoute(
                      //     builder: (context) =>
                      //         BankingInformation(),
                      //   ));
                      // } else {
                      //   Navigator.of(context)
                      //       .pushReplacement(MaterialPageRoute(
                      //     builder: (context) =>
                      //         PaymentMethodRedeemPointScreen(),
                      //   ));
                      // }
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: 18,
                      width: 10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!
                        .banking_information,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      // if (widget.isBankingScreen!) {
                      //   Navigator.of(context)
                      //       .pushReplacement(MaterialPageRoute(
                      //     builder: (context) =>
                      //         BankingInformation(),
                      //   ));
                      // } else {
                      //   Navigator.of(context)
                      //       .pushReplacement(MaterialPageRoute(
                      //     builder: (context) =>
                      //         PaymentMethodRedeemPointScreen(),
                      //   ));
                      // }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.done,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.017,
              ),
              // cubit.getPaymentMethods.isEmpty
              //     ? Padding(
              //   padding: const EdgeInsets.only(top: 225.0),
              //   child: Text(
              //       AppLocalizations.of(context)!
              //           .no_payment_method,
              //       style: TextStyle(
              //           color: ColorManager.primaryDark,
              //           fontSize: FontSize.s20,
              //           fontWeight: FontWeight.w400)),
              // )
              //     :
              ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // setState(() {
                          //   selected = index;
                          // });
                        },
                        child: Row(
                          children: [
                            selected == index
                                ? Icon(
                              Icons
                                  .radio_button_checked,
                              color:
                              ColorManager.primary,
                            )
                                : Icon(Icons.radio_button_off,
                                color: ColorManager
                                    .greyLight),
                            SizedBox(
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.06,
                            ),
                            Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.8,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(12),
                                color: Colors.white,
                                border: Border.all(
                                  color: ColorManager
                                      .greyLight,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                      ImageAssets.visa,
                                      height: 55,
                                      width: 55),
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.1,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '**** **** **** ****',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .bold),
                                          ),
                                          Text(
                                           '2563',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .bold),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${AppLocalizations.of(context)!.expiry_date} 10\\2023',
                                        style:
                                        getSemiBoldStyle(
                                          color: ColorManager
                                              .greyLight,
                                          fontSize:
                                          FontSize.s12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context)
                            .size
                            .height *
                            0.03,
                      ),
                    ],
                  );
                },
              ),
              InkWell(
                onTap: () {
                  // cubit.deletePaymentMethod(
                  //     id: cubit.getPaymentMethods[selected].id!,
                  //     context: context);
                },
                child: selected == -1
                    ? Container()
                    : Column(
                  children: [
                    Icon(
                      Icons.delete_outline_outlined,
                      color: Colors.red,
                      size: 45,
                    ),
                    Text(
                      AppLocalizations.of(context)!.delete,
                      style: getSemiBoldStyle(
                        color: ColorManager.red,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}