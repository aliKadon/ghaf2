import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/onsale_widget.dart';

class OnsaleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
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
                  AppLocalizations.of(context)!.on_sale,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Divider(
            color: ColorManager.greyLight,
            thickness: 1,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: AppSize.s311),
              itemBuilder: (context, index) {
                return OnsaleWidget();
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            padding: EdgeInsets.all(5),
            child: ElevatedButton(onPressed: (){}, child: Row(
              children: [
                Text('30 AED'),
                Spacer(),
                Icon(Icons.shopping_bag_outlined),
                Text(AppLocalizations.of(context)!.add_to_cart)
              ],
            ),),
          )
        ],
      ),
    );
  }
}
