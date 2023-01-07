import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../providers/seller_provider.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class CreatePaymentLink2SellerView extends StatefulWidget {
  // const CreatePaymentLink2SellerView({Key? key}) : super(key: key);

  final int amount;



  CreatePaymentLink2SellerView(this.amount);

  @override
  State<CreatePaymentLink2SellerView> createState() =>
      _CreatePaymentLink2SellerViewState();
}

class _CreatePaymentLink2SellerViewState
    extends State<CreatePaymentLink2SellerView> with Helpers {
  @override
  void initState() {
    Provider.of<SellerProvider>(context, listen: false)
        .readIndividualProducts().then((value) => isLoading = false);
    super.initState();
  }

  var isLoading = true;

  //send from email
  void _contactEmail(String body) async {
    String subject = "Hello from Ghaf";
    launch("mailto:?subject=$subject&body=$body");
    // final url = Uri.parse('mailto:?subject=$subject&body=$body');
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  final TextEditingController _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var readProduct =
        Provider.of<SellerProvider>(context).readIndividualProduct;
    print('======================================readProduct');
    print(readProduct);
    return Scaffold(
      body: SafeArea(
        child: isLoading ? Center(
          child: Container(
            width: 20.h,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
        ) :Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.s9,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s24,
                      width: AppSize.s24,
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.create_payment_link,
                    style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s24),
                  ),
                  Spacer(),
                  // Image.asset(
                  //   IconsAssets.plus3,
                  //   height: AppSize.s24,
                  //   width: AppSize.s24,
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Text(
                AppLocalizations.of(context)!.enter_customer_details,
                style: getMediumStyle(
                    color: ColorManager.grey, fontSize: FontSize.s18),
              ),
            ),
            SizedBox(
              height: AppSize.s2,
            ),
            isLoading ? Center(
              child: Container(
                width: 20.h,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            ) : Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Row(
                children: [
                  Text(
                    '${readProduct[0].price.toString()} AED',
                    style: getSemiBoldStyle(
                        color: ColorManager.primary, fontSize: FontSize.s16),
                  ),
                  Spacer(),
                  Text(
                    readProduct[0].addedAt.substring(0, 10),
                    style: getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            Spacer(),
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
                  Provider.of<SellerProvider>(context, listen: false)
                      .createPaymnetLink(readProduct[0].id, widget.amount)
                      .then((value) => _customDialogProgress());
                },
                child: Text(
                  AppLocalizations.of(context)!.create_link,
                  style: getSemiBoldStyle(
                      color: ColorManager.white, fontSize: FontSize.s18),
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s73,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.subtotal,
                    style: getSemiBoldStyle(
                        color: ColorManager.grey, fontSize: FontSize.s16),
                  ),
                  Spacer(),
                  Text(
                    ((readProduct[0].price) * widget.amount).toString(),
                    style: getSemiBoldStyle(
                        color: ColorManager.grey, fontSize: FontSize.s16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
          ],
        ),
      ),
    );
  }

  void _customDialogProgress() async {
    var pro = Provider.of<SellerProvider>(context,listen: false).createPaymentLink;

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s410,
              width: AppSize.s343,
              margin: EdgeInsets.symmetric(horizontal: AppPadding.p16),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Text(
                      AppLocalizations.of(context)!.your_link_is_ready,
                      style: getBoldStyle(
                          color: ColorManager.grey, fontSize: FontSize.s20),
                    ),
                    SizedBox(
                      height: AppSize.s34,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: AppPadding.p16,
                              horizontal: AppPadding.p4),
                          alignment: AlignmentDirectional.centerStart,
                          decoration: BoxDecoration(
                            color: ColorManager.greyLight,
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                          ),
                          child: Text(
                          pro['url'],
                            style: getMediumStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s14),
                          ),
                        ),
                        PositionedDirectional(
                          end: 0,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Copied"),
                                ),
                              );
                              Clipboard.setData(ClipboardData(text: pro['url']));
                            } ,
                            child: Container(
                              width: AppSize.s92,
                              padding: EdgeInsets.symmetric(
                                  vertical: AppPadding.p12,
                                  horizontal: AppPadding.p4),
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(AppRadius.r8),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.copy,
                                style: getSemiBoldStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s16,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String message = "Hello from Flutter!";
                        String whatsappUrl = "whatsapp://send?phone=&text=$message";
                        final urlWhatsUP = "https://wa.me/?text=${_textController.text}";
                        await launch(urlWhatsUP);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: AppPadding.p12, horizontal: AppPadding.p4),
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          color: ColorManager.greyLight,
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.preview_link,
                          style: getBoldStyle(
                              color: ColorManager.grey, fontSize: FontSize.s16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s30,
                    ),
                    GestureDetector(
                      onTap: () {
                        _contactEmail(_textController.text);
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            IconsAssets.whats_up,
                            height: AppSize.s16,
                            width: AppSize.s16,
                          ),
                          SizedBox(
                            width: AppSize.s8,
                          ),
                          Text(
                            AppLocalizations.of(context)!.send_by_whatsapp,
                            style: getMediumStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          IconsAssets.email,
                          height: AppSize.s16,
                          width: AppSize.s16,
                        ),
                        SizedBox(
                          width: AppSize.s8,
                        ),
                        Text(
                          AppLocalizations.of(context)!.send_by_email,
                          style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          IconsAssets.email,
                          height: AppSize.s16,
                          width: AppSize.s16,
                        ),
                        SizedBox(
                          width: AppSize.s8,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .use_as_pay_button_on_website,
                          style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          IconsAssets.email,
                          height: AppSize.s16,
                          width: AppSize.s16,
                        ),
                        SizedBox(
                          width: AppSize.s8,
                        ),
                        Text(
                          AppLocalizations.of(context)!.show_qr_code,
                          style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                  ]),
            ),
          );
        });
  }
}
