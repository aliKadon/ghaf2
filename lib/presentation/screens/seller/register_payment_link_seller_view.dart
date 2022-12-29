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

class RegisterPaymentLinkSellerView extends StatefulWidget {
  const RegisterPaymentLinkSellerView({Key? key}) : super(key: key);

  @override
  State<RegisterPaymentLinkSellerView> createState() => _RegisterPaymentLinkSellerViewState();
}

class _RegisterPaymentLinkSellerViewState extends State<RegisterPaymentLinkSellerView> with Helpers{
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
                AppLocalizations.of(context)!.sign_up_to_create_account,
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
                width: AppSize.s82,
              ),
              SizedBox(
                height: AppSize.s32,
              ),
              AppTextField(
                textController: _nameTextController,
                hint: AppLocalizations.of(context)!.shop_name,
              ),
              AppTextField(
                textController: _emailTextController,
                hint: AppLocalizations.of(context)!.your_company_email_address,
                textInputType: TextInputType.emailAddress,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p16,
                ),
                child: Row(
                  children: [
                    Container(
                      width: AppSize.s55,
                      height: AppSize.s55,
                      padding: EdgeInsets.all(AppPadding.p10),
                      decoration: BoxDecoration(
                        // color: ColorManager.lightGrey,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(AppRadius.r8),
                          bottomStart: Radius.circular(AppRadius.r8),
                        ),
                        border: Border.all(color: ColorManager.grey),
                      ),
                      child: Image.asset(
                        ImageAssets.uaeFlag,
                        fit: BoxFit.fill,
                        height: AppSize.s34,
                        width: AppSize.s34,
                      ),
                    ),
                    Expanded(
                      child: TextField(
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
                              vertical: AppPadding.p18,
                              horizontal: AppPadding.p4),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(AppRadius.r10),
                                bottomRight: Radius.circular(AppRadius.r10)),
                            borderSide: BorderSide(
                              width: AppSize.s1,
                              color: ColorManager.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(AppRadius.r10),
                                bottomRight: Radius.circular(AppRadius.r10)),
                            borderSide: BorderSide(
                              width: AppSize.s1,
                              color: ColorManager.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              Visibility(
                visible: true,
                child: AppTextField(
                  textController: _referralCodeTextController,
                  hint: AppLocalizations.of(context)!.company_name,
                ),
              ),
              AppTextField(
                textController: _boDTextController,
                hint: AppLocalizations.of(context)!.business_sector,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.datetime,
                // onSubmitted: (){},
              ),  AppTextField(
                textController: _boDTextController,
                hint: AppLocalizations.of(context)!.corporate_business,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.datetime,
                // onSubmitted: (){},
              ),
              AppTextField(
                textController: _passwordTextController,
                hint: AppLocalizations.of(context)!.hint_password,
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.i_agree_to_the_terms_of_service,
                      style: getRegularStyle(
                          color: ColorManager.grey, fontSize: FontSize.s16),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () => _performRegister(),
                  child: Text(
                    AppLocalizations.of(context)!.sign_up,
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
