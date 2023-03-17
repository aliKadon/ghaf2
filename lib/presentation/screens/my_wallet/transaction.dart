import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/add_credit_screen.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/my_wallet_new.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/top_up_screen.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/wallet_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/transaction_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../resources/assets_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {

  late final WalletGetxController _walletGetxController = Get.find<WalletGetxController>();

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                      builder: (context) => MyWalletNew(),
                    ));
                  },
                  child: Image.asset(
                    IconsAssets.arrow,
                    height: AppSize.s18,
                    width: AppSize.s10,
                    color: ColorManager.primaryDark,
                  ),
                ),
              ),
              Spacer(),
              Text(
                AppLocalizations.of(context)!.transaction,
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
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: AppSize.s222,
                color: ColorManager.grey.withOpacity(0.2),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available credit',
                      style: getRegularStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    Text(
                      'AED ${_walletGetxController.balance}',
                      style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TopUpScreen(screenName: 'topUp'),));
                            },
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    IconsAssets.top_up,
                                    height: AppSize.s55,
                                    width: AppSize.s55,
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.s4,
                                ),
                                Text(
                                  'Top up',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddCreditScreen(),));
                            },
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    IconsAssets.add_credit,
                                    height: AppSize.s55,
                                    width: AppSize.s55,
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.s4,
                                ),
                                Text(
                                  'Add Credit',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TopUpScreen(screenName: 'manage'),));
                            },
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    IconsAssets.manage,
                                    height: AppSize.s55,
                                    width: AppSize.s55,
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.s4,
                                ),
                                Text(
                                  'Manage',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSize.s36,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  'October 2022',
                  style: getRegularStyle(
                    color: ColorManager.grey,
                    fontSize: FontSize.s18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.4,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, data) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TransactionWidget(),
                      Divider(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
