import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/transaction.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/wallet_getx_controller.dart';

import '../../resources/assets_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class MyWalletNew extends StatefulWidget {
  const MyWalletNew({Key? key}) : super(key: key);

  @override
  State<MyWalletNew> createState() => _MyWalletNewState();
}

class _MyWalletNewState extends State<MyWalletNew> {
  //controller
  late final WalletGetxController _walletGetxController =
      Get.put(WalletGetxController());

  @override
  void initState() {
    // TODO: implement initState
    _walletGetxController.getMyWalletBalance(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                color: ColorManager.primaryDark,
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(AppSize.s6),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => MainView(),
                            ));
                          },
                          child: Image.asset(
                            IconsAssets.arrow,
                            height: AppSize.s18,
                            width: AppSize.s10,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        AppLocalizations.of(context)!.my_wallet,
                        style: getSemiBoldStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s18,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            ImageAssets.logo_wallet,
                            height: AppSize.s55,
                            width: AppSize.s55,
                          ),
                        ),
                        SizedBox(
                          width: AppSize.s6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.total_credit_available}',
                              style: getRegularStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            GetBuilder<WalletGetxController>(
                              builder: (controller) =>  Text(
                                '${_walletGetxController.balance} ${AppLocalizations.of(context)!.aed}',
                                style: getSemiBoldStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: AppSize.s18,
          ),
          Text(
            '${AppLocalizations.of(context)!.credit_available}',
            style: getSemiBoldStyle(
              color: ColorManager.primaryDark,
              fontSize: FontSize.s16,
            ),
          ),
          SizedBox(
            height: AppSize.s30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  '${AppLocalizations.of(context)!.credit_available}',
                  style: getSemiBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s16,
                  ),
                ),
                Spacer(),
                GetBuilder<WalletGetxController>(
                  builder: (controller) =>  Text(
                    '${_walletGetxController.balance} ${AppLocalizations.of(context)!.aed}',
                    style: getSemiBoldStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: AppSize.s306,
            height: AppSize.s44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => TransactionScreen()));
              },
              child: Text(
                '${AppLocalizations.of(context)!.transaction}',
                style: getSemiBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: AppSize.s130,
          ),
        ],
      ),
    );
  }
}
