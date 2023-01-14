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
import 'package:ghaf_application/presentation/screens/product_view/product_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/rate_us_view/rate_us_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/model/product.dart';
import '../../domain/model/product2.dart';

class RateSeller extends StatefulWidget {
  const RateSeller({Key? key}) : super(key: key);

  @override
  State<RateSeller> createState() => _RateSellerState();
}

class _RateSellerState extends State<RateSeller> {

  @override
  void initState() {
    Provider.of<ProductProvider>(context,listen: false).getOrders();
    super.initState();
  }
  int points = 1 ;
  String opinion = '' ;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context).orders;
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
                  'Rate your experience with shop',
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
                  itemBuilder: (context, _) => SvgPicture.asset(
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
                      'Tell us about your order ?',
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
                      onTap: (){
                        setState(() {
                          opinion = review1;
                        });

                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.grey),
                        // color: ColorManager.primaryDark,
                        width: AppSize.s222,
                        height: AppSize.s43,
                        child: Center(
                          child: Text(
                            review1,
                            style: getSemiBoldStyle(
                                color: ColorManager.white, fontSize: FontSize.s14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          opinion = review4;
                        });

                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.grey),
                        // color: ColorManager.primaryDark,
                        width: AppSize.s123,
                        height: AppSize.s43,
                        child: Center(
                          child: Text(
                            review4,
                            style: getSemiBoldStyle(
                                color: ColorManager.white, fontSize: FontSize.s14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:5,),
                InkWell(
                  onTap: (){
                    setState(() {
                      opinion = review6;
                    });

                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.grey),
                    // color: ColorManager.primaryDark,
                    width: AppSize.s280,
                    height: AppSize.s43,
                    child: Center(
                      child: Text(
                        review6,
                        style: getSemiBoldStyle(
                            color: ColorManager.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height:5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(
                      onTap: (){
                        setState(() {
                          opinion = review3;
                        });

                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.grey),
                        // color: ColorManager.primaryDark,
                        width: AppSize.s154,
                        height: AppSize.s43,
                        child: Center(
                          child: Text(
                            review3,
                            style: getSemiBoldStyle(
                                color: ColorManager.white, fontSize: FontSize.s14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          opinion = review2;
                        });

                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.grey),
                        // color: ColorManager.primaryDark,
                        width: AppSize.s192,
                        height: AppSize.s43,
                        child: Center(
                          child: Text(
                            review2,
                            style: getSemiBoldStyle(
                                color: ColorManager.white, fontSize: FontSize.s14),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height:5,),
                InkWell(
                  onTap: (){
                    setState(() {
                      opinion = review5;
                    });

                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.grey),
                    // color: ColorManager.primaryDark,
                    width: AppSize.s326,
                    height: AppSize.s43,
                    child: Center(
                      child: Text(
                        review5,
                        style: getSemiBoldStyle(
                            color: ColorManager.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                Container(
                  height: AppSize.s73,
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(border     : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                      contentPadding: EdgeInsets.only(bottom: 50,left: 7),
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
                      Navigator.of(context).pop();
                      Provider.of<ProductProvider>(context, listen: false).postReviewStore('${provider[0].items![0]['storeId']}', opinion, points) .then((value) => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Thank You!\nYour review has been submitted successfully'),backgroundColor: Colors.green),));
                      print('-----------------------------------------------------------');
                      print('id : ${provider[0].items![0]['storeId']} , opinion:  $opinion, points: $points');
                    },
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
  String review1 = 'Fast reliable and  preparation';
  String review2 = 'Wider  product selection';
  String review3 = 'Easy replacement';
  String review4 = 'Hygiene rating';
  String review5 = 'Right order arrived in the timeframe promised';
  String review6 = 'For shops easy return and exchange';
  // String review4 = 'Bad.';
}
