import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../checkout/check_out_getx_controller.dart';
import '../checkout/order_tracking_screen.dart';
import 'controller/help_getx_controller.dart';

class ReportIssueWithOrderScreen extends StatefulWidget {
  String? name;
  String? imageUrl;
  String? orderId;
  String? productId;

  ReportIssueWithOrderScreen(
      {this.name, this.orderId, this.productId, this.imageUrl});

  @override
  State<ReportIssueWithOrderScreen> createState() =>
      _ReportIssueWithOrderScreenState();
}

class _ReportIssueWithOrderScreenState extends State<ReportIssueWithOrderScreen>
    with Helpers {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());
  late final HelpGetxController _helpGetxController =
      Get.put(HelpGetxController());

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController.getOrderById(
        context: context, orderId: widget.orderId!);
    super.initState();
  }

  File? image;

  String? base64;

  List<String> listImage = [];

  Future pickImage() async {
    try {
      final image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      print('====================================image');
      print(image);
      if (image1 == null) return;
      final imageTemp = File(image1.path);
      this.image = imageTemp;
      List<int> byts = (await image!.readAsBytes());
      setState(() {
        base64 = base64Encode(byts);
        print('==================================new image');
        print('11${base64}');
        listImage.add('data:image/jpeg;base64,$base64');
        // imageProduct?[0].data = base64Decode(base64!).toString();
        print('================================listImage');
        print(listImage.toString());
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  var selected = -1;

  @override
  Widget build(BuildContext context) {
    List returnType = [
      AppLocalizations.of(context)!.get_help_rating1,
      AppLocalizations.of(context)!.get_help_rating2,
      AppLocalizations.of(context)!.get_help_rating3,
      AppLocalizations.of(context)!.get_help_rating4,
      AppLocalizations.of(context)!.get_help_rating5,
      AppLocalizations.of(context)!.get_help_rating6,
      AppLocalizations.of(context)!.get_help_rating7
    ];
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(AppSize.s12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppSize.s6),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.038,
                        width: MediaQuery.of(context).size.width * 0.08,
                        child: Image.asset(
                          SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                          height: AppSize.s18,
                          width: AppSize.s10,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.report_issues_with_your_order,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Divider(
                thickness: 1,
                color: ColorManager.greyLight,
              ),
              Padding(
                padding: EdgeInsets.all(AppSize.s8),
                child: Row(
                  children: [
                    Container(
                      height: AppSize.s110,
                      width: AppSize.s110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s20),
                          image: DecorationImage(
                              image: AssetImage(ImageAssets.logo2))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.name}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: FontSize.s14,
                              fontWeight: FontWeight.w500),
                        ),
                        // SizedBox(
                        //   height: AppSize.s14,
                        // ),
                        // Text(
                        //   'ordered on 9 dec 2022',
                        //   style: TextStyle(
                        //       color: ColorManager.greyLight,
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: FontSize.s14),
                        // ),
                        SizedBox(
                          height: AppSize.s14,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => OrderTrackingScreen(
                                  orderId: widget.orderId!,
                                  source: _checkOutGetxController
                                      .order!.deliveryPoint!,
                                  destination: _checkOutGetxController
                                      .order!.branch!.branchAddress!),
                            ));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.review_order,
                            style: TextStyle(
                                color: ColorManager.primaryDark,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize.s14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s24,
              ),
              Text(
                AppLocalizations.of(context)!.why_are_you_reporting_this,
                style: TextStyle(
                    color: ColorManager.primaryDark,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.s18),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: returnType.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selected = index;
                      });
                    },
                    child: selected == index
                        ? ReturnOrderType(
                            context,
                            returnType[index],
                            Icons.radio_button_on_outlined,
                            ColorManager.primary)
                        : ReturnOrderType(context, returnType[index],
                            Icons.radio_button_off, ColorManager.greyLight),
                  );
                },
              ),
              SizedBox(
                height: AppSize.s24,
              ),
              Padding(
                padding: EdgeInsets.all(AppSize.s14),
                child: Row(
                  children: [
                    Container(
                        height: AppSize.s110,
                        padding: EdgeInsets.all(AppPadding.p10),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          border: Border.all(color: ColorManager.greyLight),
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                        ),
                        child: base64 != null
                            ? Image.memory(base64Decode(base64!))
                            : Image.asset(
                                ImageAssets.photoGallery,
                                height: AppSize.s55,
                                width: AppSize.s55,
                              )),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        showSheetAddImage(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: ColorManager.primary,
                          ),
                          SizedBox(
                            width: AppSize.s14,
                          ),
                          Text(
                            AppLocalizations.of(context)!.add_image,
                            style: TextStyle(
                                color: ColorManager.primaryDark,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: AppSize.s24,
              // ),
              // Text(
              //   AppLocalizations.of(context)!.add_more_items,
              //   style: TextStyle(
              //       color: ColorManager.primary,
              //       fontWeight: FontWeight.w600,
              //       fontSize: FontSize.s18),
              // ),
              SizedBox(
                height: AppSize.s24,
              ),
              Container(
                height: AppSize.s44,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _helpGetxController.reportOrderIssueTicket(
                          context: context,
                          orderId: widget.orderId!,
                          comment: returnType[selected]);
                    },
                    child: Text(AppLocalizations.of(context)!.confirm)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ReturnOrderType(BuildContext context, String text, IconData iconData,
      Color colorManager) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              iconData,
              color: colorManager,
            ),
            SizedBox(
              width: AppSize.s14,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(text,
                  style: TextStyle(
                      color: ColorManager.primaryDark,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.s16)),
            ),
          ],
        ),
        SizedBox(
          height: AppSize.s14,
        ),
      ],
    );
  }

  Future showSheetAddImage(BuildContext context) => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.4, 0.7],
          ),
          builder: (context, state) => Material(
            child: Padding(
              padding: EdgeInsets.all(AppSize.s15),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Text(AppLocalizations.of(context)!.add_an_image_to_proceed,
                        style: TextStyle(
                            fontSize: FontSize.s16,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.grey)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          pickImage();
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //   builder: (context) => RegisterScreen(),
                          // ));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(ColorManager.primary),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    side:
                                        BorderSide(color: ColorManager.primary),
                                    borderRadius: BorderRadius.circular(AppSize.s10)))),
                        child: Text(
                          AppLocalizations.of(context)!.ok,
                          // 'Login',
                          style: getSemiBoldStyle(
                              color: ColorManager.white, fontSize: FontSize.s18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
