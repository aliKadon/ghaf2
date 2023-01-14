import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';
import '../../../domain/model/models.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';

class SubscriptionSellerView extends StatefulWidget {
  const SubscriptionSellerView({Key? key}) : super(key: key);

  @override
  State<SubscriptionSellerView> createState() => _SubscriptionSellerViewState();
}

class _SubscriptionSellerViewState extends State<SubscriptionSellerView> {
  int _currentPageIndex = 0;
  late PageController _pageController;

  bool isLoading = true;
  @override
  void initState() {
    Provider.of<SellerProvider>(context, listen: false).getSellerPlans().then((value) => isLoading = false);
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
    var sellerPlan =  Provider.of<SellerProvider>(context).getSellerPlansData;
    return Scaffold(
      body: isLoading ? Center(
        child: Container(
          width: 20.h,
          height: 20.h,
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ),
        ),
      ): SafeArea(
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
                AppLocalizations.of(context)!.choose_your_subscription_option,
                textAlign: TextAlign.center,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s20),
              ),
              SizedBox(
                height: AppSize.s22,
              ),
              Text(
                AppLocalizations.of(context)!.join_sus_snow_and_get,
                textAlign: TextAlign.center,
                style: getMediumStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s20),
              ),
              SizedBox(
                height: AppSize.s16,
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
                    Text(
                      AppLocalizations.of(context)!.no_commission,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16),
                    ),
                  ],
                ),
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
                    Text(
                      AppLocalizations.of(context)!.easy_pos_integration,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16),
                    ),
                  ],
                ),
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
                    Text(
                      AppLocalizations.of(context)!
                          .more_visibility_and_new_customers,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16),
                    ),
                  ],
                ),
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
                    Text(
                      AppLocalizations.of(context)!.leave_hiring_driver_to_us,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16),
                    ),
                  ],
                ),
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
                    Text(
                      AppLocalizations.of(context)!
                          .helping_you_build_your_first_menu_and_products,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16),
                    ),
                  ],
                ),
              ),
              Container(
                height: 550,
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
                  monthly?'${sellerPlan[0]['priceAmount']} ${AppLocalizations.of(context)!.aed}' :'${sellerPlan[3]['priceAmount']} ${AppLocalizations.of(context)!.aed}',
                          ImageAssets.tier1, [
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
                      Agree
                    ),
                    _onBoardingContent(
                      SubscriptionObject(
                          AppLocalizations.of(context)!.tier2,
                          monthly?'${sellerPlan[1]['priceAmount']} ${AppLocalizations.of(context)!.aed}' :'${sellerPlan[3]['priceAmount']} ${AppLocalizations.of(context)!.aed}',
                          ImageAssets.tier1, [
                        '${AppLocalizations.of(context)!.update_menu}',
                        '${AppLocalizations.of(context)!.promote}',
                        '${AppLocalizations.of(context)!.which}',
                        '${AppLocalizations.of(context)!.connect}',
                        '${AppLocalizations.of(context)!.fees}',
                        '${AppLocalizations.of(context)!.otherwise}',
                        '${AppLocalizations.of(context)!.photography2}'
                      ]),
                      _currentPageIndex,'${sellerPlan[1]['id']}',
                      '${sellerPlan[3]['id']}',Agree
                    ),
                    _onBoardingContent(
                      SubscriptionObject(
                          AppLocalizations.of(context)!.tier3,
                          monthly?'${sellerPlan[2]['priceAmount']} ${AppLocalizations.of(context)!.aed}' :'${sellerPlan[3]['priceAmount']} ${AppLocalizations.of(context)!.aed}',
                          ImageAssets.tier1, [
                        '${AppLocalizations.of(context)!.update_menu}',
                        '${AppLocalizations.of(context)!.promote}',
                        '${AppLocalizations.of(context)!.banner}',
                        '${AppLocalizations.of(context)!.which}',
                        '${AppLocalizations.of(context)!.regular_email}',
                        '${AppLocalizations.of(context)!.connect}',
                        '${AppLocalizations.of(context)!.monthly_payment2}',
                      ]),
                      _currentPageIndex,'${sellerPlan[2]['id']}',
                      '${sellerPlan[3]['id']}',Agree
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _onBoardingIndicator(isSelected: _currentPageIndex == 0),
                  _onBoardingIndicator(isSelected: _currentPageIndex == 1),
                  _onBoardingIndicator(isSelected: _currentPageIndex == 2),
                ],
              ),
              SizedBox(
                height: AppSize.s24,
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
                    Text(
                      AppLocalizations.of(context)!
                          .i_agree_to_the_terms_of_service,
                      style: getRegularStyle(
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
      ),
    );
  }
  var option1 = '';
  var option = '';
  var plan = '';
  var Agree1 = false;
  Widget _onBoardingContent(
      SubscriptionObject? subscriptionObject, int currentPageIndex,String planIdMonthly,String planIdAnnual , bool agree) {
    if (subscriptionObject == null) {
      return Container();
    } else {
      return Container(
        padding: EdgeInsets.all(AppPadding.p12),
        decoration: BoxDecoration(
          color: currentPageIndex == 0
              ? ColorManager.primaryDark
              : currentPageIndex == 1
                  ? ColorManager.primary
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
                      color: currentPageIndex == 0
                          ? ColorManager.white
                          : ColorManager.primaryDark,
                      fontSize: FontSize.s20),
                ),
                Spacer(),
                Text(
                  subscriptionObject.price,
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                      color: currentPageIndex == 0
                          ? ColorManager.white
                          : ColorManager.primaryDark,
                      fontSize: FontSize.s20),
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
                      backgroundColor: currentPageIndex == 1
                          ? ColorManager.white
                          : ColorManager.primary,
                    ),
                    SizedBox(
                      width: AppSize.s12,
                    ),
                    Expanded(
                      child: Text(
                        item,
                        textAlign: TextAlign.start,
                        style: getMediumStyle(
                            color: currentPageIndex == 0
                                ? ColorManager.white
                                : ColorManager.primaryDark,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          activeColor: currentPageIndex==1? ColorManager.primaryDark:ColorManager.primary,
                          focusColor: Colors.white,
                          value: 'Monthly',
                          onChanged: (n) {
                            setState(() {
                              monthly =true;
                              Agree1 = true;
                              plan = planIdMonthly;
                              option = n!;
                            });
                            print(
                                '${Agree1}--------------------------monthly');
                            print(option);
                          },
                          groupValue: option),
                      Text(
                        AppLocalizations.of(context)!.monthly,
                        style: TextStyle(fontWeight: FontWeight.w500,
                            color: currentPageIndex==1? ColorManager.primaryDark:ColorManager.primary,
                            fontSize: FontSize.s16),
                      ),
                    ],
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: GestureDetector(
                    // onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            activeColor: currentPageIndex==1? ColorManager.primaryDark:ColorManager.primary,
                            focusColor: Colors.white,

                            value: 'Annual',
                            onChanged: (n) {
                              setState(() {
                                monthly =false;
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
                          style: TextStyle(fontWeight: FontWeight.w500,
                              color: currentPageIndex==1? ColorManager.primaryDark:ColorManager.primary,
                              fontSize: FontSize.s16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppMargin.m16,
              ),
              width: double.infinity,
              height: AppSize.s55,
              child: ElevatedButton(
                onPressed: () => Agree && Agree1 ? Navigator.of(context).pushNamed(Routes.addPaymentCardSelleRoute , arguments: plan ) : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Choose All The Options"),backgroundColor: Colors.red,)),
                style: ElevatedButton.styleFrom(backgroundColor: currentPageIndex==1? ColorManager.primaryDark:ColorManager.primary),
                child: Text(
                  AppLocalizations.of(context)!.subscribe_now,
                  style: getSemiBoldStyle(
                      color:  ColorManager.white, fontSize: FontSize.s18),
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
}
