import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/auth_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/domain/model/user.dart';

class RegisterViewGetXController extends GetxController with Helpers {
  // constructor fields.
  final BuildContext context;
  String role;

  // constructor.
  RegisterViewGetXController({
    required this.context,
    required this.role,
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
        Navigator.pop(context);
        if (role == Constants.roleRegisterSeller) Navigator.pop(context);
      } else {
        // failed.
        Navigator.pop(context);
        showSnackBar(context, message: apiResponse.message, error: true);
      }
    } catch (error) {
      // error.
      Navigator.pop(context);
      showSnackBar(context, message: error.toString(), error: true);
    }
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
