import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../providers/seller_provider.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import '../widgets/app_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  final String role;

  RegistrationScreen(this.role);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var _form = GlobalKey();

  // void selectBirthDate({
  //   required BuildContext context,
  // }) async {
  //   DateTime? date = await showDatePicker(
  //     context: context,
  //     initialDate: birthDate == null
  //         ? DateTime(DateTime.now().year - 15)
  //         : DateTime.parse(birthDate!),
  //     firstDate: DateTime(DateTime.now().year - 50),
  //     lastDate: DateTime(DateTime.now().year - 15),
  //   );
  //   if (date == null) return;
  // }

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _phoneTextController;
  late TextEditingController _referralCodeTextController;
  late TextEditingController _boDTextController;
  late TextEditingController _lastnameController;
  late TextEditingController _userNameController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _lastnameController = TextEditingController();
    _userNameController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _referralCodeTextController = TextEditingController();
    _boDTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _confirmPasswordController.dispose();
    _lastnameController.dispose();
    _userNameController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _phoneTextController.dispose();
    _referralCodeTextController.dispose();
    _boDTextController.dispose();
    super.dispose();
  }

  var formRedister = {
    'firstName': '',
    'lastName': '',
    'userName': '',
    'Email': '',
    'password': '',
    'confirmPassword': '',
    'phoneNumber': '',
    'referralCode': '',
    'dateBirth': '',
  };

  var repo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppSize.s9,
                ),
                Text(
                  // AppLocalizations.of(context)!.getting_started,
                  AppLocalizations.of(context)!.getting_Started,
                  style: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: FontSize.s24),
                ),
                SizedBox(
                  height: AppSize.s31,
                ),
                Image.asset(
                  ImageAssets.logo2,
                  fit: BoxFit.fill,
                  height: AppSize.s92,
                  width: AppSize.s82,
                ),
                SizedBox(
                  height: AppSize.s32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        textController: _nameTextController,
                        hint: AppLocalizations.of(context)!.first_name,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return AppLocalizations.of(context)!.first_name_is_required;
                          return null;
                        },
                        onSaved: (value) {
                          // _registerViewGetXController.firstName = value;
                          formRedister = {
                            'firstName': value!,
                            'lastName': formRedister['lastName']!,
                            'userName': formRedister['userName']!,
                            'Email': formRedister['Email']!,
                            'password': formRedister['password']!,
                            'confirmPassword': formRedister['confirmPassword']!,
                            'phoneNumber': formRedister['phoneNumber']!,
                            'referralCode': formRedister['referralCode']!,
                            'dateBirth': formRedister['dateBirth']!,
                          };
                        },
                      ),
                    ),
                    Expanded(
                      child: AppTextField(
                        textController: _lastnameController,
                        hint: AppLocalizations.of(context)!.last_name,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return AppLocalizations.of(context)!.last_name_is_required;
                          return null;
                        },
                        onSaved: (value) {
                          // _registerViewGetXController.lastName = value;
                          formRedister = {
                            'firstName': formRedister['firstName']!,
                            'lastName': value!,
                            'userName': formRedister['userName']!,
                            'Email': formRedister['Email']!,
                            'password': formRedister['password']!,
                            'confirmPassword': formRedister['confirmPassword']!,
                            'phoneNumber': formRedister['phoneNumber']!,
                            'referralCode': formRedister['referralCode']!,
                            'dateBirth': formRedister['dateBirth']!,
                          };
                        },
                      ),
                    ),
                  ],
                ),
                AppTextField(
                  // hint: AppLocalizations.of(context)!.user_name,
                  textController: _userNameController,
                  hint: AppLocalizations.of(context)!.user_name,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppLocalizations.of(context)!.userName_or_Email_is_required;
                    return null;
                  },
                  onSaved: (value) {
                    // _registerViewGetXController.userName = value;
                    formRedister = {
                      'firstName': formRedister['firstName']!,
                      'lastName': formRedister['lastName']!,
                      'userName': value!,
                      'Email': formRedister['Email']!,
                      'password': formRedister['password']!,
                      'confirmPassword': formRedister['confirmPassword']!,
                      'phoneNumber': formRedister['phoneNumber']!,
                      'referralCode': formRedister['referralCode']!,
                      'dateBirth': formRedister['dateBirth']!,
                    };
                  },
                ),
                AppTextField(
                  // hint: AppLocalizations.of(context)!.hint_email_phone,
                  hint: AppLocalizations.of(context)!.hint_email_phone,
                  textController: _emailTextController,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppLocalizations.of(context)!.email_address_is_required;
                    return null;
                  },
                  onSaved: (value) {
                    // _registerViewGetXController.email = value;
                    formRedister = {
                      'firstName': formRedister['firstName']!,
                      'lastName': formRedister['lastName']!,
                      'userName': formRedister['userName']!,
                      'Email': value!,
                      'password': formRedister['password']!,
                      'confirmPassword': formRedister['confirmPassword']!,
                      'phoneNumber': formRedister['phoneNumber']!,
                      'referralCode': formRedister['referralCode']!,
                      'dateBirth': formRedister['dateBirth']!,
                    };
                  },
                ),
                AppTextField(
                  // hint: AppLocalizations.of(context)!.hint_password,
                  hint: AppLocalizations.of(context)!.hint_password,
                  textController: _passwordTextController,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppLocalizations.of(context)!.password_is_required;
                    return null;
                  },
                  onSaved: (value) {
                    // _registerViewGetXController.password = value;
                    formRedister = {
                      'firstName': formRedister['firstName']!,
                      'lastName': formRedister['lastName']!,
                      'userName': formRedister['userName']!,
                      'Email': formRedister['Email']!,
                      'password': value!,
                      'confirmPassword': formRedister['confirmPassword']!,
                      'phoneNumber': formRedister['phoneNumber']!,
                      'referralCode': formRedister['referralCode']!,
                      'dateBirth': formRedister['dateBirth']!,
                    };
                  },
                ),
                AppTextField(
                  hint: AppLocalizations.of(context)!.confirm_password,
                  textController: _confirmPasswordController,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppLocalizations.of(context)!.confirmed_password_is_required;
                    return null;
                  },
                  onSaved: (value) {
                    // _registerViewGetXController.confirmPassword = value;
                    formRedister = {
                      'firstName': formRedister['firstName']!,
                      'lastName': formRedister['lastName']!,
                      'userName': formRedister['userName']!,
                      'Email': formRedister['Email']!,
                      'password': formRedister['password']!,
                      'confirmPassword': value!,
                      'phoneNumber': formRedister['phoneNumber']!,
                      'referralCode': formRedister['referralCode']!,
                      'dateBirth': formRedister['dateBirth']!,
                    };
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p16,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                    decoration: InputDecoration(
                      // hintText: AppLocalizations.of(context)!.phone_number,
                      hintText: AppLocalizations.of(context)!.phone_number,
                      hintStyle: getMediumStyle(
                        color: ColorManager.hintTextFiled,
                      ),
                      filled: false,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: AppPadding.p18, horizontal: AppPadding.p4),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r10),
                        borderSide: BorderSide(
                          width: AppSize.s1,
                          color: ColorManager.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r10),
                        borderSide: BorderSide(
                          width: AppSize.s1,
                          color: ColorManager.grey,
                        ),
                      ),
                      prefixIcon: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: AppSize.s15,
                            ),
                            Image.asset(
                              ImageAssets.uaeFlag,
                              fit: BoxFit.fill,
                              height: AppSize.s34,
                              width: AppSize.s34,
                            ),
                            SizedBox(
                              width: AppSize.s15,
                            ),
                            Container(
                              height: double.infinity,
                              width: AppSize.s1,
                              color: ColorManager.grey,
                            ),
                            SizedBox(
                              width: AppSize.s15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    controller: _phoneTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return AppLocalizations.of(context)!.phone_number_is_required;
                      return null;
                    },
                    onSaved: (value) {
                      // _registerViewGetXController.telephone = value;
                      formRedister = {
                        'firstName': formRedister['firstName']!,
                        'lastName': formRedister['lastName']!,
                        'userName': formRedister['userName']!,
                        'Email': formRedister['Email']!,
                        'password': formRedister['password']!,
                        'confirmPassword': formRedister['confirmPassword']!,
                        'phoneNumber': value!,
                        'referralCode': formRedister['referralCode']!,
                        'dateBirth': formRedister['dateBirth']!,
                      };
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                Visibility(
                  visible: true,
                  child: AppTextField(
                    // hint: AppLocalizations.of(context)!.referral_code,
                    hint: AppLocalizations.of(context)!.referral_code,
                    textController: _referralCodeTextController,
                    onSaved: (value) {
                      // _registerViewGetXController.referralCode = value;
                      formRedister = {
                        'firstName': formRedister['firstName']!,
                        'lastName': formRedister['lastName']!,
                        'userName': formRedister['userName']!,
                        'Email': formRedister['Email']!,
                        'password': formRedister['password']!,
                        'confirmPassword': formRedister['confirmPassword']!,
                        'phoneNumber': formRedister['phoneNumber']!,
                        'referralCode': value!,
                        'dateBirth': formRedister['dateBirth']!,
                      };
                    },
                  ),
                ),
                AppTextField(
                  // textController: _registerViewGetXController
                  //     .birthDateTextEditingController,
                  onTap: () {
                    _selectDate();
                  },
                  // hint: AppLocalizations.of(context)!.date_of_birth,
                  hint: AppLocalizations.of(context)!.date_of_birth,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppLocalizations.of(context)!.date_of_barth_is_required;
                    return null;
                  },
                  onSaved: (value) {
                    // _registerViewGetXController.referralCode = value;
                    formRedister = {
                      'firstName': formRedister['firstName']!,
                      'lastName': formRedister['lastName']!,
                      'userName': formRedister['userName']!,
                      'Email': formRedister['Email']!,
                      'password': formRedister['password']!,
                      'confirmPassword': formRedister['confirmPassword']!,
                      'phoneNumber': formRedister['phoneNumber']!,
                      'referralCode': formRedister['referralCode']!,
                      'dateBirth': _selectedDate.toString(),
                    };
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppMargin.m16,
                  ),
                  width: double.infinity,
                  height: AppSize.s55,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<SellerProvider>(context, listen: false)
                          .registration(
                              _userNameController.text,
                              _emailTextController.text,
                              widget.role,
                              _passwordTextController.text,
                              _confirmPasswordController.text,
                              _nameTextController.text,
                              _lastnameController.text,
                              _referralCodeTextController.text,
                              _phoneTextController.text,
                              _selectedDate.toString())
                          .then((value) =>
                              repo = Provider.of<SellerProvider>(context,listen: false).repo)
                          .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    repo),
                                backgroundColor: Colors.green,
                              )))
                          .then((value) => Navigator.of(context)
                              .pushNamed(Routes.loginRoute))
                          .catchError((e) => print(e.toString()));
                    },
                    child: Text(
                      // AppLocalizations.of(context)!.sign_up,
                      AppLocalizations.of(context)!.sign_up,
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s18),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s55,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.loginRoute),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.i_already_have_account,
                        // 'I Already Have An Account',
                        style: getRegularStyle(
                            color: ColorManager.grey, fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        width: AppSize.s2,
                      ),
                      Text(
                        // AppLocalizations.of(context)!.login,
                        AppLocalizations.of(context)!.login,
                        style: getExtraBoldStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s16),
                      ),
                    ],
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
}
