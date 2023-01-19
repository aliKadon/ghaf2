import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class MyWalletView extends StatefulWidget {
  const MyWalletView({Key? key}) : super(key: key);

  @override
  State<MyWalletView> createState() => _MyWalletViewState();
}

class _MyWalletViewState extends State<MyWalletView> {
  var isLoading = true;

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getUnpaidOrder();
    Provider.of<ProductProvider>(context, listen: false)
        .getAllDetailsOrder()
        .then((value) => isLoading = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var completeOrder = Provider.of<ProductProvider>(context).ordersPay;
    var product = Provider.of<ProductProvider>(context).allPointsWallet;
    print('=====================complete');
    print(completeOrder);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          product = 0;
                        });
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.my_wallet,
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
                SizedBox(
                  height: AppSize.s15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p32),
                  child: Stack(
                    children: [
                      Image.asset(
                        ImageAssets.wallet,
                        height: AppSize.s146,
                        width: AppSize.s315,
                        fit: BoxFit.fill,
                      ),
                      PositionedDirectional(
                        top: AppSize.s30,
                        start: AppSize.s30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.balance,
                              style: getMediumStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s16),
                            ),
                            isLoading
                                ? Center(
                                    child: Container(
                                      width: 20.h,
                                      height: 20.h,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      ),
                                    ),
                                  )
                                : Text(
                                    product.toString(),
                                    style: getBoldStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s24),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppSize.s15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        textStyle: getMediumStyle(
                            color: ColorManager.white, fontSize: FontSize.s18),
                        backgroundColor: ColorManager.primaryDark,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.r8))),
                    child: Text(
                      // AppLocalizations.of(context)!.add_balance,
                      AppLocalizations.of(context)!.your_balance,
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s15,
                ),
                Text(
                  'Recent Transactions',
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                SizedBox(
                  height: AppSize.s15,
                ),
                // SizedBox(
                //   height: AppSize.s27,
                // ),
                isLoading
                    ? Center(
                        child: Container(
                          width: 20.h,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      )
                    : completeOrder == null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(AppLocalizations.of(context)!
                                    .no_order_found)),
                          )
                        : completeOrder.length == 0
                            ? Padding(
                                padding: const EdgeInsets.all(100.0),
                                child: Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .no_order_found)),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: completeOrder.length,
                                separatorBuilder: (_, index) => Divider(),
                                itemBuilder: (context, index) {
                                  print(
                                      '+++++++++++++++++++++++++++++++================');
                                  print(completeOrder[index]);
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          leading: Image.asset(
                                              'assets/images/product_image.png',),
                                          title: Text(
                                            completeOrder[index].items![0]
                                                ['name'],

                                            style: getSemiBoldStyle(
                                              color: ColorManager.primary,
                                              fontSize: FontSize.s18,
                                            ),
                                          ),
                                          subtitle: Text(completeOrder[index].deliverdAt?.substring(0,10) ?? '000'),
                                          trailing: Text(
                                            '${completeOrder[index].items![0]['price']} ${completeOrder[index].items![0]['isoCurrencySymbol']}',
                                            style: getSemiBoldStyle(
                                              color: ColorManager.primaryDark,
                                              fontSize: FontSize.s18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                  // : OrderWidget(
                                  // listOrder![index], widget.isOrderTrack);
                                },
                              ),
                // Text(
                //   AppLocalizations.of(context)!.recent_transactions,
                //   style: getSemiBoldStyle(
                //     color: ColorManager.primaryDark,
                //     fontSize: FontSize.s18,
                //   ),
                // ),
                // SizedBox(
                //   height: AppSize.s16,
                // ),
                // RecentTransactions(),
                // RecentTransactions(),
                // RecentTransactions(),
                // RecentTransactions(),
                SizedBox(
                  height: AppSize.s18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
