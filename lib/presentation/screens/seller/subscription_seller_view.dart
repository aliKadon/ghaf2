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
                          '${sellerPlan[0]['priceAmount']} AED',
                          ImageAssets.tier1, [
                        'Update menu and products, add images and tell customers when an item is update using Menu Manager.',
                        'Track orders',
                        'Which dishes or product your customer like, check reviews and keep them coming back for more.',
                        'Monitor the status of your order delivery and get alerted when its delivered',
                        'Monthly payment of Dhs 260 + 1 time setup fee (Average set-up fee of 500 Dhs). Price variesbased on POS.)',
                        'Otherwise signing an annual plan of Dhs 2,400',
                        'Choose Photography from a professional photographer. This tier includes 15 items for more images a fee of ## per image',
                        'Connect with delivery network'
                      ]),
                      _currentPageIndex,
                        '${sellerPlan[0]['id']}',
                        '${sellerPlan[3]['id']}',
                      Agree
                    ),
                    _onBoardingContent(
                      SubscriptionObject(
                          AppLocalizations.of(context)!.tier2,
                          '${sellerPlan[1]['priceAmount']} AED',
                          ImageAssets.tier1, [
                        'Update menu and products, add images and tell customers when an item is update using Manager',
                        'Promote your brand in-app and create special offers',
                        'Which dishes or product your customer like, check reviews and keep them coming back for more.',
                        'Connect with delivery network',
                        'Fees: Monthly payment of Dhs 300 + 1 time setup fee (Average set-up fee of 500 Dhs). Price varies based on POS.)',
                        'Otherwise signing an annual plan of Dhs 2,400',
                        'Choose Photography from a professional photographer. This tier includes 25 items for more images a fee of ## per image'
                      ]),
                      _currentPageIndex,'${sellerPlan[1]['id']}',
                      '${sellerPlan[3]['id']}',Agree
                    ),
                    _onBoardingContent(
                      SubscriptionObject(
                          AppLocalizations.of(context)!.tier3,
                          '${sellerPlan[2]['priceAmount']} AED',
                          ImageAssets.tier1, [
                        'Update menu and products, add images and tell customers when an item is update using Manager.',
                        'Promote your brand in-app and create special offers.',
                        'Adv Banner, getting a place in the Adv Banner this banner (also subject to several conditions of service quality and customer satisfaction)',
                        'Which dishes or product your customer like, check reviews and keep them coming back for more.',
                        'Regular email marketing communications and social media advertising',
                        'Connect with delivery network',
                        'Monthly payment of Dhs 450 + 1 time setup fee (Average set-up fee of 500 Dhs). Price varies based on POS.)Otherwise signing an annual plan of Dhs 2,400',
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
                        'monthly',
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
                          'Annual',
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
