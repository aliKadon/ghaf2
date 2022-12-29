import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';

import '../../domain/model/models.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppSize.s85,
            ),
            Expanded(
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
                    SliderObject(AppLocalizations.of(context)!.on_boarding_img3,
                        ImageAssets.onboardingImg3),
                  ),
                  _onBoardingContent(
                    SliderObject(AppLocalizations.of(context)!.on_boarding_img1,
                        ImageAssets.onboardingImg1),
                  ),
                  _onBoardingContent(
                    SliderObject(AppLocalizations.of(context)!.on_boarding_img2,
                        ImageAssets.onboardingImg2),
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
              height: AppSize.s32,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppMargin.m16,
              ),
              width: double.infinity,
              height: AppSize.s55,
              child: ElevatedButton(
                onPressed: () => _nextPageView(),
                child: Text(
                  AppLocalizations.of(context)!.continue1,
                  style: getSemiBoldStyle(
                      color: ColorManager.white, fontSize: FontSize.s18),
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s24,
            ),
            GestureDetector(
              onTap: () => _skipPageView(),
              child: Text(
                AppLocalizations.of(context)!.skip,
                style: getMediumStyle(
                    color: ColorManager.grey, fontSize: FontSize.s18),
              ),
            ),
            SizedBox(
              height: AppSize.s40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _onBoardingContent(SliderObject? sliderObject) {
    if (sliderObject == null) {
      return Container();
    } else {
      return Column(
        children: [
          SizedBox(
            height: AppSize.s210,
            child: Image.asset(
              sliderObject.image,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: AppSize.s10,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                sliderObject.title,
                textAlign: TextAlign.center,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s16),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _onBoardingIndicator({required bool isSelected}) {
    return isSelected
        ? TabPageSelectorIndicator(
            backgroundColor: ColorManager.primary,
            borderColor: ColorManager.primary,
            size: AppSize.s12,
          )
        : TabPageSelectorIndicator(
            backgroundColor: ColorManager.transparent,
            borderColor: ColorManager.greyLight,
            size: AppSize.s12,
          );
  }

  _skipPageView() {
    Navigator.pushReplacementNamed(context, Routes.welcomeRoute);
  }

  _nextPageView() {
    if (_currentPageIndex == AppConstants.lastPageIndex) {
      Navigator.pushReplacementNamed(context, Routes.welcomeRoute);
      SharedPrefController().setDisplayOnBoarding(false);
      return;
    }
    _pageController.animateToPage(++_currentPageIndex,
        duration: const Duration(milliseconds: AppConstants.nextPageDelay),
        curve: Curves.easeInOut);
  }
}
