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

class AddItemSellerView extends StatefulWidget {
  const AddItemSellerView({Key? key}) : super(key: key);

  @override
  State<AddItemSellerView> createState() =>
      _AddItemSellerViewState();
}

class _AddItemSellerViewState
    extends State<AddItemSellerView> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.s9,
              ),
              Row(
                children: [
                  Image.asset(
                    IconsAssets.arrow,
                    height: AppSize.s24,
                    width: AppSize.s24,
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.add_item,
                    style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s24),
                  ),
                  Spacer(),
                 Container(
                    height: AppSize.s24,
                    width: AppSize.s24,
                  ),
                ],
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              Row(
                children: [
                  Image.asset(
                    IconsAssets.plus2,
                    height: AppSize.s24,
                    width: AppSize.s24,
                  ),
                  SizedBox(
                    width: AppSize.s8,
                  ),
                  Text(
                    AppLocalizations.of(context)!.create_new_item,
                    style: getMediumStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18),
                  ),
                ],
              ),
              SizedBox(
                height: AppSize.s22,
              ),
              Row(
                children: [
                  Image.asset(
                    ImageAssets.logo1,
                    height: AppSize.s73,
                    width: AppSize.s73,
                  ),
                  SizedBox(
                    width: AppSize.s8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'paper',
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s18),
                      ),
                      SizedBox(
                        height: AppSize.s6,
                      ),
                      Text(
                        '0 sold | AED 2.00',
                        style: getRegularStyle(
                            color: ColorManager.greyLight,
                            fontSize: FontSize.s16),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: AppSize.s20,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
