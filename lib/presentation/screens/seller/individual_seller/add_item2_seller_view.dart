import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/domain/model/ghaf_image.dart';
import 'package:ghaf_application/presentation/screens/seller/controller/create_link_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';

class AddItem2SellerView extends StatefulWidget {
  // const AddItem2SellerView({Key? key}) : super(key: key);

  final bool isShow;

  AddItem2SellerView(this.isShow);

  @override
  State<AddItem2SellerView> createState() => _AddItem2SellerViewState();
}

class _AddItem2SellerViewState extends State<AddItem2SellerView> with Helpers {
  //controller
  late final CreateLinkGetxController _createLinkGetxController =
      Get.put(CreateLinkGetxController());
  List<GhafImage>? imageProduct;

  late TextEditingController _nameTextController;
  late TextEditingController _priceTextController;
  late TextEditingController _descriptionsTextController;
  late TextEditingController _characteristicsTextController;
  late TextEditingController _productTypeTextController;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _priceTextController = TextEditingController();
    _descriptionsTextController = TextEditingController();
    _characteristicsTextController = TextEditingController();
    _productTypeTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _priceTextController.dispose();
    _descriptionsTextController.dispose();
    _characteristicsTextController.dispose();
    _productTypeTextController.dispose();
    super.dispose();
  }

  List<String> listImage = [];

  // Image? image;

  File? image;
  String? base64;

  var isShow2 = true;
  var count = -1;
  List<String> imageList = [];

  Future pickImage1() async {
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
        listImage.add('data:image/jpeg;base64,$base64');
        imageProduct?[0].data = base64Decode(base64!).toString();
        imageList.add(base64!);
        count++;
        print('================================listImage');
        print(listImage.toString());
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var repo = Provider.of<SellerProvider>(context).repo;
    // var result = ModalRoute.of(context)!.settings.arguments as bool;
    print('===================================result');
    print(widget.isShow);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: getMediumStyle(
                            color: ColorManager.grey, fontSize: FontSize.s16),
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.add_item,
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s24),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        showLoadingDialog(context: context, title: 'Loading');
                        _createLinkGetxController.createProduct(
                            context: context,
                            name: _nameTextController.text,
                            description: _descriptionsTextController.text,
                            productType: _productTypeTextController.text,
                            price: num.parse(_priceTextController.text),
                            isNotDetailed: false,
                            images: listImage);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.save,
                        style: getMediumStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s30,
              ),
              Container(
                color: Colors.black12,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickImage1();
                      },
                      child: Container(
                          padding: EdgeInsets.all(AppPadding.p10),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                          ),
                          child:
                              // base64 != null
                              //     ? Image.memory(base64Decode(base64!))
                              //     :
                              Image.asset(
                            ImageAssets.photoGallery,
                            height: AppSize.s55,
                            width: AppSize.s55,
                          )),
                    ),
                    Container(
                      // height: AppSize.s55,
                      // width: AppSize.s55,
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ListView.builder(
                        padding: EdgeInsets.all(12),
                        itemCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(

                                // padding: EdgeInsets.all(AppPadding.p10),
                                decoration: BoxDecoration(
                                  color: ColorManager.greyLight,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r8),
                                ),
                                child: index < imageList.length
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: ColorManager.greyLight,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                                image: MemoryImage(base64Decode(
                                                    imageList[index])),
                                                fit: BoxFit.cover)),
                                        height: AppSize.s75,
                                        width: AppSize.s75,
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        height: AppSize.s75,
                                        width: AppSize.s75,
                                      )),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 17.0, right: 17.0, left: 17.0),
                child: Text(AppLocalizations.of(context)!.name_of_product,
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSize.s16)),
              ),
              AppTextField(
                textController: _nameTextController,
                hint: AppLocalizations.of(context)!.name_of_product,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 17.0, right: 17.0, left: 17.0),
                child: Text(AppLocalizations.of(context)!.price,
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSize.s16)),
              ),
              AppTextField(
                textController: _priceTextController,
                hint: AppLocalizations.of(context)!.price,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 17.0, right: 17.0, left: 17.0),
                child: Text(AppLocalizations.of(context)!.description,
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSize.s16)),
              ),
              AppTextField(
                textController: _descriptionsTextController,
                hint: AppLocalizations.of(context)!.description,
              ),
              // SizedBox(
              //   height: AppSize.s16,
              // ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 17.0, right: 17.0, left: 17.0),
                child: Text(AppLocalizations.of(context)!.characteristics,
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSize.s16)),
              ),
              AppTextField(
                textController: _characteristicsTextController,
                hint: AppLocalizations.of(context)!.characteristics,
              ),
              // SizedBox(
              //   height: AppSize.s16,
              // ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 17.0, right: 17.0, left: 17.0),
                child: Text(AppLocalizations.of(context)!.productType,
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSize.s16)),
              ),
              AppTextField(
                textController: _productTypeTextController,
                hint: AppLocalizations.of(context)!.productType,
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
        _priceTextController.text.isNotEmpty &&
        _descriptionsTextController.text.isNotEmpty &&
        _characteristicsTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context,
        message: AppLocalizations.of(context)!.enter_required_data,
        error: true);
    return false;
  }

  Future<void> _register() async {}

  void _customDialogProgress() async {
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
                            "2546462465436463",
                            style: getMediumStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s14),
                          ),
                        ),
                        PositionedDirectional(
                          end: 0,
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
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s16,
                    ),
                    Container(
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
                    SizedBox(
                      height: AppSize.s30,
                    ),
                    Row(
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
                    // Row(
                    //   children: [
                    //     Image.asset(
                    //       IconsAssets.email,
                    //       height: AppSize.s16,
                    //       width: AppSize.s16,
                    //     ),
                    //     SizedBox(
                    //       width: AppSize.s8,
                    //     ),
                    //     Text(
                    //       AppLocalizations.of(context)!
                    //           .use_as_pay_button_on_website,
                    //       style: getMediumStyle(
                    //           color: ColorManager.black,
                    //           fontSize: FontSize.s14),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: AppSize.s12,
                    // ),
                    // Row(
                    //   children: [
                    //     Image.asset(
                    //       IconsAssets.email,
                    //       height: AppSize.s16,
                    //       width: AppSize.s16,
                    //     ),
                    //     SizedBox(
                    //       width: AppSize.s8,
                    //     ),
                    //     Text(
                    //       AppLocalizations.of(context)!.show_qr_code,
                    //       style: getMediumStyle(
                    //           color: ColorManager.black,
                    //           fontSize: FontSize.s14),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                  ]),
            ),
          );
        });
  }
}
