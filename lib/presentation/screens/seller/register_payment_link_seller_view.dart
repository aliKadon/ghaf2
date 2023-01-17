import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

enum businessSector {
  corporate,
  individual,
}

class RegisterPaymentLinkSellerView extends StatefulWidget {
  const RegisterPaymentLinkSellerView({Key? key}) : super(key: key);

  @override
  State<RegisterPaymentLinkSellerView> createState() =>
      _RegisterPaymentLinkSellerViewState();
}

class _RegisterPaymentLinkSellerViewState
    extends State<RegisterPaymentLinkSellerView> with Helpers {
  var sectorName = 'Business Sector';
  var sectorNumber = 0;

  var business = [
    'Corporate business',
    'Accessories',
    'Agriculture And Landscaping',
    'Beauty services',
    'Cleaning services',
    'computer services',
    'Grocery store',
    'Media services',
    'Repair services',
    'Software-Development/Design',
    'web-Development/Design',
    'Other'
  ];
  var businessType = 'Corporate business';

  var option = '';
  var Agree = false;

  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _phoneTextController;
  late TextEditingController _referralCodeTextController;
  late TextEditingController _boDTextController;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _referralCodeTextController = TextEditingController();
    _boDTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _phoneTextController.dispose();
    _referralCodeTextController.dispose();
    _boDTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSize.s22,
              ),
              Text(
                AppLocalizations.of(context)!.sign_up_to_create_account,
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
                width: AppSize.s92,
              ),
              SizedBox(
                height: AppSize.s32,
              ),
              AppTextField(
                textController: _nameTextController,
                hint: AppLocalizations.of(context)!.shop_name,
              ),
              AppTextField(
                textController: _emailTextController,
                hint: AppLocalizations.of(context)!.your_company_email_address,
                textInputType: TextInputType.emailAddress,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p16,
                ),
                child: Row(
                  children: [
                    Container(
                      width: AppSize.s55,
                      height: AppSize.s55,
                      padding: EdgeInsets.all(AppPadding.p10),
                      decoration: BoxDecoration(
                        // color: ColorManager.lightGrey,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(AppRadius.r8),
                          bottomStart: Radius.circular(AppRadius.r8),
                        ),
                        border: Border.all(color: ColorManager.grey),
                      ),
                      child: Image.asset(
                        ImageAssets.uaeFlag,
                        fit: BoxFit.fill,
                        height: AppSize.s34,
                        width: AppSize.s34,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _phoneTextController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s14,
                        ),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.phone_number,
                          hintStyle: getMediumStyle(
                            color: ColorManager.hintTextFiled,
                          ),
                          filled: false,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: AppPadding.p18,
                              horizontal: AppPadding.p4),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(AppRadius.r10),
                                bottomRight: Radius.circular(AppRadius.r10)),
                            borderSide: BorderSide(
                              width: AppSize.s1,
                              color: ColorManager.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(AppRadius.r10),
                                bottomRight: Radius.circular(AppRadius.r10)),
                            borderSide: BorderSide(
                              width: AppSize.s1,
                              color: ColorManager.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              Visibility(
                visible: true,
                child: AppTextField(
                  textController: _referralCodeTextController,
                  hint: AppLocalizations.of(context)!.company_name,
                ),
              ),
              Container(
                // height: AppSize.s75,
                margin: EdgeInsets.only(left: 12, right: 12),
                width: MediaQuery.of(context).size.width * 1,
                padding: EdgeInsets.only(left: AppPadding.p12),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  border:
                      Border.all(width: AppSize.s1, color: Color(0xff125051)),
                  borderRadius: BorderRadius.circular(AppRadius.r4),
                ),
                child: DropdownButton<String>(
                  dropdownColor: Colors.black54,
                  value: sectorName,
                  onChanged: (sector) {
                    setState(() {
                      sectorName = sector!;
                    });
                    if (sectorName == 'corporate') {
                      setState(() {
                        sectorNumber = businessSector.corporate.index;
                        print('==================================sectore');
                        print(sectorNumber);
                      });
                    } else {
                      sectorNumber = businessSector.individual.index;
                      print('==================================sectore');
                      print(sectorNumber);
                    }
                    // if (sectorName == 'individual') {
                    //   sectorNumber = businessSector.individual as int;
                    // }
                  },
                  items: <String>['Business Sector', 'corporate', 'individual']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              Container(
                // height: AppSize.s75,
                margin: EdgeInsets.only(left: 12, right: 12),
                width: MediaQuery.of(context).size.width * 1,
                // padding: EdgeInsets.all(AppPadding.p12),
                padding: EdgeInsets.only(left: AppPadding.p12),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  border:
                      Border.all(width: AppSize.s1, color: Color(0xff125051)),
                  borderRadius: BorderRadius.circular(AppRadius.r4),
                ),
                child: DropdownButton<String>(
                  dropdownColor: Colors.black54,
                  value: businessType,
                  onChanged: (sector) {
                    setState(() {
                      businessType = sector!;
                    });
                  },
                  items: business.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              // AppTextField(
              //   textController: _boDTextController,
              //   hint: AppLocalizations.of(context)!.business_sector,
              //   textInputAction: TextInputAction.done,
              //   textInputType: TextInputType.datetime,
              //   // onSubmitted: (){},
              // ),
              // AppTextField(
              //   textController: _boDTextController,
              //   hint: AppLocalizations.of(context)!.corporate_business,
              //   textInputAction: TextInputAction.done,
              //   textInputType: TextInputType.datetime,
              //   // onSubmitted: (){},
              // ),
              // AppTextField(
              //   textController: _passwordTextController,
              //   hint: AppLocalizations.of(context)!.hint_password,
              //   textInputType: TextInputType.visiblePassword,
              //   obscureText: true,
              // ),

              GestureDetector(
                // onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        activeColor: ColorManager.primary,
                        value: 'Agree',
                        onChanged: (n) {
                          setState(() {
                            Agree = true;
                            option = n!;
                          });
                          print('--------------------------------agree');
                          print(Agree);
                        },
                        groupValue: option),
                    Row(
                      children: [
                        Text(
                          'I Agree To The ',
                          style: getRegularStyle(
                              color: ColorManager.grey, fontSize: FontSize.s16),
                        ),
                        InkWell(
                          onTap: (){

                            Navigator.of(context).pushNamed(Routes.termsOfUseRoute);
                          },
                          child: Text.rich( //underline partially
                            TextSpan(
                                style: TextStyle(fontSize: FontSize.s16 , color: Colors.blue), //global text style
                                children: [
                                  TextSpan(text:"${AppLocalizations.of(context)!.terms_of_services}", style: TextStyle(
                                      decoration:TextDecoration.underline
                                  )), //partial text style
                                ]
                            ),
                          ),
                        ),
                      ],),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () {
                     if (_checkData()) {
                      Navigator.of(context)
                          .pushNamed(Routes.shopAddressSellerRoute, arguments: {
                        'storeName': _nameTextController.text,
                        'email': _emailTextController.text,
                        'phoneNumber': _phoneTextController.text,
                        'companyName': _referralCodeTextController.text,
                        'businessType': sectorNumber,
                        'businessSector': businessType
                      });
                    }
                  },
                  child: Text(
                    // AppLocalizations.of(context)!.sign_up,
                    '${AppLocalizations.of(context)!.next}',
                    style: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s18),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performRegister() async {
    if (_checkData()) {
      return _register();
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _phoneTextController.text.isNotEmpty &&
        Agree) {
      return true;
    }
    showSnackBar(context, message: AppLocalizations.of(context)!.enter_required_data, error: true);
    return false;
  }

  Future<void> _register() async {
    // ApiResponse apiResponse = await AuthApiController().register(user: user);
    // apiResponse.status==200?
    // Navigator.pop(context):
    // showSnackBar(context, message: apiResponse.message??' ', error: true);
  }

// User get user {
//   User user = User();
//   user.userName = _nameTextController.text;
//   user.password = _passwordTextController.text;
//   user.confirmPassword = _passwordTextController.text;
//   user.firstName = _nameTextController.text; // todo add first and last name on ui
//   user.lastName = _nameTextController.text;
//   user.telephone = _phoneTextController.text;
//   user.role = Constants.roleRegister;
//   user.email = _emailTextController.text;
//   user.birthDate = _boDTextController.text;
//   return user;
// }

}
