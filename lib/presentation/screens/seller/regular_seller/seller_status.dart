import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/seller/regular_seller/introduce_to_subscribe.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../../app/preferences/shared_pref_controller.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../account_view/account_view_getx_controller.dart';
import '../../main_view.dart';

class SellerStatus extends StatefulWidget {
  final String message;

  SellerStatus(this.message);

  @override
  State<SellerStatus> createState() => _SellerStatusState();
}

class _SellerStatusState extends State<SellerStatus> {
  var isLoading = true;
  late final AccountViewGetXController _accountViewGetXController =
  Get.put(AccountViewGetXController());

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
        Provider
            .of<SellerProvider>(context, listen: false)
            .sellerDetails;
    // print('============================sellerStatus2');
    // print(sellerStatus);
    // if(sellerStatus != null) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
    return WillPopScope(
      onWillPop: () async {
        await SharedPrefController().logout();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainView(),
        ));
        return false;
      },
      child: Scaffold(
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
                ), SizedBox(
                  height: AppSize.s30,
                ),
                sellerStatus['submittedFormStatusBool'] == 1 &&
                    sellerStatus['active'] == 'Account is active'
                    ? Container()
                    : sellerStatus['submittedFormStatusBool'] == 1
                    ? ElevatedButton(
                    onPressed: () {

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => IntroduceToSubscribe(),));
                    },
                    child: Text(AppLocalizations.of(context)!.go_to_subscribe))
                    : Container(),
                ElevatedButton(
                    onPressed: () =>
                        _accountViewGetXController.logout(context: context),
                    child: Text(AppLocalizations.of(context)!.go_to_login)),
                SizedBox(
                  height: FontSize.s8,
                ),
                sellerStatus['submittedFormStatusBool'] == 1 &&
                    sellerStatus['active'] == 'Account is active' ? Container(
                  child: ElevatedButton(
                    onPressed: () {
                      dashboard(url: 'https://www.web.ghafgate.com',);
                    },
                    child: Text(
                        '${AppLocalizations.of(context)!.go_to_dashboard}'),
                  ),
                ) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  dashboard({required String url}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

}
