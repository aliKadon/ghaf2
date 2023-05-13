import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';

import '../../../../app/preferences/shared_pref_controller.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../account_view/account_view_getx_controller.dart';
import '../../main_view.dart';

class PaymentLinkSubscriptionSellerView extends StatefulWidget {
  const PaymentLinkSubscriptionSellerView({Key? key}) : super(key: key);

  @override
  State<PaymentLinkSubscriptionSellerView> createState() =>
      _PaymentLinkSubscriptionSellerViewState();
}

class _PaymentLinkSubscriptionSellerViewState
    extends State<PaymentLinkSubscriptionSellerView> {
  late final AccountViewGetXController _accountViewGetXController =
  Get.put(AccountViewGetXController());
  var option = '';
  var planId = '';
  var isLoading = true;

  // @override
  // void initState() {
  //   Provider.of<SellerProvider>(context,listen: false).getPlanForSellerIndividual().then((value) => isLoading = false);
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    Provider.of<SellerProvider>(context)
        .getPlanForSellerIndividual()
        .then((value) => isLoading = false);
    super.didChangeDependencies();
  }

  bool monthly = true;

  var option1 = '';
  var Agree = false;
  var Agree1 = false;

  @override
  Widget build(BuildContext context) {
    var plane = Provider
        .of<SellerProvider>(context)
        .planSellerIndividual;
    // var repo = Provider.of<SellerProvider>(context).repo;

    return WillPopScope(
      onWillPop: () async {
        await SharedPrefController().logout();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainView(),
        ));
        return false;
      },
      child: Scaffold(
        body: isLoading
            ? Center(
          child: Container(
            width: 20.h,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
        )
            : SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: ListView(
              children: [
                SizedBox(
                  height: AppSize.s28,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!
                        .payment_link_solution_subscription1,
                    style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s20),
                  ),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.home_business,
                    style: TextStyle(
                        fontSize: FontSize.s20,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.primaryDark),
                  ),
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Card(
                  elevation: 2,
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.63,
                    padding: EdgeInsets.all(AppPadding.p12),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(AppRadius.r8),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [
                        // SizedBox(
                        //   height: AppSize.s15,
                        // ),
                        // monthly
                        //     ? Row(
                        //         children: [
                        //           Spacer(),
                        //           Text(
                        //             '${plane[0].priceAmount} ${plane[0].priceCurrency}',
                        //             textAlign: TextAlign.center,
                        //             style: getMediumStyle(
                        //                 color: ColorManager.primaryDark,
                        //                 fontSize: FontSize.s20),
                        //           ),
                        //         ],
                        //       )
                        //     : Row(
                        //         children: [
                        //           Spacer(),
                        //           Text(
                        //             '${plane[1].priceAmount} ${plane[1].priceCurrency}',
                        //             textAlign: TextAlign.center,
                        //             style: getMediumStyle(
                        //                 color: ColorManager.primaryDark,
                        //                 fontSize: FontSize.s20),
                        //           ),
                        //         ],
                        //       ),
                        // SizedBox(
                        //   height: AppSize.s60,
                        // ),
                        Padding(
                          padding: EdgeInsets.only(bottom: AppPadding.p8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: AppRadius.r8,
                                backgroundColor: ColorManager.primary,
                              ),
                              SizedBox(
                                width: AppSize.s12,
                              ),
                              Expanded(
                                child: Text(
                                  '${AppLocalizations.of(context)!
                                      .monthly_plane} ${plane[0]
                                      .priceAmount} ${plane[0]
                                      .priceCurrency} ${AppLocalizations.of(
                                      context)!.every_month}'
                                      '${AppLocalizations.of(context)!
                                      .and_have} ${plane[0]
                                      .freeDays} ${AppLocalizations.of(context)!
                                      .free_days}',
                                  textAlign: TextAlign.start,
                                  style: getMediumStyle(
                                      color: ColorManager.primaryDark,
                                      fontSize: FontSize.s16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppSize.s12,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: AppPadding.p8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: AppRadius.r8,
                                backgroundColor: ColorManager.primary,
                              ),
                              SizedBox(
                                width: AppSize.s12,
                              ),
                              Expanded(
                                child: Text(
                                  '${AppLocalizations.of(context)!
                                      .annual_plane} ${plane[1]
                                      .priceAmount} ${plane[1]
                                      .priceCurrency} ${AppLocalizations.of(
                                      context)!.every_month}'
                                      '${AppLocalizations.of(context)!
                                      .and_have} ${plane[1]
                                      .freeDays} ${AppLocalizations.of(context)!
                                      .free_days}',
                                  textAlign: TextAlign.start,
                                  style: getMediumStyle(
                                      color: ColorManager.primaryDark,
                                      fontSize: FontSize.s16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppSize.s50,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: AppPadding.p8),
                          child: Row(
                            children: [
                              GestureDetector(
                                // onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: EdgeInsets.all(AppSize.s12),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(AppRadius.r12),
                                      border: Border.all(
                                          color: ColorManager.greyLight)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Radio(
                                          activeColor: ColorManager.primary,
                                          value: 'Monthly',
                                          onChanged: (n) {
                                            setState(() {
                                              monthly = true;
                                              Agree1 = true;
                                              // Agree = !Agree;
                                              planId = plane[0].id!;
                                              option = n!;
                                            });
                                            print(
                                                '--------------------------------monthly');
                                            print(option);
                                          },
                                          groupValue: option),
                                      Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .monthly,
                                            style: getRegularStyle(
                                                color: ColorManager.primaryDark,
                                                fontSize: FontSize.s16),
                                          ),
                                          SizedBox(height: AppSize.s8,),
                                          Text(
                                            '${plane[0].priceAmount} ${plane[0]
                                                .priceCurrency}',
                                            textAlign: TextAlign.end,
                                            style: getMediumStyle(
                                                color: ColorManager.primary,
                                                fontSize: FontSize.s16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: AppSize.s22,
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: GestureDetector(
                                  // onTap: () => Navigator.pop(context),
                                  child: Container(
                                    padding: EdgeInsets.all(AppSize.s8),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(AppRadius.r12),
                                        border: Border.all(
                                            color: ColorManager.greyLight)),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Radio(
                                            activeColor:
                                            ColorManager.primary,
                                            value: 'Annual',
                                            onChanged: (n) {
                                              setState(() {
                                                monthly = false;
                                                Agree1 = true;
                                                planId = plane[1].id!;
                                                option = n!;
                                              });
                                              print(
                                                  '--${monthly}------------------------------annual');
                                              print(option);
                                            },
                                            groupValue: option),
                                        Column(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .annual,
                                              style: getRegularStyle(
                                                  color:
                                                  ColorManager.primaryDark,
                                                  fontSize: FontSize.s16),
                                            ),
                                            SizedBox(height: AppSize.s8,),
                                            Text(
                                              '${plane[1].priceAmount} ${plane[1]
                                                  .priceCurrency}',
                                              textAlign: TextAlign.end,
                                              style: getMediumStyle(
                                                  color: ColorManager.primary,
                                                  fontSize: FontSize.s16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppSize.s43,
                        ),
                        Text(AppLocalizations.of(context)!.you_can_cancel_anytime,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: ColorManager.primaryDark,
                              fontSize: FontSize.s14,
                              fontWeight: FontWeight.w500),),
                        SizedBox(
                          height: AppSize.s14,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: AppMargin.m50,
                          ),
                          width: double.infinity,
                          height: AppSize.s55,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    ColorManager.primaryDark)),
                            onPressed: () =>
                            Agree && Agree1
                                ? Navigator.of(context).pushReplacementNamed(
                                Routes.addPaymentCardSelleRoute,
                                arguments: planId)
                                : ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text(
                                  "Please Choose All The Options"),
                              backgroundColor: Colors.red,
                            )),

                            // {
                            //   _customDialogSubscriptionSeller(context);
                            // },
                            //onPressed: () => Agree && Agree1 ? Navigator.of(context).pushNamed(Routes.addPaymentCardSelleRoute , arguments: planId ) : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Choose All The Options"),backgroundColor: Colors.red,)),
                            child: Text(
                              AppLocalizations.of(context)!.subscribe_now,
                              style: getSemiBoldStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppSize.s10,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery
                                .of(context)
                                .size
                                .width * 0.2,
                          ),
                          width: AppSize.s16,
                          height: AppSize.s46,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.white)),
                              onPressed: () {
                                _customDialogSubscriptionExit(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.cancel,
                                style: TextStyle(
                                    color: ColorManager.primaryDark),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                TabPageSelectorIndicator(
                  backgroundColor: ColorManager.primaryDark,
                  borderColor: ColorManager.primaryDark,
                  size: AppSize.s12,
                ),
                SizedBox(
                  height: AppSize.s22,
                ),
                GestureDetector(
                  // onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          activeColor: ColorManager.primary,
                          value: 'Agree',
                          onChanged: (n) {
                            setState(() {
                              Agree = !Agree;
                              option1 = n!;
                            });
                            print('--------------------------------agree');
                            print(Agree);
                          },
                          groupValue: option1),
                      // Text(
                      //   AppLocalizations.of(context)!
                      //       .i_agree_to_the_terms_of_service,
                      //   style: getRegularStyle(
                      //       color: ColorManager.grey, fontSize: FontSize.s16),
                      // ),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.i_agree_to,
                            style: getRegularStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s16),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.termsOfUseRoute);
                            },
                            child: Text.rich(
                              //underline partially
                              TextSpan(
                                  style: TextStyle(
                                      fontSize: FontSize.s16,
                                      color: Colors.blue),
                                  //global text style
                                  children: [
                                    TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .terms_of,
                                        style: TextStyle(
                                            decoration: TextDecoration
                                                .underline)), //partial text style
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _customDialogSubscriptionSeller(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s258,
              width: AppSize.s360,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${AppLocalizations.of(context)!.submit_as_seller}',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s16),
                      ),
                    ),

                    // Text('Delicious food near you',style: TextStyle(fontSize: AppSize.s24),),
                    // Text('Your favorites food\ndelivered at your doorstep',style: TextStyle(fontSize: AppSize.s14),),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Text('We deliver grocery at your door step',style: TextStyle(fontSize: AppSize.s18),),
                    // ),
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.are_you_sure_subscribe}',
                      style: TextStyle(fontSize: AppSize.s20),
                    ),
                    // Text('Schedule your food order in advance',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for breakfast ',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('What do you like for dinner ',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for lunch ',style: TextStyle(fontSize: AppSize.s14),),
                    SizedBox(
                      height: AppSize.s28,
                    ),

                    // SizedBox(
                    //   height: AppSize.s20,
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                Routes.addPaymentCardSelleRoute,
                                arguments: planId);
                          },
                          child: Container(
                            width: AppSize.s110,
                            height: AppSize.s38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.primaryDark,
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.yes,
                              textAlign: TextAlign.center,
                              style: getMediumStyle(color: ColorManager.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: AppSize.s110,
                            height: AppSize.s38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.primaryDark,
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.no,
                              textAlign: TextAlign.center,
                              style: getMediumStyle(color: ColorManager.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          );
        });
  }

  void _customDialogSubscriptionExit(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s280,
              width: AppSize.s360,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${AppLocalizations.of(context)!.subscribe_as_seller}',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s16),
                      ),
                    ),

                    // Text('Delicious food near you',style: TextStyle(fontSize: AppSize.s24),),
                    // Text('Your favorites food\ndelivered at your doorstep',style: TextStyle(fontSize: AppSize.s14),),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Text('We deliver grocery at your door step',style: TextStyle(fontSize: AppSize.s18),),
                    // ),
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.are_you_cancel_process}',
                      style: TextStyle(fontSize: AppSize.s20),
                    ),
                    // Text('Schedule your food order in advance',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for breakfast ',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('What do you like for dinner ',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for lunch ',style: TextStyle(fontSize: AppSize.s14),),
                    SizedBox(
                      height: AppSize.s28,
                    ),

                    // SizedBox(
                    //   height: AppSize.s20,
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _accountViewGetXController.logout(context: context);
                          },
                          child: Container(
                            width: AppSize.s110,
                            height: AppSize.s38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.primaryDark,
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.yes,
                              textAlign: TextAlign.center,
                              style: getMediumStyle(color: ColorManager.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: AppSize.s110,
                            height: AppSize.s38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.primaryDark,
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.no,
                              textAlign: TextAlign.center,
                              style: getMediumStyle(color: ColorManager.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          );
        });
  }
}
