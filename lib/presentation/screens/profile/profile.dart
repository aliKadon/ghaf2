import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/screens/profile/notification/notification_view.dart';
import 'package:ghaf_application/presentation/screens/profile/change_email.dart';
import 'package:ghaf_application/presentation/screens/profile/password_setting.dart';
import 'package:ghaf_application/presentation/screens/profile/profile_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/profile/profile_setting/profile_setting.dart';
import 'package:ghaf_application/presentation/screens/profile/profile_setting/profile_setting_getx_controller.dart';
import 'package:provider/provider.dart';

import '../../../app/constants.dart';
import '../../../app/get/language_getx_controller.dart';
import '../../../app/utils/app_shared_data.dart';
import '../../../providers/language_provider.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../login_view/login_view.dart';
import '../main_view.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var language = SharedPrefController().lang1;

  final LanguageGetXController languageGetXController =
  Get.find<LanguageGetXController>();
  final ProfileGetxController _profileGetxController =
  Get.put<ProfileGetxController>(ProfileGetxController());

  Locale? local;
 late final curLocale = Provider.of<LocaleProvider>(context, listen: false);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSize.s8),
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s20,
            ),
            Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //     builder: (context) => MainView()));
                    },
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
                    AppLocalizations.of(context)!.profile,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            // SizedBox(
            //   height: AppSize.s8,
            // ),
            Divider(
              thickness: 1,
              color: ColorManager.greyLight,
            ),
            AppSharedData.currentUser == null?Container():    Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p16),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.grey,
                    blurRadius: AppSize.s2,
                    offset: Offset(AppSize.s0, AppSize.s2), // Shadow position
                  ),
                ],
              ),

              //
              // AppSharedData.currentUser == null
              //     ? GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).pushReplacement(MaterialPageRoute(
              //       builder: (context) => LoginView(role: 'Customer'),));
              //   },


              child: Column(
                children: [
                  AppSharedData.currentUser == null?Container():        GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileSetting(),));
                    },
                    child: accountWidget(
                        context,
                        language == 'en'
                            ? IconsAssets.arrow2
                            : IconsAssets.arrow,
                        AppLocalizations.of(context)!.account_info),
                  ),
                  // GestureDetector(
                  //   onTap: (){
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => ChangeEmail(),));
                  //   },
                  //   child: accountWidget(
                  //       context,
                  //       language == 'en'
                  //           ? SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,2
                  //           : SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                  //       AppLocalizations.of(context)!.change_email),
                  // ),
                  AppSharedData.currentUser == null?Container():     GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PasswordSetting(isSeller: false),));
                    },
                    child: accountWidget(
                        context,
                        language == 'en'
                            ? IconsAssets.arrow2
                            : IconsAssets.arrow,
                        AppLocalizations.of(context)!.change_password),
                  ),

                ],
              ),
            ),

            AppSharedData.currentUser == null?SizedBox(height: AppSize.s40,):Container(),
            AppSharedData.currentUser == null
                ? GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginView(role: 'Customer'),));
                },
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: getSemiBoldStyle(
                    color: ColorManager.grey,
                    fontSize: FontSize.s20,
                  ),
                )):Container(),

            AppSharedData.currentUser == null?SizedBox(height: AppSize.s10,):Container(),
            AppSharedData.currentUser == null?Container():      SizedBox(
              height: AppSize.s20,
            ),
            AppSharedData.currentUser == null?Container():   Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p16),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.grey,
                    blurRadius: AppSize.s2,
                    offset: Offset(AppSize.s0, AppSize.s2), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NotificationView(),));
                    },
                    child: accountWidget(
                        context,
                        language == 'en'
                            ? IconsAssets.arrow2
                            : IconsAssets.arrow,
                        AppLocalizations.of(context)!.notifications),
                  ),
                ],
              ),
            ),
            AppSharedData.currentUser == null?Container():    SizedBox(
              height: AppSize.s20,
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
                    offset: Offset(AppSize.s0, AppSize.s2), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap:(){
                      _customDialogLanguage(context);
                    },
                    child: accountWidget(
                        context,
                        language == 'en'
                            ? IconsAssets.arrow2
                            : IconsAssets.arrow,
                        AppLocalizations.of(context)!.language),
                  ),
                  AppSharedData.currentUser == null?Container():        GestureDetector(
                    onTap: () {
                      _profileGetxController.deleteAccount(context: context);
                    },
                    child: accountWidget(
                        context,
                        language == 'en'
                            ? IconsAssets.arrow2
                            : IconsAssets.arrow,
                        AppLocalizations.of(context)!.delete_account),
                  ),
                ],
              ),
            ),
          ],
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
          // SizedBox(
          //   width: AppSize.s8,
          // ),
          Text(
            title,
            style: getMediumStyle(
              color: ColorManager.primaryDark,
              fontSize: FontSize.s16,
            ),
          ),

          Text(
            subTitle ?? '',
            style: getRegularStyle(
              color: ColorManager.grey,
              fontSize: FontSize.s14,
            ),
          ),
          Spacer(),
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
            height: AppSize.s20,
            width: AppSize.s20,
            color: ColorManager.primary,
          )
              : Icon(
            iconName,
            color: ColorManager.primary,
          ),
        ],
      ),
    );
  }

  void _customDialogLanguage(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s146,
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
                      height: AppSize.s12,
                    ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.language,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s24),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    GestureDetector(
                      onTap: (){
                        languageGetXController.changeLanguage(language1: 'en');
                        curLocale.setLocale( Locale('en'));
                        print(SharedPrefController().lang1);
                        SharedPrefController().changeLanguage(language: 'en');
                        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
                      },
                      child: Row(
                        children: [
                          Text(AppLocalizations.of(context)!.english,
                        style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s16),
                          ),
                          Spacer(),
                          SharedPrefController().lang1 == 'en'?   Icon(Icons.check,color: ColorManager.primary,):Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    GestureDetector(
                      onTap: (){
                        languageGetXController.changeLanguage(language1: 'ar');
                        curLocale.setLocale(Locale('ar'));
                        SharedPrefController().changeLanguage(language: 'ar');
                        print(SharedPrefController().lang1);
                        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
                      },
                      child: Row(
                        children: [
                          Text(AppLocalizations.of(context)!.arabic,
                            style: getMediumStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s16),
                          ),
                          Spacer(),
                          SharedPrefController().lang1 == 'ar'?   Icon(Icons.check,color: ColorManager.primary,):Container(),
                        ],
                      ),
                    ),

                  ]),
            ),
          );
        });
  }
}
