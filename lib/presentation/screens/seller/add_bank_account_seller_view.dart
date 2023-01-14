import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AddBankAccountSellerView extends StatefulWidget {
  const AddBankAccountSellerView({Key? key}) : super(key: key);

  @override
  State<AddBankAccountSellerView> createState() =>
      _AddBankAccountSellerViewState();
}

class _AddBankAccountSellerViewState extends State<AddBankAccountSellerView>
    with Helpers {
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
    var repo = Provider.of<SellerProvider>(context).repo;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.s22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: () => Navigator.pop(context),
                  //   child: Image.asset(
                  //     IconsAssets.arrow,
                  //     height: AppSize.s18,
                  //     width: AppSize.s10,
                  //   ),
                  // ),
                  // Spacer(),
                  Text(
                    AppLocalizations.of(context)!.add_bank_account,
                    style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s24),
                  ),
                  // Spacer(),
                ],
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
              AppTextField(
                textController: _passwordTextController,
                hint: AppLocalizations.of(context)!.name,
                textInputType: TextInputType.name,
              ),
              AppTextField(
                textController: _phoneTextController,
                hint: AppLocalizations.of(context)!.bank_name,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: AppSize.s50,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_checkData()) {
                      showLoadingDialog(context: context, title: 'Loading');
                      Provider.of<SellerProvider>(context, listen: false)
                          .addBankInfo(
                              context,
                              _nameTextController.text,
                              _emailTextController.text,
                              _passwordTextController.text,
                              _phoneTextController.text)
                          .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(repo),
                                backgroundColor: Colors.green,
                              )))
                          .then((value) => Navigator.of(context).pushNamed(
                              Routes.mainSellerRoute))
                          .catchError((e) => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(repo))));
                    }
                  },
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
        _phoneTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: AppLocalizations.of(context)!.enter_required_data, error: true);
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
