import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/screens/about_app_view.dart';
import 'package:ghaf_application/presentation/screens/account_view/account_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/get_help/get_help_screen.dart';
import 'package:ghaf_application/presentation/screens/home_view/home_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/my_wallet_new.dart';
import 'package:ghaf_application/presentation/screens/notifications/notifications_screen_new.dart';
import 'package:ghaf_application/presentation/screens/offers/offers_screen_new.dart';
import 'package:ghaf_application/presentation/screens/orders/orders_screen.dart';
import 'package:ghaf_application/presentation/screens/pay_later/pay_later_view_new.dart';
import 'package:ghaf_application/presentation/screens/profile/profile.dart';
import 'package:ghaf_application/presentation/screens/rewards/rewards_view_new.dart';
import 'package:ghaf_application/presentation/screens/sell_with_us/sell_with_us_screen.dart';
import 'package:ghaf_application/presentation/screens/vouchers/vouchers.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  var language = SharedPrefController().lang1;

  // // controller.
  // late final ProfileSettingGetxController _profileSettingGetxController =
  // Get.put(ProfileSettingGetxController());

  // controller.
  late final AccountViewGetXController _accountViewGetXController =
      Get.put(AccountViewGetXController());
  late final HomeViewGetXController _homeViewGetXController =
      Get.put(HomeViewGetXController());

  var subscribe = '';

  @override
  void initState() {
    _accountViewGetXController.getSocialMediaAccounts(context: context);
    _homeViewGetXController.getRegStatus(context: context);
    super.initState();
    if (AppSharedData.currentUser == null) {
      subscribe = '';
    }
    if (AppSharedData.currentUser?.ghafGold == false) {
      subscribe = 'Unsubscribe';
    }
    if (AppSharedData.currentUser?.ghafGold == true) {
      subscribe = 'Subscribe';
    }
  }

  void _contactEmail() async {
    launch("mailto:info@ghafgate.com");
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  void dispose() {
    Get.delete<AccountViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.account,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s18,
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Divider(height: 1, color: ColorManager.greyLight),
                SizedBox(
                  height: AppSize.s12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: language == 'en'
                      ? Stack(
                          children: [
                            ClipPath(
                              // clipBehavior: Clip.antiAliasWithSaveLayer,
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(500)))),
                              child: Container(
                                // width: double.infinity,
                                width: MediaQuery.of(context).size.width * 0.6,
                                color: ColorManager.primary,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.6,
                              top: MediaQuery.of(context).size.width * 0.09,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: AppSize.s20,
                                  ),
                                  Text(
                                    '${AppSharedData.currentUser?.firstName ?? AppLocalizations.of(context)!.hello_welcome} ${AppSharedData.currentUser?.lastName ?? ''}',
                                    style: getSemiBoldStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
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
                                            builder: (context) => Profile(),
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
                                          bottomLeft: Radius.circular(500)))),
                              child: Container(
                                // width: double.infinity,
                                width: MediaQuery.of(context).size.width * 0.6,
                                color: ColorManager.primary,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                              ),
                            ),
                            Positioned(
                              right: MediaQuery.of(context).size.width * 0.6,
                              top: MediaQuery.of(context).size.width * 0.09,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  Text(
                                    '${AppSharedData.currentUser?.firstName ?? AppLocalizations.of(context)!.hello_welcome} ${AppSharedData.currentUser?.lastName ?? ''}',
                                    style: getSemiBoldStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
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
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // _accountViewGetXController.logout(context: context);
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => Profile(),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.028,
                ),
                AppSharedData.currentUser == null
                    ? Container()
                    : Container(
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => RewardsViewNew()),
                                );
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) => CancellingOrderScreen(),));
                              },
                              child: accountWidget(
                                context,
                                IconsAssets.rewards,
                                AppLocalizations.of(context)!.rewards,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: accountWidget(context, IconsAssets.start1,
                                  AppLocalizations.of(context)!.ghaf_gold,
                                  // subscribe,
                                  subTitle: subscribe),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.pushNamed(context, Routes.addressesRoute);
                            //   },
                            //   child: accountWidget(
                            //     context,
                            //     IconsAssets.location1,
                            //     AppLocalizations.of(context)!.address,
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, Routes.OrdersHistoryRoute);
                                // _customDialogProgress();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrdersScreen(),
                                ));
                              },
                              child: accountWidget(
                                context,
                                IconsAssets.note,
                                // 'Orders History',
                                AppLocalizations.of(context)!.order_history,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => MyWalletNew()),
                                );
                              },
                              child: accountWidget(
                                context,
                                IconsAssets.wallet,
                                AppLocalizations.of(context)!.my_wallet,
                              ),
                              // subTitle: '120 AED'),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => PayLaterViewNew()),
                                );
                              },
                              child: accountWidget(
                                context,
                                IconsAssets.pay,
                                AppLocalizations.of(context)!.pay_later,
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.of(context).pushNamed(Routes.ordersToPay, arguments: 'orderTrack');
                            //   },
                            //   child: accountWidget(
                            //     context,
                            //     IconsAssets.location,
                            //     AppLocalizations.of(context)!.order_track,
                            //     // 'Order Track'
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OffersScreenNew(),
                                ));
                              },
                              child: accountWidget(
                                context,
                                IconsAssets.offers,
                                AppLocalizations.of(context)!.offers,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          NotificationsScreenNew()),
                                );
                              },
                              child: accountWidget(
                                context,
                                IconsAssets.notifications,
                                AppLocalizations.of(context)!.notifications,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, Routes.gifts);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Vouchers(),
                                ));
                              },
                              child: accountWidget(
                                context,
                                IconsAssets.vouchers,
                                AppLocalizations.of(context)!.vouchers,
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (builder) => CouponsView()),
                            //     );
                            //   },

                            // ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    AppLocalizations.of(context)!.support,
                    style: getRegularStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p10, vertical: AppPadding.p16),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.grey,
                        blurRadius: AppSize.s2,
                        offset:
                            Offset(AppSize.s0, AppSize.s2), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AppSharedData.currentUser == null
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                // info@ghafgate.com
                                //send from email
                                // _contactEmail();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GetHelpScreen(),
                                ));
                              },
                              child: accountWidget(
                                context,
                                IconsAssets.help,
                                AppLocalizations.of(context)!.get_help,
                              ),
                            ),
                      // GestureDetector(
                      //   onTap: () {
                      //     // Navigator.pushNamed(context, Routes.rateUs);
                      //     // Navigator.of(context).push(MaterialPageRoute(
                      //     //   builder: (context) => RateDelivery(),
                      //     // ));
                      //   },
                      //   child: accountWidget(
                      //     context,
                      //     'star',
                      //     // 'Rate Us',
                      //     AppLocalizations.of(context)!.rate_us,
                      //     isVector: true,
                      //   ),
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pushNamed(
                      //         context, Routes.forgetPasswordRoute);
                      //   },
                      //   child: accountWidget(
                      //     context,
                      //     '',
                      //     // 'Forgot Password',
                      //     AppLocalizations.of(context)!.forget_password,
                      //     iconName: CupertinoIcons.lock_fill,
                      //   ),
                      // ),
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
                            Navigator.of(context)
                                .pushNamed(Routes.inviteScreen);
                          },
                          child: accountWidget(
                            context,
                            IconsAssets.share,
                            AppLocalizations.of(context)!.invite_friend,
                          )),
                      _homeViewGetXController.regStatus.status!
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => SellWithUsScreen()),
                                );
                              },
                              child: accountWidget(
                                context,
                                IconsAssets.sell,
                                AppLocalizations.of(context)!.sell_with_us,
                              ))
                          : Container(),
                      // GestureDetector(
                      //     onTap: () {
                      //       // Navigator.push(
                      //       //   context,
                      //       //   MaterialPageRoute(
                      //       //       builder: (builder) => AboutAppView()),
                      //       // );
                      //       // Navigator.of(context)
                      //       //     .pushReplacementNamed(Routes.language);
                      //     },
                      //     child: Row(
                      //       children: [
                      //         Icon(Icons.language, color: ColorManager.primary),
                      //         SizedBox(
                      //           width: AppSize.s8,
                      //         ),
                      //         Text(
                      //           AppLocalizations.of(context)!.language,
                      //           style: getRegularStyle(
                      //             color: ColorManager.primaryDark,
                      //             fontSize: FontSize.s16,
                      //           ),
                      //         ),
                      //       ],
                      //     )),
                      SizedBox(
                        height: AppSize.s14,
                      ),
                    ],
                  ),

                ),

                AppSharedData.currentUser == null ? Container() : Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 30),
                      child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (builder) => AboutAppView()),
                            // );
                            _accountViewGetXController.logout(context: context);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.logout,
                                color: ColorManager.primary,
                                size: AppSize.s30,
                              ),
                              SizedBox(
                                width: AppSize.s8,
                              ),
                              Text(
                                // AppLocalizations.of(context)!.language,
                                '${AppLocalizations.of(context)!.logout}',
                                style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: FontSize.s16),
                              ),
                            ],
                          )),
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

  // Padding accountWidget1(
  //     BuildContext context,
  //     IconData icon,
  //     String title, {
  //       String? subTitle,
  //       bool isVector = false,
  //       IconData? iconName,
  //     }) {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: AppPadding.p22),
  //     child: Row(
  //       children: [
  //         iconName == null
  //             ? isVector
  //             ? SvgPicture.asset(
  //           '${Constants.vectorsPath}$icon.svg',
  //           width: AppSize.s24,
  //           height: AppSize.s24,
  //           color: ColorManager.primary,
  //         )
  //             : Image.asset(
  //           icon,
  //           height: AppSize.s24,
  //           width: AppSize.s24,
  //         )
  //             : Icon(
  //           iconName,
  //           color: ColorManager.primary,
  //         ),
  //         SizedBox(
  //           width: AppSize.s8,
  //         ),
  //         Text(
  //           title,
  //           style: getRegularStyle(
  //             color: ColorManager.primaryDark,
  //             fontSize: FontSize.s16,
  //           ),
  //         ),
  //         Spacer(),
  //         Text(
  //           subTitle ?? '',
  //           style: getRegularStyle(
  //             color: ColorManager.grey,
  //             fontSize: FontSize.s14,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _customDialogProgress() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           child: Container(
  //             height: AppSize.s258,
  //             width: AppSize.s258,
  //             padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
  //             decoration: BoxDecoration(
  //               color: ColorManager.white,
  //               borderRadius: BorderRadius.circular(AppRadius.r8),
  //             ),
  //             child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   SizedBox(
  //                     height: AppSize.s28,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Image.asset(
  //                         ImageAssets.logo2,
  //                         height: AppSize.s40,
  //                         width: AppSize.s40,
  //                       ),
  //                       SizedBox(
  //                         width: AppSize.s20,
  //                       ),
  //                       Text(
  //                         AppLocalizations.of(context)!.ghaf,
  //                         style: getMediumStyle(
  //                             color: ColorManager.primary,
  //                             fontSize: FontSize.s20),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: AppSize.s40,
  //                   ),
  //                   Container(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       AppLocalizations.of(context)!
  //                           .are_you_sure_cancel_your_subscription,
  //                       textAlign: TextAlign.center,
  //                       style: getMediumStyle(
  //                           color: ColorManager.primaryDark,
  //                           fontSize: FontSize.s20),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: AppSize.s20,
  //                   ),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         child: GestureDetector(
  //                           onTap: () => Navigator.pop(context),
  //                           child: Container(
  //                             width: AppSize.s110,
  //                             height: AppSize.s38,
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               color: ColorManager.primaryDark,
  //                               borderRadius:
  //                                   BorderRadius.circular(AppRadius.r8),
  //                             ),
  //                             child: Text(
  //                               AppLocalizations.of(context)!.yes,
  //                               textAlign: TextAlign.center,
  //                               style:
  //                                   getMediumStyle(color: ColorManager.white),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: AppSize.s6,
  //                       ),
  //                       Expanded(
  //                         child: GestureDetector(
  //                           onTap: () => Navigator.pop(context),
  //                           child: Container(
  //                             width: AppSize.s110,
  //                             height: AppSize.s38,
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               color: ColorManager.white,
  //                               borderRadius:
  //                                   BorderRadius.circular(AppRadius.r8),
  //                               border: Border.all(
  //                                   color: ColorManager.primaryDark,
  //                                   width: AppSize.s1),
  //                             ),
  //                             child: Text(
  //                               AppLocalizations.of(context)!.no,
  //                               textAlign: TextAlign.center,
  //                               style: getMediumStyle(
  //                                   color: ColorManager.primaryDark),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //
  //
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: AppSize.s12,
  //                   ),
  //                 ]),
  //           ),
  //         );
  //       });
  // }

  void _customDialogProgress(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s280,
              width: AppSize.s360,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${AppLocalizations.of(context)!.invite_friend}',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
                      ),
                    ),

                    Padding(
                        padding: EdgeInsets.only(left: AppSize.s22),
                      child: Text(
                        '${AppLocalizations.of(context)!.invite_your_friend} \n ${AppLocalizations.of(context)!.and_earn_points}',
                        style: TextStyle(fontSize: AppSize.s24),
                      ),
                    ),
                    // Text('Your favorites food\ndelivered at your doorstep',style: TextStyle(fontSize: AppSize.s14),),
                    // Text('Order food to be delivered\n\tor schedule delivery time',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('Schedule your food order in advance',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for breakfast ',style: TextStyle(fontSize: AppSize.s18),),
                    // Text('What do you like for dinner ',style: TextStyle(fontSize: AppSize.s16),),
                    // Text('What do you like for lunch ',style: TextStyle(fontSize: AppSize.s14),),
                    SizedBox(
                      height: AppSize.s10,
                    ),

                    SizedBox(
                      height: AppSize.s20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed(Routes.inviteScreen);
                      },
                      child: Container(
                        width: AppSize.s110,
                        height: AppSize.s38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryDark,
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          'Ok',
                          textAlign: TextAlign.center,
                          style: getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }
}
