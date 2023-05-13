import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/subscribe_view_from_home_page.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../checkout/check_out_getx_controller.dart';
import '../profile/profile_setting/profile_setting_getx_controller.dart';

class PaymentViewForSubscribeNew extends StatefulWidget {
  @override
  State<PaymentViewForSubscribeNew> createState() =>
      _PaymentViewForSubscribeNewState();
}

class _PaymentViewForSubscribeNewState
    extends State<PaymentViewForSubscribeNew> {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.find<CheckOutGetxController>();
  late final ProfileSettingGetxController _profileGetxController =
      Get.find<ProfileSettingGetxController>();

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getPaymentMethod(context: context);
    // _checkOutGetxController.getPromoCode(context: context,status: -1);
    // _profileGetxController.init(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSize.s12),
        child: Column(
          children: [
            SizedBox(height: AppSize.s30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
                  AppLocalizations.of(context)!.payment_method,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Divider(thickness: 1, color: ColorManager.greyLight),
            GetBuilder<CheckOutGetxController>(
              builder: (controller) => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.paymentMethod.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          _checkOutGetxController.deletePaymentMethod(
                              context: context,
                              id: _checkOutGetxController
                                  .paymentMethod[index].id!);
                          // cubit.deletePaymentMethod(
                          //     id: cubit
                          //         .getPaymentMethods[index]
                          //         .id!,
                          //     context: context);
                        },
                        background: Container(
                          color: Colors.red,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => SubscribeViewFromHomePage(
                                    last4DigitNumber: _checkOutGetxController
                                        .paymentMethod[index].last4Digits),
                              ));
                            },
                            child: Container(
                              width: double.infinity,
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
                                            '**** **** **** **** ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            _checkOutGetxController
                                                .paymentMethod[index]
                                                .last4Digits!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${AppLocalizations.of(context)!.expiry_date} ${_checkOutGetxController.paymentMethod[index].expMonth}\\${_checkOutGetxController.paymentMethod[index].expYear}',
                                        style: getSemiBoldStyle(
                                          color: ColorManager.greyLight,
                                          fontSize: FontSize.s12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.017,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
