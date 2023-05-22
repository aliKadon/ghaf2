import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/presentation/screens/addresses_view/addresses_view.dart';
import 'package:ghaf_application/presentation/screens/login_view/login_view.dart';
import 'package:ghaf_application/presentation/screens/profile/profile_setting/profile_setting_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/products_with_out_details_seller_view.dart';

import '../../../../app/preferences/shared_pref_controller.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import '../../account_view/account_view_getx_controller.dart';

class ProfileSettingSeller extends StatefulWidget {

  @override
  State<ProfileSettingSeller> createState() => _ProfileSettingSellerState();
}

class _ProfileSettingSellerState extends State<ProfileSettingSeller> {
  // controller.
  late final ProfileSettingGetxController _profileSettingGetxController =
  Get.put(ProfileSettingGetxController());

  late TextEditingController _firstNameTextController;

  late TextEditingController _lastNameTextController;
  late TextEditingController _phoneTextController;

  var language = SharedPrefController().lang1;
  late final AccountViewGetXController _accountViewGetXController =
  Get.put(AccountViewGetXController());

  late final GlobalKey<FormState> formKey = GlobalKey();


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
    if (AppSharedData.currentUser != null) {
      _firstNameTextController.text = AppSharedData.currentUser!.firstName!;
      _lastNameTextController.text = AppSharedData.currentUser!.lastName!;
      _phoneTextController.text = AppSharedData.currentUser!.telephone!;
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(AppSize.s8),
          child: Form(
            key: formKey,
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
                        AppLocalizations.of(context)!.profile_setting,
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s18,
                        ),
                      ),
                      Spacer(),
                      AppSharedData.currentUser == null
                          ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginView(role: 'Customer'),));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: getSemiBoldStyle(
                              color: ColorManager.grey,
                              fontSize: FontSize.s12,
                            ),
                          ))
                          : GestureDetector(
                          onTap: () {
                            _accountViewGetXController.logout(context: context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.logout,
                            style: getSemiBoldStyle(
                              color: ColorManager.grey,
                              fontSize: FontSize.s12,
                            ),
                          )),
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
                    cursorColor: ColorManager.primary,
                    decoration: InputDecoration(
                        label: Text(
                          AppLocalizations.of(context)!.first_name,
                          style: TextStyle(color: ColorManager.greyLight),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return AppLocalizations.of(context)!.first_name_is_required;
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
                    cursorColor: ColorManager.primary,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return AppLocalizations.of(context)!.last_name_is_required;
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
                    cursorColor: ColorManager.primary,
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
                        color: ColorManager.hintTextFiled,
                      ),
                      filled: false,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: AppPadding.p18, horizontal: AppPadding
                          .p4),
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
                            Text('+971', style: TextStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                            // Image.asset(
                            //   ImageAssets.uaeFlag,
                            //   fit: BoxFit.fill,
                            //   height: AppSize.s34,
                            //   width: AppSize.s34,
                            // ),
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
                      else if (value[0] == '0' && (value.length > 10 || value.length < 10)){
                        return AppLocalizations.of(context)!.wrong_phone_number;
                      }

                      else if (value[0] != '0'  && (value.length < 9 || value.length > 9)){

                        return AppLocalizations.of(context)!.wrong_phone_number;
                      }

                      return null;
                    },
                    onSaved: (value) {
                      if(value![0] == '0') {
                        var number = value.substring(1,value.length);
                        _phoneTextController.text = '00971${number}';
                      }else {
                        _phoneTextController.text = '00971${value}';
                      }
                    },
                  ),
                ),


                SizedBox(
                  height: AppSize.s65,
                ),
                Container(
                  width: double.infinity,
                  height: AppSize.s65,
                  padding: EdgeInsets.all(AppSize.s8),
                  child: ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;

                        _profileSettingGetxController.editUserDetailsSeller(
                            context: context,
                            firstName: _firstNameTextController.text,
                            lastName: _lastNameTextController.text,
                            telephone: _phoneTextController.text);
                      },
                      child: Text(AppLocalizations.of(context)!.save)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
