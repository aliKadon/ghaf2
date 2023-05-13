import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../checkout/check_out_getx_controller.dart';
import '../checkout/order_tracking_screen.dart';
import 'controller/help_getx_controller.dart';

class ReportDelayedScreen extends StatefulWidget {
  String? orderId;
  String? name;
  String? imageUrl;

  ReportDelayedScreen({this.orderId, this.name, this.imageUrl});

  @override
  State<ReportDelayedScreen> createState() => _ReportDelayedScreenState();
}

class _ReportDelayedScreenState extends State<ReportDelayedScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  AppLocalizations.of(context)!.report_delayed_delivery,
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
                  widget.imageUrl == null || widget.imageUrl == ''
                      ? Container(
                          height: AppSize.s110,
                          width: AppSize.s110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s20),
                              image: DecorationImage(
                                  image: AssetImage(ImageAssets.pizza))),
                        )
                      : Container(
                          height: AppSize.s110,
                          width: AppSize.s110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s20),
                              image: DecorationImage(
                                  image: NetworkImage(widget.imageUrl!))),
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
                      SizedBox(
                        height: AppSize.s14,
                      ),
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
              AppLocalizations.of(context)!.order_Number,
              style: TextStyle(
                  color: ColorManager.primaryDark,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s18),
            ),
            Text(
              '# ${_checkOutGetxController.order?.sequenceNumber}',
              style: TextStyle(
                  color: ColorManager.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s16),
            ),
            SizedBox(
              height: AppSize.s24,
            ),
            Text(
              AppLocalizations.of(context)!.address,
              style: TextStyle(
                  color: ColorManager.primaryDark,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.s18),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
                border: Border.all(width: AppSize.s1, color: ColorManager.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSize.s14,
                  ),
                  Row(
                    children: [
                      Text(
                        '${_checkOutGetxController.order?.deliveryPoint?.addressName}',
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(children: [
                    Image.asset(
                      IconsAssets.location,
                      height: AppSize.s15,
                      width: AppSize.s11,
                    ),
                    SizedBox(
                      width: AppSize.s8,
                    ),
                    Text(
                      '${_checkOutGetxController.order?.deliveryPoint?.buildingOrStreetName}',
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ]),
                  // Row(children: [
                  //   Image.asset(
                  //     IconsAssets.person,
                  //     height: AppSize.s15,
                  //     width: AppSize.s14,
                  //   ),
                  //   SizedBox(
                  //     width: AppSize.s8,
                  //   ),
                  //   Text(
                  //     'zidan zidan',
                  //     style: getRegularStyle(
                  //       color: ColorManager.black,
                  //     ),
                  //   ),
                  // ]),
                  SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(children: [
                    Image.asset(
                      IconsAssets.person,
                      height: AppSize.s18,
                      width: AppSize.s18,
                    ),
                    SizedBox(
                      width: AppSize.s8,
                    ),
                    Text(
                      '${AppSharedData.currentUser?.firstName} ${AppSharedData.currentUser?.lastName}',
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(children: [
                    Image.asset(
                      IconsAssets.call,
                      height: AppSize.s18,
                      width: AppSize.s18,
                    ),
                    SizedBox(
                      width: AppSize.s8,
                    ),
                    Text(
                      '${_checkOutGetxController.order?.deliveryPoint?.phone}',
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: AppSize.s22,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s22,
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      // canLaunchUrl('tel://+1234567890'),
                      // await call(
                      //     Telephone: widget.orderId['branch']
                      //         ['telephone']);
                      _callShopDialog(
                          context,
                          _checkOutGetxController.order?.branch?.telephone ??
                              '22114488');
                    },
                    child: Container(
                      width: AppSize.s60,
                      height: AppSize.s110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            IconsAssets.call2,
                            color: Colors.white,
                            height: AppSize.s22,
                            width: AppSize.s22,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Call Shop',
                            style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      _helpGetxController.cancelOrder(
                          context: context,
                          id: _checkOutGetxController.order!.id!);
                      // canLaunchUrl('tel://+1234567890'),
                      // await call(
                      //     Telephone: widget.orderId['branch']
                      //         ['telephone']);
                    },
                    child: Container(
                      width: AppSize.s60,
                      height: AppSize.s110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageAssets.x,
                            color: Colors.white,
                            height: AppSize.s22,
                            width: AppSize.s22,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            AppLocalizations.of(context)!.canceling_order,
                            style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      _helpGetxController.requestCallBack(
                          context: context,
                          bid: _checkOutGetxController.order!.branch!.id!);
                      // canLaunchUrl('tel://+1234567890'),
                      // await call(
                      //     Telephone: widget.orderId['branch']
                      //         ['telephone']);
                    },
                    child: Container(
                      width: AppSize.s60,
                      height: AppSize.s110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone_callback,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Request a call back',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _callShopDialog(BuildContext context, String telephone) async {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              // top: 0,
              bottom: 0,
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.16,
                  // color: Colors.transparent,
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.all(AppSize.s8),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(AppSize.s10)),
                  child: Column(
                    children: [
                      Container(
                        height: AppSize.s44,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _contactPhoneNumber(telephone);
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: AppSize.s30,
                                ),
                                Icon(
                                  Icons.phone,
                                  color: ColorManager.primaryDark,
                                ),
                                Spacer(),
                                Text(
                                  telephone,
                                  style: TextStyle(
                                      color: ColorManager.primaryDark),
                                ),
                                Spacer(),
                              ],
                            )),
                      ),
                      SizedBox(height: AppSize.s22),
                      Container(
                        height: AppSize.s44,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.cancel,
                              style: TextStyle(color: ColorManager.primaryDark),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  // open phone number in mobile
  void _contactPhoneNumber(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
