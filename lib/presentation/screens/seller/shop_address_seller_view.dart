import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:provider/provider.dart';

import '../../../providers/seller_provider.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ShopAddressSellerView extends StatefulWidget {
  // const ShopAddressSellerView({Key? key}) : super(key: key);

  Map<String, dynamic> info;

  ShopAddressSellerView(this.info);

  @override
  State<ShopAddressSellerView> createState() => _ShopAddressSellerViewState();
}

class _ShopAddressSellerViewState extends State<ShopAddressSellerView>
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSize.s22,
              ),
              Text(
                AppLocalizations.of(context)!.shop_address,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s24),
              ),
              SizedBox(
                height: AppSize.s58,
              ),
              AppTextField(
                textController: _nameTextController,
                hint: AppLocalizations.of(context)!.country,
              ),
              AppTextField(
                textController: _emailTextController,
                hint: AppLocalizations.of(context)!.city,
                textInputType: TextInputType.emailAddress,
              ),
              AppTextField(
                textController: _boDTextController,
                hint: AppLocalizations.of(context)!.address,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.datetime,
                // onSubmitted: (){},
              ),
              AppTextField(
                textController: _passwordTextController,
                hint: AppLocalizations.of(context)!.postal_code,
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
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
                          .submitIndividualForm(
                              context,
                              widget.info['storeName'],
                              widget.info['email'],
                              widget.info['phoneNumber'],
                              widget.info['companyName'],
                              widget.info['businessType'],
                              widget.info['businessSector'],
                              _nameTextController.text,
                              _emailTextController.text,
                              _boDTextController.text,
                              _passwordTextController.text)
                          // .then((value) => ScaffoldMessenger.of(context)
                          //         .showSnackBar(SnackBar(
                          //       content: Text(repo),
                          //       backgroundColor: Colors.green,
                          //     )))
                          .then((value) => Navigator.of(context)
                              .pushReplacementNamed(Routes.addBankAccountSellerRoute))
                          .catchError((e) => ScaffoldMessenger.of(context)
                              .showSnackBar(
                                  SnackBar(content: Text(repo))));
                    }
                    // _performRegister();

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
        _boDTextController.text.isNotEmpty) {
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
