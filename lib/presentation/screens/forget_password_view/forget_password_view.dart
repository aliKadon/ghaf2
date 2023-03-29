import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/forget_password_view/forgot_password_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ForgetPasswordView extends StatefulWidget {
  // const ForgetPasswordView({Key? key}) : super(key: key);
  final String role;
  ForgetPasswordView({required this.role});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  // controller.
  late final ForgotPasswordViewGetXController
      _forgotPasswordViewGetXController =
      Get.find<ForgotPasswordViewGetXController>();

  // dispose.
  @override
  void dispose() {
    Get.delete<ForgotPasswordViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSize.s9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.forget_password,
                    style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s24),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: AppSize.s31,
              ),
              Image.asset(
                ImageAssets.forgetPassword,
                fit: BoxFit.fill,
                height: AppSize.s207,
                width: AppSize.s311,
              ),
              SizedBox(
                height: AppSize.s32,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                child: Text(
                  AppLocalizations.of(context)!
                      .to_reset_your_password_please_enter,
                  style: getMediumStyle(
                      color: ColorManager.grey, fontSize: FontSize.s18),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p32,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.your,
                      style: getMediumStyle(
                          color: ColorManager.grey, fontSize: FontSize.s16),
                    ),
                    SizedBox(
                      width: AppSize.s2,
                    ),
                    Text(
                      AppLocalizations.of(context)!.email_address,
                      style: getMediumStyle(
                          color: ColorManager.primary, fontSize: FontSize.s16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s26,
              ),
              Form(
                key: _forgotPasswordViewGetXController.formKey,
                child: AppTextField(
                  hint: AppLocalizations.of(context)!.hint_email_phone,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      // return 'Email address is required';
                      return AppLocalizations.of(context)!.email_address_is_required;
                    return null;
                  },
                  onSaved: (value) {
                    _forgotPasswordViewGetXController.email = value;
                  },
                ),
              ),
              SizedBox(
                height: AppSize.s10,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () {
                    _forgotPasswordViewGetXController.forgotPassword(role: widget.role);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.send,
                    style: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s18),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
