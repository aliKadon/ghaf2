import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/offers/widgets/offers_widget.dart';
import 'package:ghaf_application/presentation/screens/offers_view/offers_view.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class OffersScreenNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.all(AppSize.s6),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
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
                AppLocalizations.of(context)!.offers,
                style: getSemiBoldStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s18,
                ),
              ),
              Spacer(),
            ],
          ),
          Divider(
            thickness: 1,
            color: ColorManager.greyLight,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.84,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 7,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    OffersWidget(),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Divider(thickness: 1,color: Colors.grey,),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
