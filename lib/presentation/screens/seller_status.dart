import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class SellerStatus extends StatefulWidget {
  final String message;

  SellerStatus(this.message);

  @override
  State<SellerStatus> createState() => _SellerStatusState();
}

class _SellerStatusState extends State<SellerStatus> {
  var isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<SellerProvider>(context)
        .getSellerDetails()
        .then((value) => isLoading = false);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var sellerStatus =
        Provider.of<SellerProvider>(context, listen: false).sellerDetails;
    // print('============================sellerStatus2');
    // print(sellerStatus);
    // if(sellerStatus != null) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
    return Scaffold(
      body: Center(
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
                child: Column(
                  children: [
                    SizedBox(
                      height: AppSize.s146,
                    ),
                    Image.asset('assets/images/welcome.png'),
                    // Spacer(),
                    SizedBox(
                      height: AppSize.s50,
                    ),
                    Container(
                      padding: EdgeInsets.all(30),

                      child: Text(
                        sellerStatus['submittedFormStatus'],
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s20,
                        ),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(Routes.loginRoute),
                        child: Text('Go Back To Login')),
                    SizedBox(
                      height: FontSize.s30,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
