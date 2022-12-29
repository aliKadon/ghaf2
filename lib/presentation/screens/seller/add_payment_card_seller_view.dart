import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import '../../../data/api/controllers/auth_api_controller.dart';
import '../../../domain/model/api_response.dart';
import '../../../domain/model/user.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AddPaymentCardSellerView extends StatefulWidget {
  const AddPaymentCardSellerView({Key? key}) : super(key: key);

  @override
  State<AddPaymentCardSellerView> createState() => _AddPaymentCardSellerViewState();
}

class _AddPaymentCardSellerViewState extends State<AddPaymentCardSellerView> with Helpers{
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _phoneTextController;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _phoneTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _phoneTextController.dispose();
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
              Text(
                AppLocalizations.of(context)!.add_payment_card,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s24),
              ),
              SizedBox(
                height: AppSize.s55,
              ),
              Text(
                AppLocalizations.of(context)!.to_complete_the_store_registration,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s24),
              ),
              SizedBox(
                height: AppSize.s82,
              ),
              AppTextField(
                textController: _nameTextController,
                hint: AppLocalizations.of(context)!.store_name,
              ),

              AppTextField(
                textController: _emailTextController,
                hint: AppLocalizations.of(context)!.website,
                textInputType: TextInputType.emailAddress,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      textController: _passwordTextController,
                      hint: AppLocalizations.of(context)!.social_media_account,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                  ),
                  Expanded(
                    child: AppTextField(
                      textController: _passwordTextController,
                      hint: AppLocalizations.of(context)!.social_media_account,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSize.s92,),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () => _customDialogProgress(),
                  child: Text(
                    AppLocalizations.of(context)!.create_store,
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
        _phoneTextController.text.isNotEmpty
    ) {
      return true;
    }
    showSnackBar(context, message: 'Enter Required Data!', error: true);
    return false;
  }

  Future<void> _register() async {

  }

  void _customDialogProgress() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s214,
              width: AppSize.s258,
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
                    Text(
                      AppLocalizations.of(context)!.progress,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s20),
                    ),
                    SizedBox(
                      height: AppSize.s40,
                    ),
                    Text(
                      AppLocalizations.of(context)!.your_account_is_under_approval_process,
                      style: getMediumStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s12),
                    ),
                    SizedBox(
                      height: AppSize.s40,
                    ),
                    GestureDetector(
                      onTap: ()=>Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p55,
                          vertical: AppPadding.p8,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryDark,
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.close,
                          style: getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                  ]),
            ),
          );
        });
  }



}
