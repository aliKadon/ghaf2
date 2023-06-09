import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/screens/seller/controller/create_link_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../providers/product_provider.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/values_manager.dart';

class CreatePaymentLinkSellerView extends StatefulWidget {
  const CreatePaymentLinkSellerView({Key? key}) : super(key: key);

  @override
  State<CreatePaymentLinkSellerView> createState() =>
      _CreatePaymentLinkSellerViewState();
}

class _CreatePaymentLinkSellerViewState
    extends State<CreatePaymentLinkSellerView> with Helpers {
  //controller
  late final CreateLinkGetxController
      _createLinkWithoutDetailsGetxController;

  late TextEditingController _nameTextController;
  late TextEditingController _productTypeTextController;
  late TextEditingController _paymentAmountTextController;
  late TextEditingController _amountTextController;
  late TextEditingController _descriptionTextController;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    _createLinkWithoutDetailsGetxController =
        Get.put(CreateLinkGetxController());
    super.initState();
    _nameTextController = TextEditingController();
    _productTypeTextController = TextEditingController();
    _paymentAmountTextController = TextEditingController();
    _amountTextController = TextEditingController();
    _descriptionTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _productTypeTextController.dispose();
    _paymentAmountTextController.dispose();
    _amountTextController.dispose();
    _descriptionTextController.dispose();

    super.dispose();
  }

  List<String>? list = ['data:image/jpeg;base64,'];

  @override
  Widget build(BuildContext context) {
    var repo = Provider.of<SellerProvider>(context, listen: false).repo;

    list?.add('data:image/jpeg;base64,');
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
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.create_payment_link,
                    style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s24),
                  ),
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
                height: AppSize.s20,
              ),
              AppTextField(
                textController: _nameTextController,
                // hint: AppLocalizations.of(context)!.customer_name,
                hint: AppLocalizations.of(context)!.name_of_product,
                textInputType: TextInputType.name,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      textController: _paymentAmountTextController,
                      hint: AppLocalizations.of(context)!.price,
                      textInputType: TextInputType.phone,
                      // obscureText: true,
                    ),
                  ),
                  Expanded(
                    child: AppTextField(
                      textController: _productTypeTextController,
                      // hint: AppLocalizations.of(context)!.link_expiration_date,
                      hint: AppLocalizations.of(context)!.productType,
                      textInputType: TextInputType.text,
                      // obscureText: true,
                    ),
                  ),
                ],
              ),
              AppTextField(
                textController: _createLinkWithoutDetailsGetxController.amountTextController,
                // hint: AppLocalizations.of(context)!.link_expiration_date,
                hint: AppLocalizations.of(context)!.amount,
                textInputType: TextInputType.phone,
                // obscureText: true,
              ),
              AppTextField(
                textController: _descriptionTextController,
                hint: AppLocalizations.of(context)!.description,
                lines: 4,
              ),
              SizedBox(
                height: AppSize.s92,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () {
                    showLoadingDialog(context: context, title: 'Loading');

                    _createLinkWithoutDetailsGetxController.createProduct(
                        context: context,
                        isNotDetailed: false,
                        // itemForLink: num.parse(_amountTextController.text),
                        name: _nameTextController.text,
                        description: _descriptionTextController.text,
                        characteristics: '',
                        productType: _productTypeTextController.text,
                        price: num.parse(_paymentAmountTextController.text),
                        images: []);

                    // Provider.of<SellerProvider>(context, listen: false)
                    //     .createIndividualProductsWithout(
                    //       name: _nameTextController.text,
                    //       description: _descriptionTextController.text,
                    //       price: int.parse(_paymentAmountTextController.text),
                    //       productType: _productTypeTextController.text,
                    //     )
                    //     .then((value) => ScaffoldMessenger.of(context)
                    //         .showSnackBar(SnackBar(content: Text(repo))))
                    //     .then((value) => Navigator.of(context).pop())
                    //     .then((value) =>
                    //         Provider.of<SellerProvider>(context, listen: false)
                    //             .readIndividualProducts())
                    //     .then((value) => _customDialogProgress1())
                    //     .then((value) =>
                    //         Provider.of<SellerProvider>(context, listen: false)
                    //             .createPaymnetLink(
                    //                 Provider.of<SellerProvider>(context)
                    //                     .readIndividualProduct[0]
                    //                     .id!,
                    //                 _amountTextController.text))
                    //     .catchError(((e) => ScaffoldMessenger.of(context)
                    //         .showSnackBar(SnackBar(content: Text(repo)))));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.create_link,
                    style: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s18),
                  ),
                ),
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
        _productTypeTextController.text.isNotEmpty &&
        _paymentAmountTextController.text.isNotEmpty &&
        _amountTextController.text.isNotEmpty) {
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

  void _customDialogProgress1() async {
    var pro =
        Provider.of<SellerProvider>(context, listen: false).createPaymentLink;
    var ghaf = Provider.of<ProductProvider>(context, listen: false);
    print('==============================create Link');
    print(pro.toString());
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s360,
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
                            // controller: _textController,
                            pro,
                            style: getMediumStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s14),
                          ),
                        ),
                        PositionedDirectional(
                          end: 0,
                          child: GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: pro));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Copied"),
                                ),
                              );
                            },
                            child: Container(
                              width: AppSize.s92,
                              padding: EdgeInsets.symmetric(
                                  vertical: AppPadding.p12,
                                  horizontal: AppPadding.p4),
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r8),
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
                      height: AppSize.s8,
                    ),
                    GestureDetector(
                      onTap: () {
                        ghaf.getWebpage(pro);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: AppPadding.p12,
                            horizontal: AppPadding.p4),
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
                      height: AppSize.s8,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String message = "Hello from Flutter!";
                        final urlWhatsUP =
                            "https://wa.me/?text=You can buy the product of my store through this link:\n${pro}";
                        await launch(urlWhatsUP);
                        print(urlWhatsUP);
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

                    GestureDetector(
                      onTap: () {
                        _contactEmail(_textController.text);
                      },
                      child: Row(
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

                    InkWell(
                      onTap: () {
                        _customDialog(pro);
                      },
                      child: Row(
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
                    ),
                    SizedBox(
                      height: AppSize.s12,
                    ),
                  ]),
            ),
          );
        });
  }

  void _customDialog(pro) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s410,
              width: AppSize.s306,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logo2,
                          height: AppSize.s60,
                          width: AppSize.s60,
                        ),
                        Text(
                          'Ghaf',
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s20,
                    ),

                    QrImageView(
                      data: pro,
                      size: 200.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK')),
                  ]),
            ),
          );
        });
  }

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
}
