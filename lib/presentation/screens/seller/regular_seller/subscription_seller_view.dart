import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';

import '../../../../domain/model/models.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/constants_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/values_manager.dart';
import '../../account_view/account_view_getx_controller.dart';

class SubscriptionSellerView extends StatefulWidget {
  const SubscriptionSellerView({Key? key}) : super(key: key);

  @override
  State<SubscriptionSellerView> createState() => _SubscriptionSellerViewState();
}

class _SubscriptionSellerViewState extends State<SubscriptionSellerView> {
  int _currentPageIndex = 0;
  late PageController _pageController;
  late final AccountViewGetXController _accountViewGetXController =
      Get.put(AccountViewGetXController());
  bool isLoading = true;

  @override
  void initState() {
    Provider.of<SellerProvider>(context, listen: false)
        .getSellerPlans()
        .then((value) => isLoading = false);
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool Agree = false;
  bool monthly = true;


  @override
  Widget build(BuildContext context) {
    var sellerPlan = Provider.of<SellerProvider>(context).getSellerPlansData;
    return Scaffold(
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
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppSize.s22,
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .choose_your_subscription_option,
                      textAlign: TextAlign.center,
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s20),
                    ),
                    SizedBox(
                      height: AppSize.s22,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: PageView(
                        physics: const BouncingScrollPhysics(),
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (int pageIndex) {
                          setState(() {
                            _currentPageIndex = pageIndex;
                          });
                        },
                        children: [
                          _onBoardingContent(
                              SubscriptionObject(
                                  AppLocalizations.of(context)!.tier1,
                                  monthly
                                      ? '${sellerPlan[0]['priceAmount']} ${AppLocalizations.of(context)!.aed}'
                                      : '${sellerPlan[3]['priceAmount']} ${AppLocalizations.of(context)!.aed}',
                                  ImageAssets.tier1,
                                  [
                                    '${AppLocalizations.of(context)!.update_menu}',
                                    '${AppLocalizations.of(context)!.track_order}',
                                    '${AppLocalizations.of(context)!.which}',
                                    '${AppLocalizations.of(context)!.monitor}',
                                    '${AppLocalizations.of(context)!.monthly_payment}',
                                    '${AppLocalizations.of(context)!.otherwise}',
                                    '${AppLocalizations.of(context)!.photography}',
                                    '${AppLocalizations.of(context)!.connect}'
                                  ]),
                              _currentPageIndex,
                              '${sellerPlan[0]['id']}',
                              '${sellerPlan[3]['id']}',
                              Agree),
                          _onBoardingContent(
                              SubscriptionObject(
                                  AppLocalizations.of(context)!.tier2,
                                  monthly
                                      ? '${sellerPlan[1]['priceAmount']} ${AppLocalizations.of(context)!.aed}'
                                      : '${sellerPlan[3]['priceAmount']} ${AppLocalizations.of(context)!.aed}',
                                  ImageAssets.tier1,
                                  [
                                    '${AppLocalizations.of(context)!.update_menu}',
                                    '${AppLocalizations.of(context)!.promote}',
                                    '${AppLocalizations.of(context)!.which}',
                                    '${AppLocalizations.of(context)!.connect}',
                                    '${AppLocalizations.of(context)!.fees}',
                                    '${AppLocalizations.of(context)!.otherwise}',
                                    '${AppLocalizations.of(context)!.photography2}'
                                  ]),
                              _currentPageIndex,
                              '${sellerPlan[1]['id']}',
                              '${sellerPlan[3]['id']}',
                              Agree),
                          _onBoardingContent(
                              SubscriptionObject(
                                  AppLocalizations.of(context)!.tier3,
                                  monthly
                                      ? '${sellerPlan[2]['priceAmount']} ${AppLocalizations.of(context)!.aed}'
                                      : '${sellerPlan[3]['priceAmount']} ${AppLocalizations.of(context)!.aed}',
                                  ImageAssets.tier1,
                                  [
                                    '${AppLocalizations.of(context)!.update_menu}',
                                    '${AppLocalizations.of(context)!.promote}',
                                    '${AppLocalizations.of(context)!.banner}',
                                    '${AppLocalizations.of(context)!.which}',
                                    '${AppLocalizations.of(context)!.regular_email}',
                                    '${AppLocalizations.of(context)!.connect}',
                                    '${AppLocalizations.of(context)!.monthly_payment2}',
                                  ]),
                              _currentPageIndex,
                              '${sellerPlan[2]['id']}',
                              '${sellerPlan[3]['id']}',
                              Agree),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _onBoardingIndicator(
                            isSelected: _currentPageIndex == 0),
                        _onBoardingIndicator(
                            isSelected: _currentPageIndex == 1),
                        _onBoardingIndicator(
                            isSelected: _currentPageIndex == 2),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 110,
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            _customDialogSubscriptionExit(context);
                          },
                          child: Text(AppLocalizations.of(context)!.cancel)),
                    ),
                    SizedBox(
                      height: AppSize.s10,
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
                          Row(
                            children: [
                              Text(
                                'I Agree To The ',
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
                                            text:
                                                "${AppLocalizations.of(context)!.terms_of_services}",
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
                    SizedBox(
                      height: AppSize.s20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  var option1 = '';
  var option = '';
  var plan = '';
  var Agree1 = false;

  Widget _onBoardingContent(
      SubscriptionObject? subscriptionObject,
      int currentPageIndex,
      String planIdMonthly,
      String planIdAnnual,
      bool agree) {
    if (subscriptionObject == null) {
      return Container();
    } else {
      return Container(
        padding: EdgeInsets.all(AppPadding.p12),
        decoration: BoxDecoration(
          color: currentPageIndex == 0
              ? ColorManager.white
              : currentPageIndex == 1
                  ? ColorManager.white
                  : ColorManager.white,
          borderRadius: BorderRadius.circular(AppRadius.r8),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                SizedBox(
                  height: AppSize.s92,
                  width: AppSize.s92,
                  child: Image.asset(
                    subscriptionObject.image,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: AppSize.s8,
                ),
                Text(
                  subscriptionObject.name,
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s20),
                ),
                Spacer(),
                Text(
                  subscriptionObject.price,
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s20),
                ),
              ],
            ),
            SizedBox(
              height: AppSize.s12,
            ),
            for (var item in subscriptionObject.listItem)
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
                        item,
                        textAlign: TextAlign.start,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s12),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: AppSize.s22,
            ),
            Row(
              children: [
                GestureDetector(
                  // onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(AppSize.s8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ColorManager.greyLight)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            activeColor: ColorManager.primary,
                            focusColor: Colors.white,
                            value: 'Monthly',
                            onChanged: (n) {
                              setState(() {
                                monthly = true;
                                Agree1 = true;
                                plan = planIdMonthly;
                                option = n!;
                              });
                              print('${Agree1}--------------------------monthly');
                              print(option);
                            },
                            groupValue: option),
                        Text(
                          AppLocalizations.of(context)!.monthly,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: AppSize.s16,),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: GestureDetector(
                    // onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(AppSize.s8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorManager.greyLight)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                              activeColor: ColorManager.primary,
                              focusColor: Colors.white,
                              value: 'Annual',
                              onChanged: (n) {
                                setState(() {
                                  monthly = false;
                                  Agree1 = true;
                                  plan = planIdAnnual;
                                  option = n!;
                                });
                                print(
                                    '${Agree1}----------------------------annual');
                                print(option);
                              },
                              groupValue: option),
                          Text(
                            AppLocalizations.of(context)!.annual,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.s16,),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppMargin.m16,
              ),
              width: double.infinity,
              height: AppSize.s55,
              child: ElevatedButton(
                onPressed: () => Agree && Agree1
                    ? _customDialogSubscriptionSeller(context)
                    : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please Choose All The Options"),
                        backgroundColor: Colors.red,
                      )),
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary),
                child: Text(
                  AppLocalizations.of(context)!.subscribe_now,
                  style: getSemiBoldStyle(
                      color: ColorManager.white, fontSize: FontSize.s18),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _onBoardingIndicator({required bool isSelected}) {
    return isSelected
        ? TabPageSelectorIndicator(
            backgroundColor: ColorManager.primaryDark,
            borderColor: ColorManager.primaryDark,
            size: AppSize.s12,
          )
        : TabPageSelectorIndicator(
            backgroundColor: ColorManager.grey,
            borderColor: ColorManager.grey,
            size: AppSize.s12,
          );
  }

  _skipPageView() {
    Navigator.pushReplacementNamed(context, Routes.welcomeRoute);
  }

  _nextPageView() {
    if (_currentPageIndex == AppConstants.lastPageIndex) {
      Navigator.pushReplacementNamed(context, Routes.welcomeRoute);
      return;
    }
    _pageController.animateToPage(++_currentPageIndex,
        duration: const Duration(milliseconds: AppConstants.nextPageDelay),
        curve: Curves.easeInOut);
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
                        '${AppLocalizations.of(context)!.subscribe_as_normal_seller}',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
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
                                arguments: plan);
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
                        '${AppLocalizations.of(context)!.subscribe_as_normal_seller}',
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
