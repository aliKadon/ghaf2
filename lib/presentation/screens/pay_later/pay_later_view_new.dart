import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/widgets/most_popular_product_widget.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class PayLaterViewNew extends StatefulWidget {
  @override
  State<PayLaterViewNew> createState() => _PayLaterViewNewState();
}

class _PayLaterViewNewState extends State<PayLaterViewNew> {
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    List payLaterType = [
      AppLocalizations.of(context)!.active,
      AppLocalizations.of(context)!.complete
    ];
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    IconsAssets.arrow,
                    height: AppSize.s18,
                    width: AppSize.s10,
                  ),
                ),
              ),
              Spacer(),
              Text(
                AppLocalizations.of(context)!.pay_later,
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
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            color: ColorManager.greyLight,
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.available_credit,
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s20,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'AED 0.00',
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.total_limit} AED 0.00',
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.07,
            child: ListView.builder(
              shrinkWrap: true,
              itemExtent: MediaQuery.of(context).size.width * 0.5,
              itemCount: payLaterType.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      selected == index
                          ? Text(payLaterType[index],
                              style: TextStyle(
                                  fontSize: FontSize.s18,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.primaryDark))
                          : Text(payLaterType[index],
                              style: TextStyle(fontSize: FontSize.s14)),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(
            thickness: 1,
            color: ColorManager.greyLight,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 300),
              itemBuilder: (context, index) {
                return MostPopularProductWidget();
              },
            ),
          )
        ],
      ),
    );
  }
}
