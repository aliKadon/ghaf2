import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/register_view/register_view.dart';
import 'package:ghaf_application/presentation/screens/seller/regular_seller/register_seller_view.dart';
import 'package:ghaf_application/presentation/screens/seller/welcome_seller_view.dart';

class SellWithUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  ImageAssets.sellWithUs,
                ),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.logo2,
              height: AppSize.s110,
              color: Colors.white,
            ),
            Text(
              AppLocalizations.of(context)!.sell_with_us_text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s22),
            ),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.85,
              height: AppSize.s48,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterView(role: {
                        'role' : 'Seller',
                      }),));
                  },
                  child: Text(
                      AppLocalizations.of(context)!.register_create_account,style: TextStyle(fontSize: FontSize.s16),)),
            ),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.85,
              height: AppSize.s48,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegisterView(role: {
                      'role' : 'IndividualSeller',
                    }),));
                },
                child: Text(
                  AppLocalizations.of(context)!.register_payment_link,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorManager.primaryDark,fontSize: FontSize.s16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
