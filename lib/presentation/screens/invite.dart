import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                    AppLocalizations.of(context)!.invite,
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
                'assets/images/Invite.png',
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              SizedBox(
                height: AppSize.s31,
              ),
              Text(
                'Give 25% Off Get 25% Off',
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s24),
              ),
              Text(
                'For Every Friend Who Places Their First Order',
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s14),
              ),
              SizedBox(
                height: AppSize.s31,
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.black12,
                            border: Border.all(
                              color: Color(0xff125051),
                            ),
                          ),
                          child: Image.asset('assets/images/icons1.png',width: 40,height: 40),
                        ),
                        Text(
                          'Invite Friend \n',
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
                          lineLength: MediaQuery.of(context).size.width * 0.12,
                          lineThickness: 2.0,
                          dashLength: 4.0,
                          dashColor: Colors.black,
                          // dashGradient: [Colors.red, Colors.blue],
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapGradient: [Colors.white, Colors.white],
                          dashGapRadius: 0.0,
                        ),
                        SizedBox(
                          height: AppSize.s20,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.black12,
                            border: Border.all(
                              color: Color(0xff125051),
                            ),
                          ),
                          child: Image.asset('assets/images/icons2.png',width: 40,height: 40),
                        ),
                        Text(
                          'Friend Come \n   Onboard',
                          style: getSemiBoldStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s14),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: MediaQuery.of(context).size.width * 0.12,
                          lineThickness: 2.0,
                          dashLength: 4.0,
                          dashColor: Colors.black,
                          // dashGradient: [Colors.red, Colors.blue],
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapGradient: [Colors.white, Colors.white],
                          dashGapRadius: 0.0,
                        ),
                        SizedBox(
                          height: AppSize.s20,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.black12,
                            border: Border.all(
                              color: Color(0xff125051),
                            ),
                          ),
                          child: Image.asset('assets/images/icons3.png',width: 40,height: 40),
                        ),
                        Text(
                          'Get Rewards \n',
                          style: getSemiBoldStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s14),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              Text(
                AppLocalizations.of(context)!.invite_code,
                style: getSemiBoldStyle(
                    color: ColorManager.primaryDark, fontSize: FontSize.s26),
              ),
              SizedBox(
                height: AppSize.s20,
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
                child: isLoading
                    ? Center(
                        child: Container(
                          width: 20.h,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          refCode,
                          style: getSemiBoldStyle(
                              color: Colors.deepOrangeAccent,
                              fontSize: FontSize.s26),
                        ),
                      ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        Provider.of<ProductProvider>(context, listen: false)
                            .getReferralCode()
                            .then((value) => isLoading = false);
                        var referral =
                            Provider.of<ProductProvider>(context, listen: false)
                                .referralCode;
                        isLoading = false;
                        refCode = referral;
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context)!.generate,
                      style: getSemiBoldStyle(
                          color: Colors.white, fontSize: FontSize.s20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Clipboard.setData(ClipboardData(text: refCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Copied"),
                          ),
                        );
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context)!.copy,
                      style: getSemiBoldStyle(
                          color: Colors.white, fontSize: FontSize.s20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
