import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import '../../../data/api/controllers/auth_api_controller.dart';
import '../../../domain/model/api_response.dart';
import '../../../domain/model/user.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import 'dart:math' as math; // import this

class StoreSellerView extends StatefulWidget {
  const StoreSellerView({Key? key}) : super(key: key);

  @override
  State<StoreSellerView> createState() => _StoreSellerViewState();
}

class _StoreSellerViewState extends State<StoreSellerView> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppSize.s9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.store,
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s24),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Image.asset(
                  ImageAssets.store,
                  height: AppSize.s86,
                  width: AppSize.s86,
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Text(
                  'name store',
                  style: getSemiBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s20),
                ),
                SizedBox(
                  height: AppSize.s40,
                ),
                Row(
                  children: [
                    Image.asset(
                      IconsAssets.wallet1,
                      height: AppSize.s28,
                      width: AppSize.s28,
                    ),
                    SizedBox(
                      width: AppSize.s24,
                    ),
                    Text(
                      AppLocalizations.of(context)!.sales,
                      style: getSemiBoldStyle(
                          color: ColorManager.primary, fontSize: FontSize.s16),
                    ),
                    Spacer(),
                    Text(
                      '100 AED',
                      style: getSemiBoldStyle(
                          color: ColorManager.greyLight,
                          fontSize: FontSize.s16),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                  child: Divider(
                    color: ColorManager.greyLight,
                    height: AppSize.s1,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      IconsAssets.offers1,
                      height: AppSize.s28,
                      width: AppSize.s28,
                    ),
                    SizedBox(
                      width: AppSize.s24,
                    ),
                    Text(
                      AppLocalizations.of(context)!.catalog,
                      style: getSemiBoldStyle(
                          color: ColorManager.primary, fontSize: FontSize.s16),
                    ),
                    Spacer(),
                    Transform(
                      transform: Matrix4.rotationY(math.pi),
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s28,
                        width: AppSize.s28,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                Divider(
                  color: ColorManager.greyLight,
                  height: AppSize.s1,
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
