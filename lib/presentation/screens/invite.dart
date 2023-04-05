import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/utils/helpers.dart';

import 'package:share/share.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class Invite extends StatefulWidget {
  @override
  State<Invite> createState() => _InviteState();
}

class _InviteState extends State<Invite> with Helpers {


  void shareLink(BuildContext context, String link) {
    Share.share(link, subject: 'Check out this link');
  }

  var isLoading = false;
  var refCode = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: AppSize.s9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.invite1,
                    style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s24),
                  ),
                  Spacer(),
                ],
              ),
              // SizedBox(
              //   height: AppSize.s12,
              // ),
              Image.asset(
                'assets/images/invite.png',
                // fit: BoxFit.fill,
                height: 225,
                width: 225,
              ),
              // SizedBox(
              //   height: AppSize.s1,
              // ),
              // Text(
              //   'Give 25% Off Get 25% Off',
              //   style: getSemiBoldStyle(
              //       color: ColorManager.primaryDark, fontSize: FontSize.s20),
              // ),
              // Text(
              //   'For Every Friend Who Places Their First Order',
              //   style: getSemiBoldStyle(
              //       color: ColorManager.primaryDark, fontSize: FontSize.s14),
              // ),
              SizedBox(
                height: AppSize.s12,
              ),
              Padding(
                padding: EdgeInsets.all(1),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xff7FA5A4).withOpacity(0.2),
                              // border: Border.all(
                              //   color: Color(0xff7FA5A4),
                              // ),
                            ),
                            child: Image.asset('assets/images/icons1.png',
                                width: 38, height: 38),
                          ),
                          SizedBox(
                            height: AppSize.s8,
                          ),
                          Text(
                            AppLocalizations.of(context)!.send_invite,
                            style: getSemiBoldStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s14),
                          )
                        ],
                      ),
                      // Container(
                      //   width: 20,
                      //   height: 2,
                      //   decoration: BoxDecoration(color: Color(0xff125051),border: Border.all()),
                      // ),
                      Column(
                        children: [
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: MediaQuery.of(context).size.width * 0.1,
                            lineThickness: 2.0,
                            dashLength: 2.0,
                            dashColor: Colors.black,
                            // dashGradient: [Colors.red, Colors.blue],
                            dashRadius: 0.0,
                            dashGapLength: 2.0,
                            dashGapColor: Colors.transparent,
                            dashGapGradient: [Colors.white, Colors.white],
                            dashGapRadius: 0.0,
                          ),
                          SizedBox(
                            height: AppSize.s55,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xff7FA5A4).withOpacity(0.2),
                              // border: Border.all(
                              //   color: Color(0xff7FA5A4),
                              // ),
                            ),
                            child: Image.asset('assets/images/icons2.png',
                                width: 38, height: 38),
                          ),
                          SizedBox(
                            height: AppSize.s8,
                          ),
                          Container(
                            width: AppSize.s110,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .family_friend_download_ghaf,
                              textAlign: TextAlign.center,
                              style: getSemiBoldStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s14),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: MediaQuery.of(context).size.width * 0.1,
                            lineThickness: 2.0,
                            dashLength: 2.0,
                            dashColor: Colors.black,
                            // dashGradient: [Colors.red, Colors.blue],
                            dashRadius: 0.0,
                            dashGapLength: 2.0,
                            dashGapColor: Colors.transparent,
                            dashGapGradient: [Colors.white, Colors.white],
                            dashGapRadius: 0.0,
                          ),
                          SizedBox(
                            height: AppSize.s55,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xff7FA5A4).withOpacity(0.2),
                              // border: Border.all(
                              //   color: Color(0xff7FA5A4),
                              // ),
                            ),
                            child: Image.asset('assets/images/icons3.png',
                                width: 38, height: 38),
                          ),
                          SizedBox(
                            height: AppSize.s8,
                          ),
                          Container(
                            width: AppSize.s92,
                            child: Text(
                              AppLocalizations.of(context)!.place_the_first_order,
                              textAlign: TextAlign.center,
                              style: getSemiBoldStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s60,
              ),
              Container(
                width: AppSize.s222,
                child: Text(
                  AppLocalizations.of(context)!
                      .invite_family_and_friends_to_earn_reward_points,
                  textAlign: TextAlign.center,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s18),
                ),
              ),
              SizedBox(
                height: AppSize.s60,
              ),
              Text(
                AppLocalizations.of(context)!.terms_and_conditions,
                textAlign: TextAlign.center,
                style: getMediumStyle(
                    color: ColorManager.primary, fontSize: FontSize.s18),
              ),
              SizedBox(
                height: AppSize.s60,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: AppSize.s44,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(ColorManager.primaryDark)),
                    onPressed: () {
                      // showInviteSheet(context);
                      shareLink(context, 'https://example.com');
                    },
                    child: Text(AppLocalizations.of(context)!.invite)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
