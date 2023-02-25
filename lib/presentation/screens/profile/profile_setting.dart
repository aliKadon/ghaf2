import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ProfileSetting extends StatefulWidget {
  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  late TextEditingController _firstNameTextController;

  late TextEditingController _lastNameTextController;
  late TextEditingController _phoneTextController;

  var language = SharedPrefController().lang1;

  @override
  void initState() {
    _firstNameTextController = TextEditingController();
    _lastNameTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _phoneTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s20,
            ),
            Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.profile_setting,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            // SizedBox(
            //   height: AppSize.s8,
            // ),
            Divider(
              thickness: 1,
              color: ColorManager.greyLight,
            ),
            SizedBox(
              height: AppSize.s30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
              ),
              child: TextFormField(
                controller: _firstNameTextController,
                decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.first_name,
                      style: TextStyle(color: ColorManager.greyLight),)),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return AppLocalizations.of(context)!
                        .first_name_is_required;
                  return null;
                },
              ),
            ),

            SizedBox(
              height: AppSize.s14,
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return AppLocalizations.of(context)!
                        .last_name_is_required;
                  return null;
                },
                controller: _lastNameTextController,
                decoration: InputDecoration(
                    label: Text(
                  AppLocalizations.of(context)!.last_name,
                  style: TextStyle(color: ColorManager.greyLight),
                )),
              ),
            ),
            SizedBox(
              height: AppSize.s14,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
              ),
              child: TextFormField(
                controller: _phoneTextController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.phone_number,
                  hintStyle: getMediumStyle(
                    color: ColorManager.greyLight,
                  ),
                  filled: false,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: AppPadding.p18, horizontal: AppPadding.p4),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    borderSide: BorderSide(
                      width: AppSize.s1,
                      color: ColorManager.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    borderSide: BorderSide(
                      width: AppSize.s1,
                      color: ColorManager.grey,
                    ),
                  ),
                  prefixIcon: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: AppSize.s15,
                        ),
                        Image.asset(
                          ImageAssets.uaeFlag,
                          fit: BoxFit.fill,
                          height: AppSize.s34,
                          width: AppSize.s34,
                        ),
                        SizedBox(
                          width: AppSize.s15,
                        ),
                        Container(
                          height: double.infinity,
                          width: AppSize.s1,
                          color: ColorManager.grey,
                        ),
                        SizedBox(
                          width: AppSize.s15,
                        ),
                      ],
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return AppLocalizations.of(context)!
                        .phone_number_is_required;
                  return null;
                },
                onSaved: (value) {},
              ),
            ),
            SizedBox(
              height: AppSize.s14,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(AppLocalizations.of(context)!.saved_address,style: TextStyle(fontSize: FontSize.s18)),
                  Spacer(),
                  language == 'en' ? Image.asset(IconsAssets.arrow2,height: AppSize.s18,color: ColorManager.primary,) : Image.asset(IconsAssets.arrow,height: AppSize.s18,color: ColorManager.primary,),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s65,
            ),
            Container(
              width: double.infinity,
              height: AppSize.s65,
              padding: EdgeInsets.all(8),
              child: ElevatedButton(onPressed: (){}, child: Text(AppLocalizations.of(context)!.save)),
            )
          ],
        ),
      ),
    );
  }
}
