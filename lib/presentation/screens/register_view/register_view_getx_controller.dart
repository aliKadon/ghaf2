import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/auth_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/user.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class RegisterViewGetXController extends GetxController with Helpers {
  // constructor fields.
  final BuildContext context;
  String role;
  double latitude=24.400661;
  double longitude= 54.635448;
  // constructor.
  RegisterViewGetXController(
      {
    required this.context,
    required this.role,
    required this.latitude,
    required this.longitude,
  });

  // vars.
  late final AuthApiController _authApiController = AuthApiController();
  late final GlobalKey<FormState> formKey = GlobalKey();
  late final TextEditingController birthDateTextEditingController =
      TextEditingController();

  // fields.
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? password;
  String? confirmPassword;
  String? telephone;
  String? referralCode;
  String? birthDate;

  // register.
  void register() async {
    try {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      showLoadingDialog(context: context, title: 'Registering');
      final User user = User(
        userName: userName,
        firstName: firstName,
        lastName: lastName,
        email: email,
        referralCode: referralCode,
        role: role,
        password: password,
        confirmPassword: confirmPassword,
        birthDate: birthDate,
        telephone: telephone,
      );
      final ApiResponse apiResponse =
          await _authApiController.register(user: user);
      if (apiResponse.status == 200) {
        // success.
        showSnackBar(context, message: apiResponse.message, error: false);
        Navigator.pop(context);
        _customDialogProgress();
        // Navigator.of(context).pushReplacementNamed(Routes.verifiedEmail);
        // if (role == Constants.roleRegisterCustomer ||role == Constants.roleRegisterIndividual ) Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
        // if (role == Constants.roleRegisterSeller) Navigator.of(context).pushReplacementNamed(Routes.submitForm ,arguments: {
        //   'locationLat': latitude,
        //   'locationLong': longitude,
        // });
      } else {
        // failed.
        Navigator.pop(context);
        showSnackBar(context, message: apiResponse.message, error: true);
      }
    } catch (error) {
      // error.
      Navigator.pop(context);
      showSnackBar(context, message: 'An Error Occurred, Please Try again', error: true);
    }
  }
  void _customDialogProgress() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s306,
              width: AppSize.s306,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.must_verify,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.check_your_email,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.red,
                            fontSize: FontSize.s16),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
                      },
                      child: Container(
                        width: AppSize.s110,
                        height: AppSize.s38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryDark,
                          borderRadius:
                          BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          'Ok',
                          textAlign: TextAlign.center,
                          style:
                          getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }
  // select birth date.
  void selectBirthDate({
    required BuildContext context,
  }) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: birthDate == null
          ? DateTime(DateTime.now().year - 15)
          : DateTime.parse(birthDate!),
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime(DateTime.now().year - 15),
    );
    if (date == null) return;
    birthDate = Helpers.formatDate(date);
    birthDateTextEditingController.text = birthDate!;
  }
}
