import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class EditPaymentMethodScreen extends StatefulWidget {
  @override
  State<EditPaymentMethodScreen> createState() =>
      _EditPaymentMethodScreenState();
}

class _EditPaymentMethodScreenState extends State<EditPaymentMethodScreen> {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.find<CheckOutGetxController>();

  var selected = -1;

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getPaymentMethod(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CheckOutGetxController>(
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(top: AppSize.s60, right: AppSize.s12, left: AppSize.s12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.038,
                        width: MediaQuery.of(context).size.width * 0.08,
                        child: Image.asset(
                          SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                          height: AppSize.s18,
                          width: AppSize.s10,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.edit_payment_details,
                      style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppLocalizations.of(context)!.done,
                        style: getSemiBoldStyle(
                          color: ColorManager.greyLight,
                          fontSize: FontSize.s18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(height: 1, color: ColorManager.greyLight),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.017,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.paymentMethod.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Row(
                            children: [
                              selected == index
                                  ? Icon(
                                      Icons.radio_button_checked,
                                      color: ColorManager.primary,
                                    )
                                  : Icon(Icons.radio_button_off,
                                      color: ColorManager.greyLight),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.06,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.all(AppSize.s8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: ColorManager.greyLight,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    _checkOutGetxController
                                                .paymentMethod[index].image ==
                                            null
                                        ? Image.asset(ImageAssets.visa,
                                            height: 55, width: 55)
                                        : Image.network(
                                            _checkOutGetxController
                                                .paymentMethod[index].image!,
                                            height: 55,
                                            width: 55),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.1,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${_checkOutGetxController.paymentMethod[index].brand} xxxx-${_checkOutGetxController.paymentMethod[index].last4Digits}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ],
                    );
                  },
                ),
                InkWell(
                  onTap: () {
                    _checkOutGetxController.deletePaymentMethod(
                        context: context,
                        id: _checkOutGetxController.paymentMethod[selected].id!);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.red,
                        size: 45,
                      ),
                      Text(
                        AppLocalizations.of(context)!.delete,
                        style: getSemiBoldStyle(
                          color: ColorManager.red,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
