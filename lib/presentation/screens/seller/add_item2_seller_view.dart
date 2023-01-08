import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/domain/model/ghaf_image.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AddItem2SellerView extends StatefulWidget {
  const AddItem2SellerView({Key? key}) : super(key: key);

  @override
  State<AddItem2SellerView> createState() => _AddItem2SellerViewState();
}

class _AddItem2SellerViewState extends State<AddItem2SellerView> with Helpers {

  List<GhafImage>? imageProduct;

  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _phoneTextController;
  late TextEditingController _discTextController;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _discTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _phoneTextController.dispose();
    _discTextController.dispose();
    super.dispose();
  }

  List<String> listImage = [];

  // Image? image;

  File? image;
  String? base64;

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
        listImage.add('data:image/jpeg;base64,$base64');
        imageProduct?[0].data = base64Decode(base64!).toString();
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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        Provider.of<SellerProvider>(context,listen: false)
                            .createIndividualProducts(
                            _nameTextController.text,
                            _passwordTextController.text,
                            _phoneTextController.text,
                            _discTextController.text,
                            int.parse(_emailTextController.text),
                            listImage )
                            .then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                          content: Text(repo),
                          backgroundColor: Colors.green,
                        ))).then((value) => Navigator.of(context).pop())
                            .then((value) => Navigator.of(context)
                            .pushNamed(Routes.addItemSellerRoute)
                            .catchError((e) => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                          content: Text(repo),
                          backgroundColor: Colors.red,
                        ))));

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
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: ElevatedButton(
                    onPressed: () => pickImage(),
                    child: Text(
                      AppLocalizations.of(context)!.add_photo,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              Container(
                  padding: EdgeInsets.all(AppPadding.p10),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                  ),
                  child: base64 != null
                      ? Image.memory(base64Decode(base64!))
                      : Image.asset(
                          ImageAssets.photoGallery,
                          height: AppSize.s55,
                          width: AppSize.s55,
                        )),
              SizedBox(
                height: AppSize.s20,
              ),
              AppTextField(
                textController: _nameTextController,
                hint: AppLocalizations.of(context)!.name_of_product,
              ),
              AppTextField(
                textController: _emailTextController,
                hint: AppLocalizations.of(context)!.price,
              ),
              AppTextField(
                textController: _passwordTextController,
                hint: 'Description',
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              AppTextField(
                textController: _phoneTextController,
                hint: 'characteristics',
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              AppTextField(
                textController: _discTextController,
                hint: 'productType',
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
        _passwordTextController.text.isNotEmpty &&
        _phoneTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter Required Data!', error: true);
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
