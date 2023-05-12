import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/seller/seller_individual/individual_seller_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/items_list.dart';
import 'package:ghaf_application/presentation/screens/seller/individual_seller/store_seller_view.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/model/read-individual-products.dart';
import '../../../../providers/product_provider.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import '../individual_seller/products_with_out_details_seller_view.dart';

class CreateLinkGetxController extends GetxController with Helpers {
  List<ReadIndividualProducts> individualProducts = [];
  late ApiResponse apiResponse;
  late ApiResponse apiResponse1;
  String link = '';
  late final IndividualSellerApiController _individualSellerApiController =
      IndividualSellerApiController();

  List<dynamic> itemForLinkList = [];
  List<num> productCount = [];

  final TextEditingController amountTextController = TextEditingController();

  void getIndividualProducts({
    required BuildContext context,
    required bool isNotDetailed,
  }) async {
    try {
      individualProducts =
          await _individualSellerApiController.getIndividualProducts();
      update();
      if (isNotDetailed) {
        createLink(
            withDetails: !isNotDetailed,
            context: context,
            ItemForLinks: [
              {
                "prodId": individualProducts[0].id,
                "Quantity": num.parse(amountTextController.text)
              }
            ]);
      }
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void createProduct(
      {required BuildContext context,
      required String name,
      required String description,
      String? characteristics,
      required String productType,
      required num price,
      required bool isNotDetailed,
      required List<String> images}) async {
    // apiResponse = await _individualSellerApiController.createProduct(
    //     name: name,
    //     description: description,
    //     characteristics: characteristics,
    //     productType: productType,
    //     price: price.toString(),
    //     images: images);
    try {
      apiResponse = await _individualSellerApiController.createProduct(
          name: name,
          description: description,
          characteristics: characteristics,
          productType: productType,
          price: price,
          images: images);
      Navigator.of(context).pop();
      _customDialogProgressCreateProduct(context: context);
      // if (isNotDetailed) {
      //   getIndividualProducts(context: context, isNotDetailed: isNotDetailed);
      // } else {
      //   Navigator.of(context).pop();
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => ItemsList(),
      //   ));
      //   showSnackBar(context, message: apiResponse.message);
      // }
    } catch (e) {
      showSnackBar(context, message: e.toString(), error: true);
    }
  }

  void createLink({
    required BuildContext context,
    required List<dynamic> ItemForLinks,
    required bool withDetails,
  }) async {
    try {
      link = await _individualSellerApiController.createLink(
          ItemForLinks: ItemForLinks);
      _customDialogProgress1(withDetails: withDetails, context: context);
      update();
    } catch (e) {
      showSnackBar(context, message: e.toString(), error: true);
    }
  }

  void _customDialogProgressCreateProduct(
      {required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: AppSize.s343,
            child: Column(
              children: [
                SizedBox(height: AppSize.s18),
                Text(
                  AppLocalizations.of(context)!.success,
                  style: TextStyle(
                      fontSize: FontSize.s20,
                      color: ColorManager.primaryDark,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: AppSize.s35),
                Text(
                  AppLocalizations.of(context)!.your_order_is_under_progress,
                  style: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.s16),
                ),
                SizedBox(height: AppSize.s35),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ColorManager.primaryDark)),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => ItemsList(),
                          ));
                        },
                        child: Text(AppLocalizations.of(context)!.items_list)),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                ProductsWithOutDetailsSellerView(),
                          ));
                        },
                        child: Text(AppLocalizations.of(context)!.back)),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _customDialogProgress1(
      {required BuildContext context, required bool withDetails}) async {
    var ghaf = Provider.of<ProductProvider>(context, listen: false);

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
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
                            link,
                            style: getMediumStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s14),
                          ),
                        ),
                        PositionedDirectional(
                          end: 0,
                          child: GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: link));
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
                        ghaf.getWebpage(link);
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
                            "https://wa.me/?text=You can buy the product of my store through this link:\n${link}";
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
                        _contactEmail(link);
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
                        _customDialog(context: context, pro: link);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.qr_code_scanner,size: AppSize.s16),
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
                    Visibility(
                      visible: withDetails,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StoreSellerView(),
                              ));
                            },
                            child: Text(AppLocalizations.of(context)!.ok)),
                      ),
                    )
                  ]),
            ),
          );
        });
  }

  void _customDialog(
      {required BuildContext context, required String pro}) async {
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
                    QrImage(
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
