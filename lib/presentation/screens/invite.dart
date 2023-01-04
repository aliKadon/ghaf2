import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class Invite extends StatefulWidget {

  @override
  State<Invite> createState() => _InviteState();
}

class _InviteState extends State<Invite> {

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
                    'Invite',
                    style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s24),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: AppSize.s31,
              ),
              Image.asset(
                'assets/images/invite.png',
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              SizedBox(
                height: AppSize.s31,
              ),
              SizedBox(
                height: AppSize.s31,
              ),
              Text(
                'Your Invite Code',
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s30),
              ),
              SizedBox(
                height: AppSize.s31,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.24,
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.black12,
                  border: Border.all(
                    color: Color(0xff125051),
                  ),
                ),
                child: isLoading ? Center(
                  child: Container(
                    width: 20.h,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                ) : Center(
                  child: Text(refCode,style: getSemiBoldStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: FontSize.s26),),
                ),
              ),

              ElevatedButton(onPressed: (){
                setState(() {
                  isLoading =  true;
                  Provider.of<ProductProvider>(context,listen: false).getReferralCode().then((value) => isLoading = false);
                  var referral = Provider.of<ProductProvider>(context,listen: false).referralCode;
                  isLoading = false;
                  refCode = referral;
                });
              }, child: Text('Generate',style: getSemiBoldStyle(
                  color: Colors.white,
                  fontSize: FontSize.s26),),)
            ],
          ),
        ),
      ),
    );
  }
}