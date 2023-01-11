import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import '../../../providers/seller_provider.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/app_text_field.dart';

class UpdateInfoSeller extends StatefulWidget {

  @override
  State<UpdateInfoSeller> createState() => _UpdateInfoSellerState();
}

class _UpdateInfoSellerState extends State<UpdateInfoSeller> {
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _phoneTextController;

  DateTime? date;

  bool _checkData(String methodName) {
    print(methodName);
    if (methodName == 'Pick up') {
      if (date != null) return true;
    }
    return false;
  }

  var isLoading = true;

  @override
  void initState() {
    Provider.of<SellerProvider>(context, listen: false)
        .getUserDetails()
        .then((value) => isLoading = false);
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _phoneTextController.dispose();
    super.dispose();
  }
  final _focusNode = FocusNode();
  final _focusNode1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<SellerProvider>(context).userDetails;
    var message = Provider.of<ProductProvider>(context).repo;
    _nameTextController.text = userInfo['firstName'] ?? '';
    _emailTextController.text = userInfo['lastName'] ?? '';
    _passwordTextController.text = userInfo['telephone'] ?? '';
    _phoneTextController.text = userInfo['birthDate'] ?? '';

    return Scaffold(
      body: isLoading
          ? Center(
        child: Container(
          width: 20.h,
          height: 20.h,
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ),
        ),
      )
          : SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: AppSize.s12,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Edit Profile',
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: AppSize.s60,
              ),
              ClipOval(
                // borderRadius: BorderRadius.circular(AppRadius.r14),
                child: Image.asset(
                  fit: BoxFit.cover,
                  'assets/images/avatar_person.png',
                  height: AppSize.s192,
                  width: AppSize.s192,
                ),
              ),
              SizedBox(
                height: AppSize.s60,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      textController: _nameTextController,
                      hint: 'First Name',
                    ),
                  ),
                  Expanded(
                    child: AppTextField(
                      textController: _emailTextController,
                      hint: 'Last Name',
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: AppSize.s40,
              // ),
              AppTextField(
                textController: _passwordTextController,
                hint: 'phone Number',
                textInputAction:TextInputAction.go ,
                onSaved: (value){
                  value ==  _passwordTextController.text;
                },
                // textInputType: TextInputType.emailAddress,
              ),

              // Container(
              //   height: 100,
              //   width: 100,
              //   color: Colors.red,
              // ),
              Row(
                children: [
                  SizedBox(
                    width: AppSize.s40,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xff125051),
                      ),
                    ),
                    child: Text(
                      date == null
                          ? "${_phoneTextController.text.substring(0, 10)}"
                          : date.toString().substring(0, 10),
                      style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppSize.s10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.7,
                              // width: MediaQuery.of(context).size.height * 0.7,
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppPadding.p12),
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius:
                                BorderRadius.circular(AppRadius.r8),
                              ),
                              // child: SizedBox(
                              // height: MediaQuery.of(context).size.height * 1,
                              child: Container(
                                height:
                                MediaQuery.of(context).size.height *
                                    0.4,
                                child: Column(
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.3,
                                      child: CupertinoDatePicker(
                                        mode:
                                        CupertinoDatePickerMode.date,
                                        initialDateTime:
                                        DateTime(2023, 1, 1),
                                        onDateTimeChanged:
                                            (DateTime newDateTime) {
                                          print(
                                              '======================newDate');
                                          print(newDateTime);
                                          // Do something
                                          setState(() {
                                            if (newDateTime == null) {
                                              date = null;
                                            } else {
                                              date = newDateTime;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        width: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.5,
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.07,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorManager.primary,
                                          borderRadius:
                                          BorderRadius.circular(
                                              AppRadius.r8),
                                        ),
                                        child: Text(
                                          'yes',
                                          textAlign: TextAlign.center,
                                          style: getMediumStyle(
                                              color: ColorManager.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: AppSize.s75,
                      width: AppSize.s75,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xff125051),
                        ),
                      ),
                      child: Icon(
                        Icons.date_range,
                        // height: AppSize.s36,
                        // width: AppSize.s36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.s15),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(240, 40),),
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .updateInfo(
                        _nameTextController.text,
                        _emailTextController.text,
                        _passwordTextController.text,
                        _phoneTextController.text)
                        .then((value) => ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.green,
                    )))
                        .then((value) => Navigator.of(context)
                        .pushReplacementNamed(Routes.mainSellerRoute))
                        .catchError((e) => ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    )));
                  },
                  child: Text('Update')),

              SizedBox(height: AppSize.s30),
              ElevatedButton(

                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(170, 40), backgroundColor: Colors.red),
                onPressed: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .deleteAccount()
                      .then((value) => ScaffoldMessenger.of(context)
                      .showSnackBar(
                      SnackBar(content: Text('Deleted'),backgroundColor: Colors.green,)))
                      .then((value) => Navigator.of(context)
                      .pushReplacementNamed(Routes.loginRoute))
                      .catchError((e) => ScaffoldMessenger.of(context)
                      .showSnackBar(
                      SnackBar(content: Text(e.toString()),backgroundColor: Colors.red,)));
                },
                child: Text('Delete Account'),),
            ],
          ),
        ),
      ),
    );
  }
}