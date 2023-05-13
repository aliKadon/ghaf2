import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/product_view/product_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../../domain/model/product.dart';
import '../../../domain/model/product2.dart';

class RateSeller extends StatefulWidget {
  const RateSeller({Key? key}) : super(key: key);

  @override
  State<RateSeller> createState() => _RateSellerState();
}

class _RateSellerState extends State<RateSeller> {

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getOrders();
    super.initState();
  }

  String? review1;
  String? review2;
  String? review3;
  String? review4;
  String? review5;
  String? review6;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  int points = 1;

  String opinion = '';

  @override
  Widget build(BuildContext context) {
    review1 = AppLocalizations.of(context)!.fast_reliable;
    review2 = AppLocalizations.of(context)!.wider;
    review3 = AppLocalizations.of(context)!.easy_replacment;
    review4 = AppLocalizations.of(context)!.hygiene_rating;
    review5 = AppLocalizations.of(context)!.right_order;
    review6 = AppLocalizations.of(context)!.for_shops_easy;

    // review1 = 'sada';
    // review2 = 'fafds';
    // review3 = 'sdasd';
    // review4 = 'asdasd';
    // review5 = 'adasda';
    // review6 = 'asdasd';

    var provider = Provider
        .of<ProductProvider>(context)
        .orders;
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
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.038,
                        width: MediaQuery.of(context).size.width * 0.08,
                        child: Image.asset(
                          SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                          height: AppSize.s18,
                          width: AppSize.s10,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.share_opinion,
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
                // SizedBox(
                //   height: AppSize.s12,
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: Image.asset(
                    '${Constants.imagesPath}rateStore.png',
                  ),
                ),
                // SizedBox(
                //   height: 15.h,
                // ),
                Text(
                  AppLocalizations.of(context)!.rate_shop,
                  style: getRegularStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                RatingBar.builder(
                  // initialRating: _rateUsViewGetXController.rate.toDouble(),
                  initialRating: points.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  glow: false,
                  itemPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  itemBuilder: (context, _) =>
                      SvgPicture.asset(
                        '${Constants.vectorsPath}star.svg',
                      ),
                  unratedColor: Colors.grey.shade300,

                  onRatingUpdate: (value) {
                    points = value.toInt();
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.tell_us_order,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          opinion = review1!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey),
                        // color: ColorManager.primaryDark,
                        width: AppSize.s222,
                        height: AppSize.s43,
                        child: Center(
                          child: Text(
                            review1!,
                            style: getSemiBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: AppSize.s6,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          opinion = review4!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey),
                        // color: ColorManager.primaryDark,
                        width: AppSize.s123,
                        height: AppSize.s43,
                        child: Center(
                          child: Text(
                            review4!,
                            style: getSemiBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.s5,),
                InkWell(
                  onTap: () {
                    setState(() {
                      opinion = review6!;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey),
                    // color: ColorManager.primaryDark,
                    width: AppSize.s280,
                    height: AppSize.s43,
                    child: Center(
                      child: Text(
                        review6!,
                        style: getSemiBoldStyle(
                            color: ColorManager.white, fontSize: FontSize.s12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(
                      onTap: () {
                        setState(() {
                          opinion = review3!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey),
                        // color: ColorManager.primaryDark,
                        width: AppSize.s154,
                        height: AppSize.s43,
                        child: Center(
                          child: Text(
                            review3!,
                            style: getSemiBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width:AppSize.s6,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          opinion = review2!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey),
                        // color: ColorManager.primaryDark,
                        width: AppSize.s192,
                        height: AppSize.s43,
                        child: Center(
                          child: Text(
                            review2!,
                            style: getSemiBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s14),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: AppSize.s5,),
                InkWell(
                  onTap: () {
                    setState(() {
                      opinion = review5!;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey),
                    // color: ColorManager.primaryDark,
                    width: AppSize.s326,
                    height: AppSize.s43,
                    child: Center(
                      child: Text(
                        review5!,
                        style: getSemiBoldStyle(
                            color: ColorManager.white, fontSize: FontSize.s12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s10,),

                Container(
                  height: AppSize.s73,
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                      contentPadding: EdgeInsets.only(bottom: AppSize.s50, left: AppSize.s7),
                      // label: Text('${_rateUsViewGetXController.description}'),
                      label: Text(opinion),
                      labelStyle: TextStyle(fontSize: AppSize.s20),

                    ),

                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s55,
                  child: ElevatedButton(

                    onPressed: () {
                      // print(_rateUsViewGetXController.description);
                      // _rateUsViewGetXController.reviewApp();

                      // Provider.of<ProductProvider>(context, listen: false)
                      //     .postReviewStore('${provider[0]
                      //     .items![0].storeId}', opinion, points).then((
                      //     value) =>
                      //     ScaffoldMessenger.of(context)
                      //         .showSnackBar(SnackBar(content: Text(
                      //         '${AppLocalizations.of(context)!
                      //             .thank_you}\n${AppLocalizations.of(context)!
                      //             .your_review_successfully}'),
                      //         backgroundColor: Colors.green),)).then((value) =>
                      //     Navigator.of(context).pushReplacementNamed(Routes
                      //         .mainRoute));
                      print(
                          '-----------------------------------------------------------');
                      // print('id : ${provider[0]
                      //     .items![0].storeId} , opinion:  $opinion, points: $points');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.send_a_note,
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

// String review4 = 'Bad.';
}
