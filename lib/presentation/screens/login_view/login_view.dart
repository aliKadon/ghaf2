import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/screens/login_view/login_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../main_view.dart';

// scopes: ['email'],
// clientId:
// '453527024227-n7pneahs3s6dd1ucjjpjfidem5sv3hnf.apps.googleusercontent.com'

class LoginView extends StatefulWidget {
  // LoginView({Key? key}) : super(key: key);
  final String role;

  LoginView({required this.role});

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with Helpers {
  // controller.
  late final LoginViewGetXController _loginViewGetXController =
      Get.put<LoginViewGetXController>(
          LoginViewGetXController(context: context));

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    // _googleSignIn.onCurrentUserChanged.listen((event) {
    //   _currentUser = event;
    // });
    super.initState();
  }

  // dispose.
  @override
  void dispose() {
    Get.delete<LoginViewGetXController>();
    super.dispose();
  }

  String userName = "User Name";
  String? email = "Your Email";

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _currentUser;
    return WillPopScope(
      onWillPop: () async {
        await SharedPrefController().logout();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainView(),
        ));
        return false;
      },
      child: Scaffold(
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
                    width: AppSize.s138,
                  ),
                  SizedBox(
                    height: AppSize.s32,
                  ),
                  AppTextField(
                    hint: AppLocalizations.of(context)!.userName_or_email,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return AppLocalizations.of(context)!
                            .userName_or_Email_is_required;
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
                        return AppLocalizations.of(context)!.password_is_required;
                      return null;
                    },
                    onSaved: (value) {
                      _loginViewGetXController.password = value;
                    },
                    // onSubmitted: (){},
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.forgetPasswordRoute,arguments: widget.role),
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
                      onPressed: () {
                        _loginViewGetXController.login(context: context);
                      },
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
                        signinWithGoogle().then((value) => _showDialog());
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
                            AppLocalizations.of(context)!.register_with_google,
                            style: getRegularStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s23,
                  ),
                  // Visibility(
                  //   visible: true,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         AppLocalizations.of(context)!.register_as_a,
                  //         style: getRegularStyle(
                  //             color: ColorManager.grey, fontSize: FontSize.s16),
                  //       ),
                  //       SizedBox(
                  //         width: AppSize.s1,
                  //       ),
                  //       GestureDetector(
                  //         onTap: () => Navigator.pushNamed(
                  //             context, Routes.welcomeSellerRoute),
                  //         child: Text(
                  //           AppLocalizations.of(context)!.seller,
                  //           style: getExtraBoldStyle(
                  //               color: ColorManager.primary,
                  //               fontSize: FontSize.s16),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: AppSize.s12,
                  // ),
                  Text(
                    AppLocalizations.of(context)!.i_do_not_have_account,
                    style: getRegularStyle(
                        color: ColorManager.grey, fontSize: FontSize.s16),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, Routes.registerRoute,
                        arguments: {
                          'role': widget.role,
                          'locationLat': 24.400661,
                          'locationLong': 54.635448,
                        }),
                    child: Text(
                      AppLocalizations.of(context)!.create_account,
                      style: getExtraBoldStyle(
                          color: ColorManager.primary, fontSize: FontSize.s16),
                    ),
                  ),
                  // SizedBox(
                  //   height: AppSize.s16,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signinWithGoogle() async {
    try {
      await widget._googleSignIn.signIn().then((value) {
        userName = value!.displayName!;
        email = value.email;
        print(email);
        print(userName);
      });
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
          title: Text(AppLocalizations.of(context)!.choose_route),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                SharedPrefController()
                    .setgoogleUserName(googleUserName: userName ?? 'User Name');
                SharedPrefController()
                    .setgoogleEmail(googleEmail: email ?? 'Enter Email')
                    .then((value) => Navigator.of(context).pushReplacementNamed(
                            Routes.registerRoute,
                            arguments: {
                              'role': Constants.roleRegisterCustomer,
                              'locationLat': 24.400661,
                              'locationLong': 54.635448,
                            }));
                // Perform some action
                // Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.register_as_customer),
            ),
            SimpleDialogOption(
              onPressed: () {
                SharedPrefController()
                    .setgoogleUserName(googleUserName: userName ?? 'User Name');
                SharedPrefController()
                    .setgoogleEmail(googleEmail: email ?? 'Enter Email')
                    .then((value) => Navigator.of(context).pushReplacementNamed(
                            Routes.registerRoute,
                            arguments: {
                              'role': Constants.roleRegisterSeller,
                              'locationLat': 24.400661,
                              'locationLong': 54.635448,
                            }));
                // Perform some action
                // Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.register_as_seller),
            ),
            SimpleDialogOption(
              onPressed: () {
                print('==========================google UserName');
                print(userName);
                print(email);
                SharedPrefController()
                    .setgoogleUserName(googleUserName: userName ?? 'User Name');
                SharedPrefController()
                    .setgoogleEmail(googleEmail: email ?? 'Enter Email')
                    .then((value) => Navigator.of(context)
                            .pushNamed(Routes.registerRoute, arguments: {
                          'role': Constants.roleRegisterIndividual,
                          'locationLat': 24.400661,
                          'locationLong': 54.635448,
                        }));
                // Perform some action
                // Navigator.pop(context);
              },
              child: Text(
                  AppLocalizations.of(context)!.register_as_seller_individual),
            ),
          ],
        );
      },
    );
  }
}
