import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../app/constants.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/app_text_field.dart';

class ReviewProduct extends StatefulWidget {
  final Map<String, dynamic> orderinfo;

  ReviewProduct(this.orderinfo);

  @override
  State<ReviewProduct> createState() => _ReviewProductState();
}

class _ReviewProductState extends State<ReviewProduct> {

  var rate = 0;

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
                SizedBox(
                  height: AppSize.s12,
                ),
                Image.asset(
                  '${Constants.imagesPath}reviewProduct.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  AppLocalizations.of(context)!.how_do_see_product,
                  style: getRegularStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                RatingBar.builder(
                  initialRating: 1,
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
                   rate = value.toInt();
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    // Text(
                    //   'Do you have notes to tell us?',
                    //   style: getRegularStyle(
                    //     color: ColorManager.primaryDark,
                    //     fontSize: FontSize.s14,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
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
                    onPressed: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .giveReviewForProduct(widget.orderinfo['item'], rate.toString())
                          .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(AppLocalizations.of(context)!.thank_you),
                                backgroundColor: Colors.green,
                              )))
                          .then((value) =>
                              Navigator.of(context).pushNamed(Routes.mainRoute))
                          .catchError((e) => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(e.toString()),
                                backgroundColor: Colors.red,
                              )));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.send_your_review,
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
