import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/profile/profile_getx_controller.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class PasswordSetting extends StatefulWidget {
  const PasswordSetting({Key? key}) : super(key: key);

  @override
  State<PasswordSetting> createState() => _PasswordSettingState();
}

class _PasswordSettingState extends State<PasswordSetting> {
  late TextEditingController _newPassword;
  late TextEditingController _confirmPassword;
  late TextEditingController _oldPassword;

  var language = SharedPrefController().lang1;

  @override
  void initState() {
    _newPassword = TextEditingController();
    _confirmPassword = TextEditingController();
    _oldPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _confirmPassword.dispose();
    _newPassword.dispose();
    _oldPassword.dispose();
    super.dispose();
  }

  //controller
  late final ProfileGetxController _profileSettingGetxController =
      ProfileGetxController();

  late final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSize.s8),
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
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.038,
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Image.asset(
                        SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${AppLocalizations.of(context)!.password_setting}",
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
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p8,
                    ),
                    child: TextFormField(
                      controller: _oldPassword,
                      cursorColor: ColorManager.primary,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          label: Text(
                            AppLocalizations.of(context)!.old_password,
                            style: TextStyle(color: ColorManager.greyLight),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return AppLocalizations.of(context)!.field_required;
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p8,
                    ),
                    child: TextFormField(
                      controller: _newPassword,
                      cursorColor: ColorManager.primary,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          label: Text(
                            AppLocalizations.of(context)!.new_password,
                            style: TextStyle(color: ColorManager.greyLight),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return AppLocalizations.of(context)!.field_required;
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p8,
                    ),
                    child: TextFormField(
                      controller: _confirmPassword,
                      cursorColor: ColorManager.primary,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          label: Text(
                            AppLocalizations.of(context)!.confirm_password,
                            style: TextStyle(color: ColorManager.greyLight),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return AppLocalizations.of(context)!.field_required;
                        return null;
                      },
                    ),
                  ),
                ],
              ),

            ),


            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p8,
              ),
              child: Container(
                width: double.infinity,
                height: AppSize.s65,
                padding: EdgeInsets.all(AppSize.s8),
                child: ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      _profileSettingGetxController.changePassword(
                          context: context,
                          oldPassword: _oldPassword.text,
                          newPassword: _newPassword.text,
                          confirmPassword: _confirmPassword.text);
                    },
                    child: Text(AppLocalizations.of(context)!.save)),
              ),
            ),
            SizedBox(
              height: AppSize.s92,
            ),
          ],
        ),
      ),
    );
  }
}
