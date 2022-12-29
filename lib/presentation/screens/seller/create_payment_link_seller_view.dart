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

class CreatePaymentLinkSellerView extends StatefulWidget {
  const CreatePaymentLinkSellerView({Key? key}) : super(key: key);

  @override
  State<CreatePaymentLinkSellerView> createState() =>
      _CreatePaymentLinkSellerViewState();
}

class _CreatePaymentLinkSellerViewState
    extends State<CreatePaymentLinkSellerView> with Helpers {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.s9,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Text(
                  AppLocalizations.of(context)!.create_payment_link,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s24),
                ),
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Text(
                  AppLocalizations.of(context)!.enter_customer_details,
                  style: getMediumStyle(
                      color: ColorManager.grey, fontSize: FontSize.s18),
                ),
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              AppTextField(
                textController: _nameTextController,
                hint: AppLocalizations.of(context)!.customer_name,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      textController: _passwordTextController,
                      hint: AppLocalizations.of(context)!.payment_amount,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                  ),
                  Expanded(
                    child: AppTextField(
                      textController: _passwordTextController,
                      hint: AppLocalizations.of(context)!.link_expiration_date,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              AppTextField(
                textController: _nameTextController,
                hint: AppLocalizations.of(context)!.description,
                lines: 4,
              ),
              SizedBox(
                height: AppSize.s92,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () => _customDialogProgress(),
                  child: Text(
                    AppLocalizations.of(context)!.create_link,
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
    showSnackBar(context, message: 'Enter Required Data!', error: true);
    return false;
  }

  Future<void> _register() async {}

  void _customDialogProgress() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s410,
              width: AppSize.s343,
              margin: EdgeInsets.symmetric(horizontal: AppPadding.p16),
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
                      AppLocalizations.of(context)!.your_link_is_ready,
                      style: getBoldStyle(
                          color: ColorManager.grey, fontSize: FontSize.s20),
                    ),
                    SizedBox(
                      height: AppSize.s34,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: AppPadding.p16,
                              horizontal: AppPadding.p4),
                          alignment: AlignmentDirectional.centerStart,
                          decoration: BoxDecoration(
                            color: ColorManager.greyLight,
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                          ),
                          child: Text(
                            "2546462465436463",
                            style: getMediumStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s14),
                          ),
                        ),
                        PositionedDirectional(
                          end: 0,
                          child: Container(
                            width: AppSize.s92,
                            padding: EdgeInsets.symmetric(
                                vertical: AppPadding.p12,
                                horizontal: AppPadding.p4),
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.copy,
                              style: getSemiBoldStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s16,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: AppPadding.p12, horizontal: AppPadding.p4),
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        color: ColorManager.greyLight,
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.preview_link,
                        style: getBoldStyle(
                            color: ColorManager.grey, fontSize: FontSize.s16),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s30,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          IconsAssets.whats_up,
                          height: AppSize.s16,
                          width: AppSize.s16,
                        ),
                        SizedBox(
                          width: AppSize.s8,
                        ),
                        Text(
                          AppLocalizations.of(context)!.send_by_whatsapp,
                          style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          IconsAssets.email,
                          height: AppSize.s16,
                          width: AppSize.s16,
                        ),
                        SizedBox(
                          width: AppSize.s8,
                        ),
                        Text(
                          AppLocalizations.of(context)!.send_by_email,
                          style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          IconsAssets.email,
                          height: AppSize.s16,
                          width: AppSize.s16,
                        ),
                        SizedBox(
                          width: AppSize.s8,
                        ),
                        Text(
                          AppLocalizations.of(context)!.use_as_pay_button_on_website,
                          style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          IconsAssets.email,
                          height: AppSize.s16,
                          width: AppSize.s16,
                        ),
                        SizedBox(
                          width: AppSize.s8,
                        ),
                        Text(
                          AppLocalizations.of(context)!.show_qr_code,
                          style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14),
                        ),
                      ],
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
