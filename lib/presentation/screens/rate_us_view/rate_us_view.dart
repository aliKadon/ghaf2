import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/rate_us_view/rate_us_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';

class RateUsView extends StatefulWidget {
  const RateUsView({Key? key}) : super(key: key);

  @override
  State<RateUsView> createState() => _RateUsViewState();
}

class _RateUsViewState extends State<RateUsView> {
  // controller.
  late final RateUsViewGetXController _rateUsViewGetXController =
      Get.find<RateUsViewGetXController>();

  // dispose.
  @override
  void dispose() {
    Get.delete<RateUsViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Share Your Opinion',
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
                  height: AppSize.s12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Image.asset(
                    '${Constants.imagesPath}rate.png',
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'How do you see us?',
                  style: getRegularStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                RatingBar.builder(
                  initialRating: _rateUsViewGetXController.rate.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  glow: false,
                  itemPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  itemBuilder: (context, _) => SvgPicture.asset(
                    '${Constants.vectorsPath}star.svg',
                  ),
                  unratedColor: Colors.grey.shade300,
                  onRatingUpdate: (value) {
                    _rateUsViewGetXController.rate = value.toInt();
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text(
                      'Do you have notes to tell us?',
                      style: getRegularStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Form(
                  key: _rateUsViewGetXController.formKey,
                  child: AppTextField(
                    hint: '',
                    lines: 8,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                    onSaved: (value) =>
                        _rateUsViewGetXController.description = value,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s55,
                  child: ElevatedButton(
                    onPressed: _rateUsViewGetXController.reviewApp,
                    child: Text(
                      'Send A Note',
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
