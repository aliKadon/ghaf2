import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import 'error_top_up.dart';

class EnterAmount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  child: Image.asset(
                    IconsAssets.arrow,
                    height: AppSize.s18,
                    width: AppSize.s10,
                    color: ColorManager.primaryDark,
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
            height: AppSize.s110,
          ),
          Text(
            '00',
            style: TextStyle(
                color: ColorManager.black,
                fontSize: FontSize.s30,
                fontWeight: FontWeight.w600),
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
          SizedBox(height: AppSize.s60),
          Text(
            AppLocalizations.of(context)!.or_quick_select,
            style: TextStyle(
                color: ColorManager.black,
                fontSize: FontSize.s16,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: AppSize.s30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                width: AppSize.s84,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.primary,
                    ),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text('40',
                        style: TextStyle(color: ColorManager.primary))),
              ),
              Spacer(),
              Container(
                width: AppSize.s84,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.primary,
                    ),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text('50',
                        style: TextStyle(color: ColorManager.primary))),
              ),
              Spacer(),
              Container(
                width: AppSize.s84,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.primary,
                    ),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text('80',
                        style: TextStyle(color: ColorManager.primary))),
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.27,
          ),
          Container(
            height: AppSize.s73,
            width: double.infinity,
            padding: EdgeInsets.all(12),
            child: ElevatedButton(
                onPressed: () {
                  _customDialogSuccess(context);
                  // _customDialogError(context);
                },
                child: Text(AppLocalizations.of(context)!.top_up)),
          )
        ],
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

                                style: TextStyle(color: ColorManager.primary,
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
                                          BorderRadius.circular(10)))),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ErrorTopUp(),));
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

                                style: TextStyle(color: ColorManager.primary,
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
                                          BorderRadius.circular(10)))),
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
