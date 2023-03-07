import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/screens/register_view/register_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../../app/preferences/shared_pref_controller.dart';
import '../../../app/preferences/shared_pref_controller.dart';
import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with Helpers {
  // controller.
  late final RegisterViewGetXController _registerViewGetXController =
      Get.find<RegisterViewGetXController>();

  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;

  var userName = '';

  @override
  void initState() {
    Get.put(
      RegisterViewGetXController(
        context: context,
        role: '',
        latitude: 454.7,
        longitude: 878.3,
      ),
    );
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();

    super.initState();
  }
  // dispose.
  @override
  void dispose() {
    Get.delete<RegisterViewGetXController>();
    _nameTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (SharedPrefController().emailGoogle.isNotEmpty && SharedPrefController().userNameGoogle.isNotEmpty) {
      _nameTextController.text = SharedPrefController().userNameGoogle;
      _emailTextController.text = SharedPrefController().emailGoogle;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _registerViewGetXController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppSize.s9,
                ),
                Text(
                  AppLocalizations.of(context)!.getting_started,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s24),
                ),
                SizedBox(
                  height: AppSize.s31,
                ),
                Image.asset(
                  ImageAssets.logo2,
                  fit: BoxFit.fill,
                  height: AppSize.s92,
                  width: AppSize.s92,
                ),
                SizedBox(
                  height: AppSize.s32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        hint: AppLocalizations.of(context)!.first_name,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return AppLocalizations.of(context)!.first_name_is_required;
                          return null;
                        },
                        onSaved: (value) {
                          _registerViewGetXController.firstName = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: AppTextField(
                        hint: AppLocalizations.of(context)!.last_name,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return AppLocalizations.of(context)!.last_name_is_required;
                          return null;
                        },
                        onSaved: (value) {
                          _registerViewGetXController.lastName = value;
                        },
                      ),
                    ),
                  ],
                ),
                 AppTextField(
                   textController: _nameTextController,
                        hint: AppLocalizations.of(context)!.user_name,
                        // hint: SharedPrefController().userNameGoogle,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return AppLocalizations.of(context)!.userName_or_Email_is_required;
                          return null;
                        },
                        onSaved: (value) {
                          print('=========================my value');
                          print(value);
                          if( value == null) {
                            _registerViewGetXController.userName = SharedPrefController().emailGoogle;
                          }else {
                            _registerViewGetXController.userName = value;
                          }
                          print('=================================userName');
                          print(_registerViewGetXController.userName);

                        },
                      ),
                AppTextField(
                  textController: _emailTextController,
                  hint: AppLocalizations.of(context)!.email_address,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppLocalizations.of(context)!.email_address_is_required;
                    return null;
                  },
                  onSaved: (value) {
                    if( value == null) {
                      _registerViewGetXController.email = SharedPrefController().emailGoogle;
                    }else {
                      _registerViewGetXController.email = value;
                    }
                    print('=================================email');
                    print(_registerViewGetXController.email);
                  },
                ),
                AppTextField(
                  hint: AppLocalizations.of(context)!.hint_password,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppLocalizations.of(context)!.password_is_required;
                    return null;
                  },
                  onSaved: (value) {
                    _registerViewGetXController.password = value;
                  },
                ),
                AppTextField(
                  hint: AppLocalizations.of(context)!.confirm_password,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppLocalizations.of(context)!.confirmed_password_is_required;
                    return null;
                  },
                  onSaved: (value) {
                    _registerViewGetXController.confirmPassword = value;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p16,
                  ),
                  child: TextFormField(
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
                        return AppLocalizations.of(context)!.phone_number_is_required;
                      return null;
                    },
                    onSaved: (value) {
                      _registerViewGetXController.telephone = value;
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                Visibility(
                  visible: true,
                  child: AppTextField(
                    hint: AppLocalizations.of(context)!.referral_code,
                    onSaved: (value) {
                      _registerViewGetXController.referralCode = value;
                    },
                  ),
                ),
                AppTextField(
                  textController: _registerViewGetXController
                      .birthDateTextEditingController,
                  onTap: () {
                    _registerViewGetXController.selectBirthDate(
                        context: context);
                  },
                  hint: AppLocalizations.of(context)!.date_of_birth,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppLocalizations.of(context)!.date_of_barth_is_required;
                    return null;
                  },
                  onSaved: (value) {
                    _registerViewGetXController.referralCode = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s55,
                  child: ElevatedButton(
                    onPressed: _registerViewGetXController.register,
                    child: Text(
                      AppLocalizations.of(context)!.sign_up,
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s35,
                ),
                Visibility(
                  visible: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.register_as_a,
                        style: getRegularStyle(
                            color: ColorManager.grey, fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        width: AppSize.s1,
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(
                                context, Routes.welcomeSellerRoute),
                        child: Text(
                          AppLocalizations.of(context)!.seller,
                          style: getExtraBoldStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s16),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, Routes.loginRoute),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.i_already_have_account,
                        style: getRegularStyle(
                            color: ColorManager.grey, fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        width: AppSize.s2,
                      ),
                      Text(
                        AppLocalizations.of(context)!.login,
                        style: getExtraBoldStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s16),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: AppSize.s16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
