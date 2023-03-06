import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ReturnOrderItemDetailsGetHelp extends StatefulWidget {
  @override
  State<ReturnOrderItemDetailsGetHelp> createState() =>
      _ReturnOrderItemDetailsGetHelpState();
}

class _ReturnOrderItemDetailsGetHelpState
    extends State<ReturnOrderItemDetailsGetHelp> with Helpers {
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
      AppLocalizations.of(context)!.brought_by_mistake,
      AppLocalizations.of(context)!.product_damaged_by_shipping,
      AppLocalizations.of(context)!.received_with_missing_or_broken_parts,
      AppLocalizations.of(context)!.item_received_but_does_not_work,
      AppLocalizations.of(context)!.wrong_item_was_sent,
      AppLocalizations.of(context)!.item_does_not_match_description,
      AppLocalizations.of(context)!.order_status_delivered_but_item_not_received
    ];
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                        color: ColorManager.primaryDark,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.get_help,
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: AppSize.s110,
                      width: AppSize.s110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(ImageAssets.pizza))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'pizza neew pizza',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: FontSize.s14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: AppSize.s14,
                        ),
                        Text(
                          'ordered on 9 dec 2022',
                          style: TextStyle(
                              color: ColorManager.greyLight,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.s14),
                        ),
                        SizedBox(
                          height: AppSize.s14,
                        ),
                        Text(
                          AppLocalizations.of(context)!.review_order,
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.s14),
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
                AppLocalizations.of(context)!.why_are_you_returning_this,
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
                padding: const EdgeInsets.all(14.0),
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
              SizedBox(
                height: AppSize.s24,
              ),
              Text(
                AppLocalizations.of(context)!.add_more_items,
                style: TextStyle(
                    color: ColorManager.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.s18),
              ),
              SizedBox(
                height: AppSize.s24,
              ),
              Container(
                height: AppSize.s44,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      showSheetGetHelpConfirm(context);
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
  Future showSheetAddImage(BuildContext context) =>
      showSlidingBottomSheet(
        context,
        builder: (context) =>
            SlidingSheetDialog(
              snapSpec: SnapSpec(
                snappings: [0.4, 0.7],
              ),
              builder: (context, state) =>
                  Material(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.024,
                            ),
                            Text(AppLocalizations.of(context)!.add_an_image_to_proceed,

                                style: TextStyle(
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.grey)),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.024,
                            ),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 1,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.06,
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
                                            side: BorderSide(
                                                color: ColorManager
                                                    .primary),
                                            borderRadius:
                                            BorderRadius.circular(10)))),
                                child: Text(
                                  AppLocalizations.of(context)!.ok,
                                  // 'Login',
                                  style: getSemiBoldStyle(
                                      color: ColorManager.white,
                                      fontSize: 18),
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
