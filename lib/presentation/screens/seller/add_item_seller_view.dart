import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:ghaf_application/providers/seller_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AddItemSellerView extends StatefulWidget {
  // const AddItemSellerView({Key? key}) : super(key: key);

  var isShow2;
  AddItemSellerView(this.isShow2);

  @override
  State<AddItemSellerView> createState() => _AddItemSellerViewState();
}

class _AddItemSellerViewState extends State<AddItemSellerView> with Helpers {
  var productCount = 0;
  var selected = 0;
  var selected2 = 0;

  final TextEditingController _textController = TextEditingController();

  //send from email
  void _contactEmail(String body) async {
    launch("mailto:");
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  void initState() {
    Provider.of<SellerProvider>(context, listen: false)
        .readIndividualProducts();
    super.initState();
  }

  var isStrore = false;



  @override
  Widget build(BuildContext context) {
    var repo = Provider.of<SellerProvider>(context).repo;
    if( widget.isShow2 != null) {
      isStrore = widget.isShow2;
    }

    var provider = Provider.of<SellerProvider>(context).readIndividualProduct;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppSize.s9,
                ),
                Row(
                  children: [
                    isStrore ? GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.038,
                        width: MediaQuery.of(context).size.width * 0.08,
                        child: Image.asset(
                          SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                          height: AppSize.s18,
                          width: AppSize.s10,
                        ),
                      ),
                    ) : Container(),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.add_item,
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s24),
                    ),
                    Spacer(),
                    Container(
                      height: AppSize.s24,
                      width: AppSize.s24,
                    ),
                  ],
                ),
                isStrore ? SizedBox(
                  height: AppSize.s20,
                ) : Container(),
                isStrore ? Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Row(
                      children: [
                        Image.asset(
                          IconsAssets.plus2,
                          height: AppSize.s24,
                          width: AppSize.s24,
                        ),
                        SizedBox(
                          width: AppSize.s8,
                        ),
                        Text(
                          AppLocalizations.of(context)!.create_new_item,
                          style: getMediumStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s18),
                        ),
                      ],
                    ),
                  ),
                ) : Container(),
                SizedBox(
                  height: AppSize.s22,
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.select_one_item,
                    style: getMediumStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18),
                  ),
                ),
                SizedBox(
                  height: AppSize.s22,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: provider.length,
                  itemBuilder: (context, index) {
                    return Card(
                      // padding: EdgeInsets.all(AppSize.s6),
                      child: ListTile(
                        leading: provider[index].ghafImageIndividual?[0].data ==
                                null
                            ? ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: Image.asset(
                                  ImageAssets.logo1,
                                  height: AppSize.s60,
                                  width: AppSize.s60,
                                ),
                              )
                            : ClipRRect(
                                child: Image.network(provider[index]
                                    .ghafImageIndividual![0].data!),
                              ),
                        title: Text(
                          provider[index].name!,
                          style: getMediumStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s18),
                        ),
                        subtitle: Text(
                          '${provider[index].price.toString()} ${AppLocalizations.of(context)!.aed} ',
                          style: getRegularStyle(
                              color: ColorManager.greyLight,
                              fontSize: FontSize.s16),
                        ),
                        trailing: Container(
                          // width: MediaQuery.of(context).size.width * 0.12,
                          child: FittedBox(
                            child: Row(children: [
                              InkWell(
                                onTap: () {
                                  setState(() {

                                    selected = index;
                                    if(selected2 != selected) {
                                      selected2 = selected;
                                      productCount = 0;
                                    }
                                    productCount++;
                                  });
                                },
                                child: Image.asset(
                                  IconsAssets.plus1,
                                  height: AppSize.s31,
                                  width: AppSize.s31,
                                ),
                              ),
                              SizedBox(
                                width: AppSize.s8,
                              ),
                              selected == index
                                  ? Text(productCount.toString(),
                                      style: TextStyle(color: Colors.orange))
                                  : Text('0',
                                      style: TextStyle(color: Colors.orange)),
                              SizedBox(
                                width: AppSize.s8,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = index;
                                    if(selected2 != selected) {
                                      selected2 = selected;
                                      productCount = 0;
                                    }
                                    if (productCount == 0) {
                                      productCount = 0;
                                    } else {
                                      productCount--;
                                    }
                                  });
                                },
                                child: Image.asset(
                                  IconsAssets.minus1,
                                  height: AppSize.s31,
                                  width: AppSize.s31,
                                ),
                              ),
                              SizedBox(
                                width: AppSize.s10,
                              ),
                            ]),
                          ),
                        ),
                      ),

                      // Row(
                      //   children: [
                      //     provider[index].ghafImageIndividual[0]['data'] == null
                      //         ? Image.asset(
                      //             ImageAssets.logo1,
                      //             height: AppSize.s73,
                      //             width: AppSize.s73,
                      //           )
                      //         : Image.memory(
                      //             base64Decode(provider[index].ghafImageIndividual[0]['data'])),
                      //     SizedBox(
                      //       width: AppSize.s8,
                      //     ),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           provider[index].name,
                      //           style: getMediumStyle(
                      //               color: ColorManager.primaryDark,
                      //               fontSize: FontSize.s18),
                      //         ),
                      //         SizedBox(
                      //           height: AppSize.s6,
                      //         ),
                      //         Text(
                      //           provider[index].price.toString(),
                      //           style: getRegularStyle(
                      //               color: ColorManager.greyLight,
                      //               fontSize: FontSize.s16),
                      //         ),
                      //       ],
                      //     ),
                      //     Spacer(),
                      //     Column(children: [
                      //       InkWell(
                      //         onTap: () {
                      //           setState(() {
                      //             productCount++;
                      //           });
                      //         },
                      //         child: Image.asset(
                      //           IconsAssets.plus1,
                      //           height: AppSize.s31,
                      //           width: AppSize.s31,
                      //         ),
                      //       ),
                      //       Text(productCount.toString()),
                      //       InkWell(
                      //         onTap: () {
                      //           setState(() {
                      //             if(productCount == 0) {
                      //               productCount = 0;
                      //             }else {
                      //               productCount--;
                      //             }
                      //           });
                      //         },
                      //         child: Image.asset(
                      //           IconsAssets.minus1,
                      //           height: AppSize.s31,
                      //           width: AppSize.s31,
                      //         ),
                      //       ),
                      //     ]),
                      //   ],
                      // ),
                    );
                  },
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Provider.of<SellerProvider>(context, listen: false)
                            .createPaymnetLink(
                                provider[selected].id!, productCount.toString())
                            .then((value) => _customDialogProgress());

                        // Provider.of<SellerProvider>(context,listen: false)
                        //     .createPaymnetLink(
                        //         provider[selected].id, productCount)
                        //     .then((value) => ScaffoldMessenger.of(context)
                        //             .showSnackBar(SnackBar(
                        //           content: Text('Wait a second please!'),
                        //           backgroundColor: Colors.green,
                        //         )))
                        //     .then((value) => _customDialogProgress());
                        // _customDialogProgress();
                      },
                      child: Text(AppLocalizations.of(context)!.create_link)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _customDialogProgress() async {
    var pro =
        Provider.of<SellerProvider>(context, listen: false).createPaymentLink;
    var ghaf =Provider.of<ProductProvider>(context, listen: false);
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
                              Clipboard.setData(
                                  ClipboardData(text: pro));
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
                      onTap: (){
                        ghaf.getWebpage(
                            pro);
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
                      onTap: (){
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
                    QrImage(
                      data: pro,
                      size: 200.0,
                    ),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('OK')),
                  ]),
            ),
          );
        });
  }

}
