import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/constants.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../about_app_view.dart';
import '../account_view/account_view_getx_controller.dart';

class StoreSellerView extends StatefulWidget {
  const StoreSellerView({Key? key}) : super(key: key);

  @override
  State<StoreSellerView> createState() => _StoreSellerViewState();
}

class _StoreSellerViewState extends State<StoreSellerView> with Helpers {

  late final AccountViewGetXController _accountViewGetXController =
  Get.put(AccountViewGetXController());

  var isLoading = true;

  void _contactEmail() async {
    launch("mailto:info@ghafgate.com");
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  // @override
  // void initState() {
  //
  //   super.initState();
  // }
  @override
  void didChangeDependencies() {
    Provider.of<SellerProvider>(context).getUserDetails().then((value) => isLoading = false);
    super.didChangeDependencies();
  }

  late var userDetails = Provider.of<SellerProvider>(context).userDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading ? Center(
          child: Container(
            width: 20.h,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
        ) : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppSize.s9,
                ),
                Text(
                  AppLocalizations.of(context)!.account,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s24),
                ),
                SizedBox(
                  height: AppSize.s50,
                ),
                Text(
                  '${userDetails['firstName']} ${userDetails['lastName']}',
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s24),
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            // _accountViewGetXController.logout(context: context);
                            Navigator.of(context).pushNamed(Routes.updateSellerInfo);
                          },
                          child: Image.asset(
                            'assets/icons/editProfile.png',
                            color: ColorManager.primaryDark,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            fit: BoxFit.cover,
                            'assets/images/avatar_person.png',
                            height: AppSize.s154,
                            width: AppSize.s154,
                          ),
                        ),
                       SizedBox(
                         width: 15,
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           FittedBox(fit: BoxFit.scaleDown,
                             child: Text(
                               userDetails['userName'],
                               style: getSemiBoldStyle(
                                   color: ColorManager.primary, fontSize: FontSize.s16),
                             ),
                           ),
                           SizedBox(height: 4,),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child:  Text(
                              userDetails['telephone'],
                              style: getSemiBoldStyle(
                                  color: ColorManager.primary, fontSize: FontSize.s14),
                            ),
                          ),
                         ],

                       ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(fit: BoxFit.scaleDown,
                      child: Text(
                        userDetails['email'],
                        style: getSemiBoldStyle(
                            color: ColorManager.primary, fontSize: FontSize.s16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: AppSize.s73
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
                GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (builder) => AboutAppView()),
                      // );
                      Navigator.of(context)
                          .pushNamed(Routes.languageStore);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.language, color: ColorManager.primary),
                        SizedBox(
                          width: AppSize.s8,
                        ),
                        Text(
                          AppLocalizations.of(context)!.language,
                          style: getRegularStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s16,
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: AppSize.s50
                ),
                GestureDetector(
                    onTap: () {
                      _accountViewGetXController.logout(context: context);
                    },
                    child: Column(
                      children: [
                        Icon(Icons.logout, color: ColorManager.primary,size: 40,),
                        SizedBox(
                          height: AppSize.s8,
                        ),
                        Text(
                          // AppLocalizations.of(context)!.language,
                          AppLocalizations.of(context)!.logout,
                          style: TextStyle(
                            color: ColorManager.red,
                            fontSize: FontSize.s24,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    )),
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
