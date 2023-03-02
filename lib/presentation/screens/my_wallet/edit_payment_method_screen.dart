import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';


class EditPaymentMethodScreen extends StatefulWidget {

  @override
  State<EditPaymentMethodScreen> createState() => _EditPaymentMethodScreenState();
}

class _EditPaymentMethodScreenState extends State<EditPaymentMethodScreen> {

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
                        .edit_payment_details,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selected = index;
                          });
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
                                            'Visa xxxx-4851',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .bold),
                                          ),
                                        ],
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

                },
                child: Column(
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