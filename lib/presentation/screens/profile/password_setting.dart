
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  var language = SharedPrefController().lang1;

  @override
  void initState() {
    _newPassword = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _confirmPassword.dispose();
    _newPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
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
                    "Password setting",
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
                    label: Text('New password',
                      style: TextStyle(color: ColorManager.greyLight),)),

                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'password must is not empty';
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
                    label: Text('Confirm password',
                      style: TextStyle(color: ColorManager.greyLight),)),

                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'password must is not empty';
                  return null;
                },
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
                padding: EdgeInsets.all(8),
                child: ElevatedButton(onPressed: (){}, child: Text(AppLocalizations.of(context)!.save)),
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

