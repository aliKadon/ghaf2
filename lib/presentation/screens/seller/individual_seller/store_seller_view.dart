import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/items_list.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/profile_getx_controller/profile_controller.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/profile_seller.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/constants.dart';
import '../../../../app/preferences/shared_pref_controller.dart';
import '../../../../app/utils/app_shared_data.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import '../../account_view/account_view_getx_controller.dart';
import '../../profile/profile.dart';

class StoreSellerView extends StatefulWidget {
  const StoreSellerView({Key? key}) : super(key: key);

  @override
  State<StoreSellerView> createState() => _StoreSellerViewState();
}

class _StoreSellerViewState extends State<StoreSellerView> with Helpers {
  late final AccountViewGetXController _accountViewGetXController =
  Get.put(AccountViewGetXController());
  late final ProfileController _profileController =
  Get.put(ProfileController());

  var isLoading = true;
  var language = SharedPrefController().lang1;

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
    // Provider.of<SellerProvider>(context,listen: false)
    //     .getUserDetails()
    //     .then((value) => isLoading = false);
    _profileController.getSellerDetails(context: context);
    super.initState();
  }
  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  // late var userDetails = Provider
  //     .of<SellerProvider>(context)
  //     .userDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1,
                  child: language == 'en'
                      ? Stack(
                    children: [
                      ClipPath(
                        // clipBehavior: Clip.antiAliasWithSaveLayer,
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight:
                                    Radius.circular(500)))),
                        child: Container(
                          // width: double.infinity,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width *
                              0.6,
                          color: ColorManager.primary,
                          height:
                          MediaQuery
                              .of(context)
                              .size
                              .height *
                              0.15,
                        ),
                      ),
                      Positioned(
                        left: AppSize.s210,
                        top: AppSize.s24,
                        child: ClipOval(
                          // borderRadius: BorderRadius.circular(AppRadius.r14),
                          child: Image.asset(
                            ImageAssets.profile,
                            fit: BoxFit.cover,
                            height: AppSize.s82,
                            width: AppSize.s82,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(AppSize.s8),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppSize.s20,
                            ),
                            Text(
                              '${AppSharedData.currentUser?.firstName ??
                                  AppLocalizations.of(context)!
                                      .hello_welcome} ${AppSharedData
                                  .currentUser?.lastName ?? ''}',
                              style: getSemiBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .view_edit_profile,
                                  style: getRegularStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.03,
                                ),
                                InkWell(
                                  onTap: () {
                                    // _accountViewGetXController.logout(context: context);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ProfileSeller(),
                                    ));
                                  },
                                  child: Image.asset(
                                    ImageAssets.editProfile,
                                    width: AppSize.s20,
                                    height: AppSize.s20,
                                    color: ColorManager.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      : Stack(
                    children: [
                      ClipPath(
                        // clipBehavior: Clip.antiAliasWithSaveLayer,
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft:
                                    Radius.circular(500)))),
                        child: Container(
                          // width: double.infinity,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width *
                              0.6,
                          color: ColorManager.primary,
                          height:
                          MediaQuery
                              .of(context)
                              .size
                              .height *
                              0.15,
                        ),
                      ),
                      Positioned(
                        right: AppSize.s210,
                        top: AppSize.s24,
                        child: ClipOval(
                          // borderRadius: BorderRadius.circular(AppRadius.r14),
                          child: Image.asset(
                            ImageAssets.profile,
                            fit: BoxFit.cover,
                            height: AppSize.s82,
                            width: AppSize.s82,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(AppSize.s8),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppSize.s20,
                            ),
                            Text(
                              '${AppSharedData.currentUser?.firstName ??
                                  AppLocalizations.of(context)!
                                      .hello_welcome} ${AppSharedData
                                  .currentUser?.lastName ?? ''}',
                              style: getSemiBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .view_edit_profile,
                                  style: getRegularStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.03,
                                ),
                                InkWell(
                                  onTap: () {
                                    // _accountViewGetXController.logout(context: context);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ProfileSeller(),
                                    ));
                                  },
                                  child: Image.asset(
                                    ImageAssets.editProfile,
                                    width: AppSize.s20,
                                    height: AppSize.s20,
                                    color: ColorManager.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSize.s10,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.85,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p10,
                      vertical: AppPadding.p16),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.grey,
                        blurRadius: AppSize.s2,
                        offset: Offset(
                            AppSize.s0, AppSize.s2), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                          AppLocalizations.of(context)!
                              .account_information,
                          style: TextStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.email} : ',
                            style: TextStyle(fontSize: FontSize.s14),
                          ),
                          Text(
                            '${AppSharedData.currentUser?.email}',
                            style: TextStyle(
                                fontSize: FontSize.s14,
                                color: ColorManager.primaryDark),
                          )
                        ],
                      ),
                      SizedBox(height: AppSize.s14),
                      // Row(
                      //   children: [
                      //     Text(
                      //       '${AppLocalizations.of(context)!.subscription} : ',
                      //       style: TextStyle(fontSize: FontSize.s14),
                      //     ),
                      //     Text(
                      //       AppSharedData.currentUser!.email!,
                      //       style: TextStyle(
                      //           fontSize: FontSize.s14,
                      //           color: ColorManager.primaryDark),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.1),
                Container(
                  height: AppSize.s46,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) =>
                                ItemsList(),));
                      },
                      child: Text(AppLocalizations.of(context)!
                          .catalog)),
                ),
                SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.12),
                GestureDetector(
                    onTap: () {
                      _accountViewGetXController.logout(context: context);
                    },
                    child: Column(
                      children: [
                        Text(
                          // AppLocalizations.of(context)!.language,
                          AppLocalizations.of(context)!.logout,
                          style: TextStyle(
                              color: ColorManager.grey,
                              fontSize: FontSize.s24,
                              fontWeight: FontWeight.w500),
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

  Padding accountWidget(BuildContext context,
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
