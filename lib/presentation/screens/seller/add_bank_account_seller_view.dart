import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AddBankAccountSellerView extends StatefulWidget {
  const AddBankAccountSellerView({Key? key}) : super(key: key);

  @override
  State<AddBankAccountSellerView> createState() => _AddBankAccountSellerViewState();
}

class _AddBankAccountSellerViewState extends State<AddBankAccountSellerView> with Helpers{
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _phoneTextController;
  late TextEditingController _referralCodeTextController;
  late TextEditingController _boDTextController;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _referralCodeTextController = TextEditingController();
    _boDTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _phoneTextController.dispose();
    _referralCodeTextController.dispose();
    _boDTextController.dispose();
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
                height: AppSize.s22,
              ),
              Text(
                AppLocalizations.of(context)!.add_bank_account,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s24),
              ),
              SizedBox(
                height: AppSize.s58,
              ),
              AppTextField(
                textController: _nameTextController,
                hint: AppLocalizations.of(context)!.swift_code,
              ),
              AppTextField(
                textController: _emailTextController,
                hint: AppLocalizations.of(context)!.account_number,
                textInputType: TextInputType.emailAddress,
              ),

              SizedBox(height: AppSize.s50,),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () => _performRegister(),
                  child: Text(
                    AppLocalizations.of(context)!.confirm,
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

  Future<void> _performRegister() async {
    if (_checkData()) {
      return _register();
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _phoneTextController.text.isNotEmpty &&
        _boDTextController.text.isNotEmpty
    ) {
      return true;
    }
    showSnackBar(context, message: 'Enter Required Data!', error: true);
    return false;
  }

  Future<void> _register() async {
    // ApiResponse apiResponse = await AuthApiController().register(user: user);
    // apiResponse.status==200?
    // Navigator.pop(context):
    // showSnackBar(context, message: apiResponse.message??' ', error: true);
  }

  // User get user {
  //   User user = User();
  //   user.userName = _nameTextController.text;
  //   user.password = _passwordTextController.text;
  //   user.confirmPassword = _passwordTextController.text;
  //   user.firstName = _nameTextController.text; // todo add first and last name on ui
  //   user.lastName = _nameTextController.text;
  //   user.telephone = _phoneTextController.text;
  //   user.role = Constants.roleRegister;
  //   user.email = _emailTextController.text;
  //   user.birthDate = _boDTextController.text;
  //   return user;
  // }

}
