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

class CreatePaymentLink2SellerView extends StatefulWidget {
  const CreatePaymentLink2SellerView({Key? key}) : super(key: key);

  @override
  State<CreatePaymentLink2SellerView> createState() =>
      _CreatePaymentLink2SellerViewState();
}

class _CreatePaymentLink2SellerViewState
    extends State<CreatePaymentLink2SellerView> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.s9,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Row(
                children: [
                  Image.asset(
                    IconsAssets.arrow,
                    height: AppSize.s24,
                    width: AppSize.s24,
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.create_payment_link,
                    style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s24),
                  ),
                  Spacer(),
                  Image.asset(
                    IconsAssets.plus3,
                    height: AppSize.s24,
                    width: AppSize.s24,
                  ),
                ],
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
              height: AppSize.s2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Row(
                children: [
                  Text(
                    'AED 1.22',
                    style: getSemiBoldStyle(
                        color: ColorManager.primary, fontSize: FontSize.s16),
                  ),
                  Spacer(),
                  Text(
                    '12-12-2020',
                    style: getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            Spacer(),
            SizedBox(
              height: AppSize.s20,
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
              height: AppSize.s73,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.subtotal,
                    style: getSemiBoldStyle(
                        color: ColorManager.grey, fontSize: FontSize.s16),
                  ),
                  Spacer(),
                  Text(
                    'AED 1.22',
                    style: getSemiBoldStyle(
                        color: ColorManager.grey, fontSize: FontSize.s16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
          ],
        ),
      ),
    );
  }

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
                          AppLocalizations.of(context)!
                              .use_as_pay_button_on_website,
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
