import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/screens/login_view/login_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';

import '../../../services/firebase_messaging_service.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';


final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with Helpers {
  // controller.
  late final LoginViewGetXController _loginViewGetXController =
  Get.find<LoginViewGetXController>();

  GoogleSignInAccount? _currentUser;


  @override
  void initState() {
    _loginViewGetXController.getLocation();
    _googleSignIn.onCurrentUserChanged.listen((event) {
      _currentUser = event;
    });
    super.initState();
  }


  // dispose.
  @override
  void dispose() {
    Get.delete<LoginViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _currentUser;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _loginViewGetXController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppSize.s9,
                ),
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s24),
                ),
                SizedBox(
                  height: AppSize.s31,
                ),
                Image.asset(
                  ImageAssets.logo2,
                  fit: BoxFit.fill,
                  height: AppSize.s138,
                  width: AppSize.s123,
                ),
                SizedBox(
                  height: AppSize.s32,
                ),
                AppTextField(
                  hint: AppLocalizations.of(context)!.user_name,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Username is required';
                    return null;
                  },
                  onSaved: (value) {
                    _loginViewGetXController.userName = value;
                  },
                ),
                AppTextField(
                  hint: AppLocalizations.of(context)!.hint_password,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Password is required';
                    return null;
                  },
                  onSaved: (value) {
                    _loginViewGetXController.password = value;
                  },
                  // onSubmitted: (){},
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.forgetPasswordRoute),
                  child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p16, vertical: AppPadding.p2),
                    child: Text(
                      AppLocalizations.of(context)!.forget_password,
                      style: getMediumStyle(
                          color: ColorManager.grey, fontSize: FontSize.s14),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s55,
                  child: ElevatedButton(
                    onPressed: _loginViewGetXController.login,
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                              color: ColorManager.greyLight,
                              height: AppSize.s1)),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: AppPadding.p24),
                        child: Text(
                          AppLocalizations.of(context)!.or,
                          style: getSemiBoldStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s14),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                              color: ColorManager.greyLight,
                              height: AppSize.s1)),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppSize.s8,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    border: Border.all(
                        width: AppSize.s1, color: ColorManager.greyLight),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      signinWithGoogle().then((value) =>
                          _showDialog());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.google,
                          fit: BoxFit.fill,
                          height: AppSize.s22,
                          width: AppSize.s28,
                        ),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        Text(
                          // AppLocalizations.of(context)!.login_with_google,
                          'Register with Google',
                          style: getRegularStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                  ),
                ),

                // Register with Apple
                // SizedBox(
                //   height: AppSize.s18,
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(
                //     horizontal: AppMargin.m16,
                //   ),
                //   width: double.infinity,
                //   height: AppSize.s50,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(AppRadius.r10),
                //     border: Border.all(
                //         width: AppSize.s1, color: ColorManager.greyLight),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Image.asset(
                //         ImageAssets.apple,
                //         fit: BoxFit.fill,
                //         height: AppSize.s22,
                //         width: AppSize.s28,
                //       ),
                //       SizedBox(
                //         width: AppSize.s10,
                //       ),
                //       Text(
                //         // AppLocalizations.of(context)!.login_with_apple,
                //         'Register with Apple',
                //         style: getRegularStyle(
                //             color: ColorManager.primaryDark,
                //             fontSize: FontSize.s14),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: AppSize.s23,
                ),
                Visibility(
                  visible: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.register_as_a,
                        style: getRegularStyle(
                            color: ColorManager.grey, fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        width: AppSize.s1,
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(
                                context, Routes.welcomeSellerRoute),
                        child: Text(
                          AppLocalizations.of(context)!.seller,
                          style: getExtraBoldStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Text(
                  AppLocalizations.of(context)!.i_do_not_have_account,
                  style: getRegularStyle(
                      color: ColorManager.grey, fontSize: FontSize.s16),
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.registerRoute),
                  child: Text(
                    AppLocalizations.of(context)!.create_account,
                    style: getExtraBoldStyle(
                        color: ColorManager.primary, fontSize: FontSize.s16),
                  ),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signinWithGoogle() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print('================================googleSignIn');
      print(e.toString());
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Chose Route'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.registerRoute,arguments: {
                  'role' : Constants.roleRegisterCustomer,
                });
                // Perform some action
                // Navigator.pop(context);
              },
              child: Text('Register as a Customer'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.registerRoute,arguments: {
                  'role' : Constants.roleRegisterSeller,
                });
                // Perform some action
                // Navigator.pop(context);
              },
              child: Text('Register as a Seller'),
            ),
            SimpleDialogOption(
              onPressed: () {
                print('==========================google UserName');
                print(_currentUser?.displayName);
                print(_currentUser?.email);
                SharedPrefController().setUserName(_currentUser?.displayName ?? 'User Name');
                SharedPrefController().setUserName(_currentUser?.email ?? 'Enter Email');
                Navigator.of(context).pushNamed(Routes.registerRoute,arguments: {
                  'role' : Constants.roleRegisterIndividual,
                });
                // Perform some action
                // Navigator.pop(context);
              },
              child: Text('Register as a Seller(individual)'),
            ),
          ],
        );
      },
    );
  }
}
