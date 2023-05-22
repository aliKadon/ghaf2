import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/enter_amount.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/transaction.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/top_up_widget.dart';
import '../checkout/snapsheet_screen.dart';

class AddCreditScreen extends StatefulWidget {
  @override
  State<AddCreditScreen> createState() => _AddCreditScreenState();
}

class _AddCreditScreenState extends State<AddCreditScreen> {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());

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
        builder: (controller) => Column(
          children: [
            SizedBox(
              height: AppSize.s32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSize.s6),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => TransactionScreen(),
                      ));
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
                ),
                Spacer(),
                Text(
                  AppLocalizations.of(context)!.add_credit1,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: AppSize.s16,
            ),
            Divider(
              thickness: 1,
              color: ColorManager.greyLight,
            ),
            _checkOutGetxController.paymentMethod == 0
                ? Column(
                    children: [
                      SizedBox(
                        height: AppSize.s154,
                      ),
                      Image.asset(
                        ImageAssets.topUP,
                        height: AppSize.s192,
                      ),
                      SizedBox(
                        height: AppSize.s30,
                      ),
                      Text(
                        AppLocalizations.of(context)!.add_credit,
                      ),
                      SizedBox(
                        height: AppSize.s14,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                SnapsheetScreen(lastScreen: 'addCredit'),
                          ));
                        },
                        child: Text(
                          '+ ${AppLocalizations.of(context)!.add_new_card}',
                          style: TextStyle(
                              color: ColorManager.primary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _checkOutGetxController.paymentMethod.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => EnterAmount(
                                    typeOfPage: 0,
                                    paymentMethodId: _checkOutGetxController
                                        .paymentMethod[index].id!),
                              ));
                            },
                            child: TopUpWidget(
                              imageUrl: _checkOutGetxController
                                  .paymentMethod[index].image!,
                              cardType: _checkOutGetxController
                                  .paymentMethod[index].brand!,
                              last4digitNumber: _checkOutGetxController
                                  .paymentMethod[index].last4Digits!,
                            ),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                SnapsheetScreen(lastScreen: 'addCredit'),
                          ));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(AppSize.s8),
                              child: Text(
                                '${AppLocalizations.of(context)!.add_new_card}',
                                style: TextStyle(
                                    color: ColorManager.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.s16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
