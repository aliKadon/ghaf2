import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/top_up_screen.dart';

class ErrorTopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 1,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.28,
            ),
            Image.asset(
              ImageAssets.errorTopUP,
              height: AppSize.s110,
            ),
            SizedBox(height: AppSize.s20),
            Text(
              AppLocalizations.of(context)!.top_up_failed,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: FontSize.s22,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: AppSize.s30),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.top_up_failed_text,
              style: TextStyle(
                  color: ColorManager.greyLight,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.2,),
            Container(
              height: AppSize.s73,
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: ElevatedButton(
                  onPressed: () {
                    // _customDialogSuccess(context);
                    // _customDialogError(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => TopUpScreen(),));
                  },
                  child: Text(AppLocalizations.of(context)!.try_another_card)),
            ),
          ],
        ),
      ),
    );
  }
}
