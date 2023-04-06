import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/top_up_screen.dart';
import 'package:ghaf_application/presentation/screens/pay_later/pay_later_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/pay_later/pay_later_view_new.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class PayLaterProductView extends StatefulWidget {
  String? id;
  int? index;
  String? cardNumber;
  String? paymentMethodId;

  PayLaterProductView(
      {this.index, this.cardNumber, this.paymentMethodId, this.id});

  @override
  State<PayLaterProductView> createState() => _PayLaterProductViewState();
}

class _PayLaterProductViewState extends State<PayLaterProductView>
    with Helpers {
  //controller
  final PayLaterGetxController _payLaterGetxController =
      Get.find<PayLaterGetxController>();

  @override
  void initState() {
    // TODO: implement initState
    _payLaterGetxController.getCustomerInstallments(
        context: context, id: widget.id ?? SharedPrefController().idPayLater);
    if (widget.id != null) {
      SharedPrefController().setIdPayLaterProduct(widget.id!);
    }
    SharedPrefController().setIndexOfPayLaterProduct(widget.index!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PayLaterGetxController>(
        builder: (controller) => controller.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => PayLaterViewNew(),
                            )),
                            child: Image.asset(
                              IconsAssets.arrow,
                              height: AppSize.s18,
                              width: AppSize.s10,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          AppLocalizations.of(context)!.pay_later,
                          style: getSemiBoldStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    Divider(height: 1, color: ColorManager.greyLight),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          controller.payLaterInstallments[0]
                                      .productForThisOperation!.productImages ==
                                  0
                              ? Container(
                                  width: AppSize.s75,
                                  height: AppSize.s92,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // color: Colors.green,
                                      image: DecorationImage(
                                          image: AssetImage(
                                            ImageAssets.pizza,
                                          ),
                                          fit: BoxFit.fill)),
                                )
                              : Container(
                                  width: AppSize.s75,
                                  height: AppSize.s92,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // color: Colors.green,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            controller
                                                .payLaterInstallments[0]
                                                .productForThisOperation!
                                                .productImages![0],
                                          ),
                                          fit: BoxFit.scaleDown)),
                                ),
                          SizedBox(
                            width: AppSize.s12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${controller.payLaterInstallments[0].productForThisOperation!.name!}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s14),
                              ),
                              Text(
                                'item ${controller.payLaterInstallments[0].quantityItem}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.greyLight,
                                    fontSize: FontSize.s14),
                              ),
                              SizedBox(
                                height: AppSize.s12,
                              ),
                              Text(
                                '${controller.payLaterInstallments[0!].productForThisOperation!.price} ${controller.payLaterInstallments[0!].productForThisOperation!.isoCurrencySymbol}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.the_amount_required,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s18),
                        ),
                        Spacer(),
                        Text(
                          '${controller.payLaterInstallments[0].balance} ${controller.payLaterInstallments[0].productForThisOperation!.isoCurrencySymbol!}',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.number_of_installments,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s14),
                        ),
                        Spacer(),
                        Text(
                          '${controller.payLaterInstallments[0].totalInstallment}',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.018,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .date_of_first_installment,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s14),
                        ),
                        Spacer(),
                        Text(
                          '${controller.payLaterInstallments[0].installmentDate!.substring(0, 10)}',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.018,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .period_between_installments,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s14),
                        ),
                        Spacer(),
                        Text(
                          '20 days',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.018,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.due_date,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s14),
                        ),
                        Spacer(),
                        Text(
                          '${controller.payLaterInstallments[controller.payLaterInstallments.length - 1].installmentDate!.substring(0, 10)}',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.018,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.installment_price,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s14),
                        ),
                        Spacer(),
                        Text(
                          '${(controller.payLaterInstallments[0].balance!) / (int.parse(controller.payLaterInstallments[0].totalInstallment!))} ${controller.payLaterInstallments[0].productForThisOperation!.isoCurrencySymbol!}',
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    Text(AppLocalizations.of(context)!.payment_method,
                        style: TextStyle(
                            color: ColorManager.primaryDark,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.s16)),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    Container(
                      height: AppSize.s58,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.white,
                          border: Border.all(color: ColorManager.greyLight)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                TopUpScreen(screenName: 'payLater'),
                          ));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: AppSize.s20,
                            ),
                            Text(
                                widget.cardNumber == null
                                    ? AppLocalizations.of(context)!
                                        .select_the_payment_method
                                    : 'card : **** **** **** ${widget.cardNumber}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 13)),
                            // SizedBox(width: AppSize.s20,),
                            Spacer(),
                            Icon(
                              Icons.arrow_drop_down_circle_rounded,
                              color: ColorManager.primaryDark,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Container(
                      width: double.infinity,
                      height: AppSize.s50,
                      child: ElevatedButton(
                          onPressed: () {
                            if (widget.paymentMethodId == null) {
                              showSnackBar(context,
                                  message: AppLocalizations.of(context)!
                                      .please_select_payment_method);
                            } else {
                              controller.payForInstallments(
                                  context: context,
                                  productId:
                                      controller.payLaterInstallments[0!].id!,
                                  paymentMethodId: widget.paymentMethodId!);
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.next)),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
