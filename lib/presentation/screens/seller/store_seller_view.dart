import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/constants.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../about_app_view.dart';

class StoreSellerView extends StatefulWidget {
  const StoreSellerView({Key? key}) : super(key: key);

  @override
  State<StoreSellerView> createState() => _StoreSellerViewState();
}

class _StoreSellerViewState extends State<StoreSellerView> with Helpers {

  var isLoading = true;

  void _contactEmail() async {
    launch("mailto:info@ghafgate.com");
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  void initState() {
    Provider.of<SellerProvider>(context, listen: false).getUserDetails().then((value) => isLoading = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<SellerProvider>(context).userDetails;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: isLoading ? Center(
              child: Container(
                width: 20.h,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppSize.s9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.account,
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s24),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Image.asset(
                  ImageAssets.store,
                  height: AppSize.s86,
                  width: AppSize.s86,
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Text(
                  '${userDetails['firstName']} ${userDetails['lastName']}',
                  style: getSemiBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s20),
                ),
                SizedBox(
                  height: AppSize.s40,
                ),
                Row(
                  children: [
                    // Image.asset(
                    //   IconsAssets.wallet1,
                    //   height: AppSize.s28,
                    //   width: AppSize.s28,
                    // ),
                    Text(
                      'User Name',
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark, fontSize: FontSize.s16),
                    ),
                    SizedBox(
                      width: AppSize.s60,
                    ),
                    Text(
                      userDetails['userName'],
                      style: getSemiBoldStyle(
                          color: ColorManager.primary, fontSize: FontSize.s16),
                    ),
                    // Spacer(),
                    // Text(
                    //   '100 AED',
                    //   style: getSemiBoldStyle(
                    //       color: ColorManager.greyLight,
                    //       fontSize: FontSize.s16),
                    // ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                  child: Divider(
                    color: ColorManager.greyLight,
                    height: AppSize.s1,
                  ),
                ),

                Row(
                  children: [
                    // Image.asset(
                    //   IconsAssets.wallet1,
                    //   height: AppSize.s28,
                    //   width: AppSize.s28,
                    // ),
                    Text(
                      'Email',
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark, fontSize: FontSize.s16),
                    ),
                    SizedBox(
                      width: AppSize.s60,
                    ),
                    Text(
                      userDetails['email'],
                      style: getSemiBoldStyle(
                          color: ColorManager.primary, fontSize: FontSize.s16),
                    ),

                  ],
                ),

                SizedBox(
                  height: AppSize.s40,
                ),
                Row(
                  children: [
                    // Image.asset(
                    //   IconsAssets.wallet1,
                    //   height: AppSize.s28,
                    //   width: AppSize.s28,
                    // ),
                    Text(
                      'Telephone',
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark, fontSize: FontSize.s16),
                    ),
                    SizedBox(
                      width: AppSize.s60,
                    ),
                    Text(
                      userDetails['telephone'],
                      style: getSemiBoldStyle(
                          color: ColorManager.primary, fontSize: FontSize.s16),
                    ),
                    // Spacer(),
                    // Text(
                    //   '100 AED',
                    //   style: getSemiBoldStyle(
                    //       color: ColorManager.greyLight,
                    //       fontSize: FontSize.s16),
                    // ),
                  ],
                ),
                SizedBox(
                  height: AppSize.s40,
                ),
                Row(
                  children: [
                    // Image.asset(
                    //   IconsAssets.wallet1,
                    //   height: AppSize.s28,
                    //   width: AppSize.s28,
                    // ),
                    Text(
                      'Subscribe',
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark, fontSize: FontSize.s16),
                    ),
                    SizedBox(
                      width: AppSize.s60,
                    ),
                    userDetails['sellerSubmittedForm'] ? Text(
                      'Subscribed',
                      style: getSemiBoldStyle(
                          color: ColorManager.primary, fontSize: FontSize.s16),
                    ) : Text(
                      'Unsubscribed',
                      style: getSemiBoldStyle(
                          color: ColorManager.primary, fontSize: FontSize.s16),
                    ),
                    // Spacer(),
                    // Text(
                    //   '100 AED',
                    //   style: getSemiBoldStyle(
                    //       color: ColorManager.greyLight,
                    //       fontSize: FontSize.s16),
                    // ),
                  ],
                ),
                SizedBox(
                  height: AppSize.s40,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => AboutAppView()),
                      );
                    },
                    child: accountWidget(
                      context,
                      IconsAssets.about,
                      AppLocalizations.of(context)!.about_the_app,
                    )),

                GestureDetector(
                  onTap: () {
                    // info@ghafgate.com
                    //send from email
                    _contactEmail();
                  },
                  child: accountWidget(
                    context,
                    IconsAssets.help,
                    AppLocalizations.of(context)!.get_help,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                //   child: Divider(
                //     color: ColorManager.greyLight,
                //     height: AppSize.s1,
                //   ),
                // ),
                // Row(
                //   children: [
                //     Image.asset(
                //       IconsAssets.offers1,
                //       height: AppSize.s28,
                //       width: AppSize.s28,
                //     ),
                //     SizedBox(
                //       width: AppSize.s24,
                //     ),
                //     Text(
                //       AppLocalizations.of(context)!.catalog,
                //       style: getSemiBoldStyle(
                //           color: ColorManager.primary, fontSize: FontSize.s16),
                //     ),
                //     Spacer(),
                //     Transform(
                //       transform: Matrix4.rotationY(math.pi),
                //       child: Image.asset(
                //         IconsAssets.arrow,
                //         height: AppSize.s28,
                //         width: AppSize.s28,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: AppSize.s16,
                ),
                Divider(
                  color: ColorManager.greyLight,
                  height: AppSize.s1,
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding accountWidget(
      BuildContext context,
      String icon,
      String title, {
        String? subTitle,
        bool isVector = false,
        IconData? iconName,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p22),
      child: Row(
        children: [
          iconName == null
              ? isVector
              ? SvgPicture.asset(
            '${Constants.vectorsPath}$icon.svg',
            width: AppSize.s24,
            height: AppSize.s24,
            color: ColorManager.primary,
          )
              : Image.asset(
            icon,
            height: AppSize.s24,
            width: AppSize.s24,
          )
              : Icon(
            iconName,
            color: ColorManager.primary,
          ),
          SizedBox(
            width: AppSize.s8,
          ),
          Text(
            title,
            style: getRegularStyle(
              color: ColorManager.primaryDark,
              fontSize: FontSize.s16,
            ),
          ),
          Spacer(),
          Text(
            subTitle ?? '',
            style: getRegularStyle(
              color: ColorManager.grey,
              fontSize: FontSize.s14,
            ),
          ),
        ],
      ),
    );
  }
}
