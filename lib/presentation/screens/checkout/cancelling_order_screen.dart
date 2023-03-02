import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

class CancellingOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            Image.asset(
              ImageAssets.correctSign,
              height: AppSize.s110,
            ),
            SizedBox(height: AppSize.s20),
            Text(
              AppLocalizations.of(context)!.cancelling_order,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s20,
                  color: Colors.black),
            ),
            SizedBox(height: AppSize.s24),
            Text(
              AppLocalizations.of(context)!.cancelling_order_text,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s14,
                  color: Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                width: double.infinity,
                height: AppSize.s60,

                child: ElevatedButton(onPressed: () {
                  Navigator.of(context).pop();

                }, child: Text(AppLocalizations.of(context)!.ok)),
              ),
            )

          ],
        ),
      ),
    );
  }
}
