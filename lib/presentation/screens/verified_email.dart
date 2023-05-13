import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifiedEmail extends StatefulWidget {
  const VerifiedEmail({Key? key}) : super(key: key);

  @override
  State<VerifiedEmail> createState() => _VerifiedEmailState();
}

class _VerifiedEmailState extends State<VerifiedEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              AppLocalizations.of(context)!.must_verify,
              style: TextStyle(
                fontSize: FontSize.s30,
                color: Colors.red,
              ),

            ),
            SizedBox(
              height: AppSize.s20,
            ),
            ElevatedButton(
              onPressed: _customDialogProgress,
                // onPressed: (){Navigator.of(context).pushReplacementNamed(Routes.loginRoute);},
                child: Text(AppLocalizations.of(context)!.back_login)),
          ],
        ),
      ),
    );
  }

  void _customDialogProgress() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s85,
              width: AppSize.s85,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s40,
                          width: AppSize.s40,
                        ),
                        SizedBox(
                          width: AppSize.s20,
                        ),
                        Text(
                          '\zxz\sad',

                    ),
                    SizedBox(
                      height: AppSize.s40,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                       ' AppLocalizations.of(context)!are_you_sure_cancel_your_subscription',
                        textAlign: TextAlign.center,
                      //   style: getMediumStyle(
                      //       color: ColorManager.primaryDark,
                      //       fontSize: FontSize.s20),
                      // ),
                    ),),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: AppSize.s110,
                              height: AppSize.s38,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorManager.primaryDark,
                                borderRadius:
                                BorderRadius.circular(AppRadius.r8),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.yes,
                                textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          ]
                        ),
                        SizedBox(
                          width: AppSize.s6,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: AppSize.s110,
                              height: AppSize.s38,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius:
                                BorderRadius.circular(AppRadius.r8),
                                border: Border.all(
                                    color: ColorManager.primaryDark,
                                    width: AppSize.s1),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.no,
                                textAlign: TextAlign.center,

                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                  ]),
            ),
          );
        });
  }
}
