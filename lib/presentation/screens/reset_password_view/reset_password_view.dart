import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/reset_password_view/reset_password_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ResetPasswordView extends StatefulWidget {
  // const ResetPasswordView({Key? key}) : super(key: key);
  final String role;

  ResetPasswordView({required this.role});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  // controller.
  late final ResetPasswordViewGetXController _resetPasswordViewGetXController =
      Get.find<ResetPasswordViewGetXController>();

  // dispose.
  @override
  void dispose() {
    Get.delete<ResetPasswordViewGetXController>();
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
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.038,
                        width: MediaQuery.of(context).size.width * 0.08,
                        child: Image.asset(
                          IconsAssets.arrow,
                          height: AppSize.s18,
                          width: AppSize.s10,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.reset_password,
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
                height: 150.h,
                width: 150.h,
              ),
              SizedBox(
                height: AppSize.s32,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                child: Text(
                  AppLocalizations.of(context)!.enter_verification_code_email,
                  style: getMediumStyle(
                      color: ColorManager.grey, fontSize: FontSize.s18),
                ),
              ),
              SizedBox(
                height: AppSize.s26,
              ),
              Form(
                key: _resetPasswordViewGetXController.formKey,
                child: Column(
                  children: [
                    AppTextField(
                      hint: AppLocalizations.of(context)!.verification_code,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return AppLocalizations.of(context)!
                              .verification_required;
                        return null;
                      },
                      onSaved: (value) {
                        _resetPasswordViewGetXController.code = value;
                      },
                    ),
                    AppTextField(
                      hint: AppLocalizations.of(context)!.new_password,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return AppLocalizations.of(context)!
                              .new_password_is_required;
                        return null;
                      },
                      onSaved: (value) {
                        _resetPasswordViewGetXController.newPassword = value;
                      },
                    ),
                    AppTextField(
                      hint: AppLocalizations.of(context)!.confirm_password,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return AppLocalizations.of(context)!
                              .confirmed_password_is_required;
                        return null;
                      },
                      onSaved: (value) {
                        _resetPasswordViewGetXController.confirmPassword =
                            value;
                      },
                    ),
                  ],
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
                    _resetPasswordViewGetXController.resetPassword(
                        role: widget.role);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save,
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
