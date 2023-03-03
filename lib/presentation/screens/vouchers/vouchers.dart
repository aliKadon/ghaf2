import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class Vouchers extends StatefulWidget {

  @override
  State<Vouchers> createState() => _VouchersState();
}

class _VouchersState extends State<Vouchers> {
  var selected = -1;

  @override
  Widget build(BuildContext context) {
    List vouchersType = [
      AppLocalizations.of(context)!.active,
      AppLocalizations.of(context)!.used,
      AppLocalizations.of(context)!.expired
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // allRedeemPoint = 0;
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    IconsAssets.arrow,
                    height: AppSize.s18,
                    width: AppSize.s10,
                  ),
                ),
                Spacer(),
                Text(
                  AppLocalizations.of(context)!.vouchers,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: AppSize.s12,
            ),
            Divider(height: 1, color: ColorManager.greyLight),
            SizedBox(
              height: AppSize.s30,
            ),
            Card(
              elevation: 3,
              child: Container(
                width: double.infinity,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorManager.greyLight),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      ImageAssets.percent,
                    ),
                    SizedBox(
                      width: AppSize.s20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.got_a_code,
                          style: TextStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          AppLocalizations.of(context)!.add_your_code_and_save,
                          style: TextStyle(
                              color: ColorManager.greyLight,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: vouchersType.length,
                itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                  },
                  child: selected == index ? Row(
                    children: [
                      VouchersType(context, vouchersType[index], ColorManager.primary),
                      SizedBox(width: AppSize.s30,),
                    ],
                  ) : Row(
                    children: [
                      VouchersType(context, vouchersType[index], ColorManager.greyLight),
                      SizedBox(width: AppSize.s30,),
                    ],
                  ),
                );
              },),
            ),

            SizedBox(
              height: AppSize.s30,
            ),
            Image.asset(ImageAssets.voucher,height: AppSize.s222,),
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
              AppLocalizations.of(context)!.you_can_find_your_vouchers_available,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget VouchersType(BuildContext context, String text, Color color) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color)),
      padding: EdgeInsets.all(14),
      child: Text(text, style: TextStyle(color: color)),
    );
  }
}
