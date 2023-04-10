import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/rate_and_reviews/rate_delivery/rate_delivery_getx_controller.dart';
import 'package:provider/provider.dart';

import '../../../../providers/product_provider.dart';
import '../../../resources/routes_manager.dart';
import '../review_getx_controller.dart';

class RateDelivery extends StatefulWidget {
  String deliveryId;

  RateDelivery({required this.deliveryId});

  @override
  State<RateDelivery> createState() => _RateDeliveryState();
}

class _RateDeliveryState extends State<RateDelivery> {
  // controller.
  late final RateDeliveryGetxController _rateShopGetxController =
  Get.find<RateDeliveryGetxController>();
  late final ReviewGetxController _reviewGetxController =
  Get.put(ReviewGetxController());
  var selected = -1;

  var isChecked = false;
  @override
  void initState() {
    Get.put<RateDeliveryGetxController>(
        RateDeliveryGetxController(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String review1 = AppLocalizations.of(context)!.delivery_note1;
    String review2 = AppLocalizations.of(context)!.delivery_note2;
    String review3 = AppLocalizations.of(context)!.delivery_note3;
    List notesReview = [review1, review2, review3];
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
                      AppLocalizations.of(context)!.rate_delivery1,
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
                    ImageAssets.rateDelivery,
                    height: AppSize.s258,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  AppLocalizations.of(context)!.experiance_delivery,
                  style: getBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s14,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                RatingBar.builder(
                  initialRating: _rateShopGetxController.rate.toDouble(),
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
                    _rateShopGetxController.rate = value.toInt();
                    print(_rateShopGetxController.rate);
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .do_you_have_notes_to_tell_us,
                      style: getBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: notesReview.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index;
                            print(selected);
                          });
                        },
                        child: selected == index
                            ? notes(context, notesReview[index], index, true)
                            : notes(context, notesReview[index], index, false));
                  },
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  height: AppSize.s123,
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.only(bottom: 80, left: 7),
                      label: Text('${_rateShopGetxController.description}'),
                      labelStyle: TextStyle(fontSize: AppSize.s26),
                    ),
                  ),
                ),
                // AppTextField(
                //   hint: '${_rateUsViewGetXController.description}',
                //   lines: 6,
                //
                //   // validator: (value) {
                //   //   if (value == null || value.isEmpty) {
                //   //     return 'Description is required';
                //   //   }
                //   //   return null;
                //   // },
                //   //
                //   // onSaved: (value) =>
                //   //     _rateUsViewGetXController.description = value,
                // ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s55,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll(ColorManager.primaryDark)),
                    onPressed: () {
                      _reviewGetxController.addDeliveryReview(context: context, deliverId: widget.deliveryId, description: _rateShopGetxController.description!, points: _rateShopGetxController.rate);
                      // print(_rateShopGetxController.description);
                      // _rateShopGetxController.reviewApp();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.send_note,
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

  Widget notes(BuildContext context, String text, int index, bool check) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selected = index;
              _rateShopGetxController.description = text;
            });
            print(_rateShopGetxController.description);
          },
          child: Row(
            children: [
              Checkbox(
                  value: check,
                  onChanged: (_) {
                    setState(() {
                      print(selected);
                    });
                  }),
              Container(
                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.grey),
                // // color: ColorManager.primaryDark,
                // width: AppSize.s130,
                // height: AppSize.s43,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width* 0.7,
                    child: Text(
                      text,
                      overflow: TextOverflow.clip,
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 6,
        ),
      ],
    );
  }
}
