import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: ListView(
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
                height: 700,
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
                          AppLocalizations.of(context)!.aed_50,
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
                    ),
                    _onBoardingContent(
                      SubscriptionObject(
                          AppLocalizations.of(context)!.tier2,
                          AppLocalizations.of(context)!.aed_50,
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
                    ),
                    _onBoardingContent(
                      SubscriptionObject(
                          AppLocalizations.of(context)!.tier3,
                          AppLocalizations.of(context)!.aed_50,
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
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .i_agree_to_the_terms_of_service,
                    style: getMediumStyle(
                        color: ColorManager.grey, fontSize: FontSize.s14),
                  ),
                ],
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

  Widget _onBoardingContent(
      SubscriptionObject? subscriptionObject, int currentPageIndex) {
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
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppMargin.m16,
              ),
              width: double.infinity,
              height: AppSize.s55,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed(Routes.addPaymentCardSelleRoute),
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
