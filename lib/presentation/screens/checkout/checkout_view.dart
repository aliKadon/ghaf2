import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/screens/checkout/checkout_confirm_view.dart';
import 'package:ghaf_application/presentation/screens/checkout/payment_method_redeem_point_screen.dart';
import 'package:ghaf_application/presentation/screens/register_view/register_view_getx_controller.dart';
import 'package:ghaf_application/services/payment_service.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class CheckOutView extends StatefulWidget {
  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  late TextEditingController _paymentMethodTextController;

  late final RegisterViewGetXController _registerViewGetXController =
      Get.find<RegisterViewGetXController>();

  var visibility = false;
  var isSwitchedPayLater = false;
  var isSwitched = false;
  var visibilityChecked = false;
  late var paymentIntent;
  DateTime? date;
  var myAddress;
  var isAddressSelected = false;
  var deleveryMethod;
  var deleveryName;
  var selectedAddress;
  var isLoading = true;

  var dateTosend = DateTime.now();

  var selected;
  int selectedTime = 0;
  var pickUPID = '4f0db097-378f-4efa-bc17-08daf719ffd5';

  final paymentController = Get.put(PaymentController());

  bool _checkData(String methodName) {
    print(methodName);
    if (methodName == 'Pick up' || methodName == 'Car window') {
      if (date != null || myAddress != null) return true;
    } else {
      if (myAddress != null) return true;
    }
    return false;
  }

  //
  @override
  void initState() {
    super.initState();
    _paymentMethodTextController = TextEditingController();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _paymentMethodTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var order = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    print('---------------------==========================');
    // var deliveryMethode = Provider.of<ProductProvider>(context).deliveryMethode;
    // print(widget.order);

    return Scaffold(
      body: SafeArea(
        key: _scaffoldKey,
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: SingleChildScrollView(
            child:
                // height: MediaQuery.of(context).size.height * 1,
                Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          IconsAssets.arrow,
                          height: AppSize.s18,
                          width: AppSize.s10,
                        ),
                      ),
                      Spacer(),
                      Text(
                        AppLocalizations.of(context)!.checkout,
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s18,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Divider(height: 1, color: ColorManager.greyLight),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.delivery_method,
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        AppLocalizations.of(context)!.choose_route,
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    height: AppSize.s110,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        // itemCount: widget.order['deliveryMethod'].length,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = index;
                                selectedTime = index;
                              });
                              final snackBar = SnackBar(
                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Great!',

                                  message:
                                      '${AppLocalizations.of(context)!.you_choose} !',

                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType: ContentType.success,
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              setState(() {});

                              // if (widget.order.availableDeliveryMethod[index]
                              //         ['methodName'] ==
                              //     'Pick up') {
                              //   setState(() {
                              //     deleveryName = widget
                              //             .order.availableDeliveryMethod[index]
                              //         ['methodName'];
                              //     visibility = true;
                              //     deleveryMethod = widget.order
                              //         .availableDeliveryMethod[index]['id'];
                              //   });
                              // } else {
                              //   setState(() {
                              //     deleveryName = widget
                              //             .order.availableDeliveryMethod[index]
                              //         ['methodName'];
                              //     visibility = true;
                              //     deleveryMethod = widget.order
                              //         .availableDeliveryMethod[index]['id'];
                              //   });
                              // }
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: AppSize.s8,
                              ),
                              child: Column(
                                children: [
                                  selected == index
                                      ? Container(
                                          height: AppSize.s75,
                                          width: AppSize.s75,
                                          padding:
                                              EdgeInsets.all(AppPadding.p12),
                                          decoration: BoxDecoration(
                                            color: ColorManager.primary,
                                            border: Border.all(
                                                width: AppSize.s1,
                                                color: ColorManager.greyLight),
                                            borderRadius: BorderRadius.circular(
                                                AppRadius.r4),
                                          ),
                                          child: Icon(
                                            Icons.delivery_dining,
                                            color: ColorManager.primary,
                                          ),
                                        )
                                      : Container(
                                          height: AppSize.s75,
                                          width: AppSize.s75,
                                          padding:
                                              EdgeInsets.all(AppPadding.p12),
                                          decoration: BoxDecoration(
                                            color: ColorManager.white,
                                            border: Border.all(
                                                width: AppSize.s1,
                                                color: ColorManager.greyLight),
                                            borderRadius: BorderRadius.circular(
                                                AppRadius.r4),
                                          ),
                                          child: Icon(
                                            Icons.delivery_dining,
                                            color: ColorManager.primaryDark,
                                          ),
                                        ),
                                  SizedBox(
                                    height: AppSize.s7,
                                  ),
                                  Text(
                                    // widget.order['id'],
                                    // deliveryMethode[index].methodName!,
                                    'delivery',
                                    style: getMediumStyle(
                                      color: ColorManager.primary,
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: AppSize.s22,
                  ),
                  Container(
                    height: AppSize.s58,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.white,
                        border: Border.all(color: ColorManager.greyLight)),
                    child: Row(
                      children: [
                        Icon(Icons.delivery_dining),
                        SizedBox(
                          width: AppSize.s20,
                        ),
                        Text('It takes 11 minutes',
                            style: TextStyle(
                                color: ColorManager.primary,
                                fontWeight: FontWeight.w500)),
                        // SizedBox(width: AppSize.s20,),
                        Spacer(),
                        Text(
                          'change',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s22,
                  ),
                  Text(AppLocalizations.of(context)!.payment_method,
                      style: TextStyle(
                          color: ColorManager.primaryDark,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.s16)),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    height: AppSize.s58,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.white,
                        border: Border.all(color: ColorManager.greyLight)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: AppSize.s20,
                        ),
                        Text(
                            AppLocalizations.of(context)!
                                .select_the_payment_method,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13)),
                        // SizedBox(width: AppSize.s20,),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PaymentMethodRedeemPointScreen(),
                            ));
                          },
                          child: Icon(
                            Icons.arrow_drop_down_circle_rounded,
                            color: ColorManager.primaryDark,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    child: Visibility(
                      visible: true,
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.pay_later,
                            style: getSemiBoldStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s16,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                _infoDialog(
                                    context,
                                    AppLocalizations.of(context)!
                                        .pay_later_text);
                              },
                              child: Icon(Icons.info_outline,
                                  color: ColorManager.greyLight)),
                          Spacer(),
                          CupertinoSwitch(
                            value: isSwitchedPayLater,
                            onChanged: (_) {
                              setState(() {
                                if (isSwitchedPayLater == false) {
                                  isSwitchedPayLater = true;
                                  isSwitched = false;
                                } else {
                                  isSwitchedPayLater = false;
                                  isSwitched = true;
                                }
                                if (isSwitchedPayLater) {
                                  setState(() {});
                                } else {
                                  setState(() {});
                                }
                                print(isSwitchedPayLater);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s22,
                  ),
                  Text(
                    AppLocalizations.of(context)!.order_details,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      border: Border.all(
                        color: ColorManager.greyLight,
                      ),
                    ),
                    // margin: EdgeInsets.only(
                    //     bottom: AppMargin.m16,
                    //     right: AppMargin.m16,
                    //     left: AppMargin.m16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '1 x coffee',
                              style: getSemiBoldStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '100 ${AppLocalizations.of(context)!.aed}',
                              style: getSemiBoldStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: true,
                          child: Row(
                            children: [
                              Text(
                                '3 x Cake',
                                style: getSemiBoldStyle(
                                  color: ColorManager.grey,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '20 ${AppLocalizations.of(context)!.aed}',
                                style: getSemiBoldStyle(
                                  color: ColorManager.grey,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 1, color: ColorManager.greyLight),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.total,
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '100 ${AppLocalizations.of(context)!.aed}',
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s22,
                  ),
                  Text(
                    AppLocalizations.of(context)!.order_summary,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      border: Border.all(
                        color: ColorManager.greyLight,
                      ),
                    ),
                    // margin: EdgeInsets.only(
                    //     bottom: AppMargin.m16,
                    //     right: AppMargin.m16,
                    //     left: AppMargin.m16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.subtotal,
                              style: getSemiBoldStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '100 ${AppLocalizations.of(context)!.aed}',
                              style: getSemiBoldStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: true,
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.discount,
                                style: getSemiBoldStyle(
                                  color: ColorManager.grey,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '20 ${AppLocalizations.of(context)!.aed}',
                                style: getSemiBoldStyle(
                                  color: ColorManager.grey,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.delivery_fee,
                              style: getSemiBoldStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '100 ${AppLocalizations.of(context)!.aed}',
                              style: getSemiBoldStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.redeem_point,
                              style: getSemiBoldStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '100 ${AppLocalizations.of(context)!.point}',
                              style: getSemiBoldStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                        Divider(thickness: 1, color: ColorManager.greyLight),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.total,
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '100 ${AppLocalizations.of(context)!.aed}',
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s22,
                  ),

                  Container(
                    // width: MediaQuery.of(context).size.width * 0.8,
                    // height: MediaQuery.of(context).size.height * 0.05,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(color: ColorManager.greyLight)),
                    child: Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: TextField(
                                decoration: InputDecoration(
                                    label: Row(
                                  children: [
                                    Text(AppLocalizations.of(context)!
                                        .enter_promo_code),
                                  ],
                                )),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.s16))),
                        GestureDetector(
                            onTap: () {
                              _infoDialog(
                                  context,
                                  AppLocalizations.of(context)!
                                      .promo_code_info);
                            },
                            child: Icon(Icons.info_outline,
                                color: ColorManager.greyLight)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.use_reedem,
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  _infoDialog(
                                      context,
                                      AppLocalizations.of(context)!
                                          .redeem_point_info);
                                },
                                child: Icon(Icons.info_outline,
                                    color: ColorManager.greyLight)),
                          ],
                        ),
                        Spacer(),
                        CupertinoSwitch(
                          value: isSwitched,
                          onChanged: (_) {
                            setState(() {
                              if (isSwitched == false) {
                                isSwitched = true;
                                isSwitchedPayLater = false;
                              } else {
                                isSwitched = false;
                                isSwitchedPayLater = true;
                              }
                              print(isSwitched);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAddress = index;
                          });
                          print('====================address checkout');

                          final snackBar = SnackBar(
                            /// need to set following properties for best effect of awesome_snackbar_content
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Great!',
                              message: 'You pick address Number ${index + 1} !',

                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                              contentType: ContentType.success,
                            ),
                          );

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                          SnackBar(
                            content: Text('You pick address Number $index'),
                            backgroundColor: Colors.green,
                          );
                        },
                        child: Visibility(
                          visible: true,
                          child: Column(
                            children: [
                              Row(children: [
                                Text(
                                  AppLocalizations.of(context)!.address,
                                  style: getSemiBoldStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  AppLocalizations.of(context)!.choose_route,
                                  style: getSemiBoldStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s10,
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: AppSize.s12,
                              ),
                              selectedAddress == index
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppPadding.p8),
                                      decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius:
                                            BorderRadius.circular(AppRadius.r8),
                                        border: Border.all(
                                            width: AppSize.s1,
                                            color: ColorManager.grey),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: AppSize.s14,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Home',
                                                style: getSemiBoldStyle(
                                                  color:
                                                      ColorManager.primaryDark,
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
                                              IconsAssets.location2,
                                              height: AppSize.s15,
                                              width: AppSize.s11,
                                            ),
                                            SizedBox(
                                              width: AppSize.s8,
                                            ),
                                            Text(
                                              'Home',
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
                                              IconsAssets.person,
                                              height: AppSize.s15,
                                              width: AppSize.s14,
                                            ),
                                            SizedBox(
                                              width: AppSize.s8,
                                            ),
                                            Text(
                                              'zidan zidan',
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
                                              IconsAssets.call2,
                                              height: AppSize.s18,
                                              width: AppSize.s18,
                                            ),
                                            SizedBox(
                                              width: AppSize.s8,
                                            ),
                                            Text(
                                              '022587467',
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
                                    )
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppPadding.p8),
                                      decoration: BoxDecoration(
                                        // color: ColorManager.primary,
                                        borderRadius:
                                            BorderRadius.circular(AppRadius.r8),
                                        border: Border.all(
                                            width: AppSize.s1,
                                            color: ColorManager.grey),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: AppSize.s14,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Home',
                                                style: getSemiBoldStyle(
                                                  color:
                                                      ColorManager.primaryDark,
                                                  fontSize: FontSize.s16,
                                                ),
                                              ),
                                              Spacer(),
                                              Visibility(
                                                visible: false,
                                                child: Icon(
                                                  Icons.check_circle,
                                                  color:
                                                      Colors.lightGreenAccent,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: AppSize.s10,
                                          ),
                                          Row(children: [
                                            Image.asset(
                                              IconsAssets.location1,
                                              height: AppSize.s15,
                                              width: AppSize.s11,
                                            ),
                                            SizedBox(
                                              width: AppSize.s8,
                                            ),
                                            Text(
                                              'Home',
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
                                              IconsAssets.person,
                                              height: AppSize.s15,
                                              width: AppSize.s14,
                                            ),
                                            SizedBox(
                                              width: AppSize.s8,
                                            ),
                                            Text(
                                              'zidan zidan',
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
                                              '02478659',
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
                              // SizedBox(
                              //   height: AppSize.s10,
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: AppSize.s22,
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.order_note,
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            _infoDialog(context,
                                AppLocalizations.of(context)!.order_note_info);
                          },
                          child: Icon(Icons.info_outline,
                              color: ColorManager.greyLight)),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorManager.greyLight)),
                    child: TextField(
                        decoration: InputDecoration(
                          label: Text(
                            AppLocalizations.of(context)!.send_note,
                          ),
                        ),
                        maxLines: 3),
                  ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.all(12),
                  //       width: MediaQuery.of(context).size.width * 0.6,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12.r),
                  //         color: Colors.white,
                  //         border: Border.all(
                  //           color: Color(0xff125051),
                  //         ),
                  //       ),
                  //       child: Text(
                  //         date == null
                  //             ? AppLocalizations.of(context)!.pick_date
                  //             : date.toString().substring(0, 10),
                  //         style: getSemiBoldStyle(
                  //           color: ColorManager.primaryDark,
                  //           fontSize: FontSize.s16,
                  //         ),
                  //       ),
                  //     ),
                  //     Spacer(),
                  //     GestureDetector(
                  //       onTap: () {
                  //         // _registerViewGetXController.selectBirthDate(
                  //         //     context: context);
                  //         // selectBirthDate(context: context);
                  //         showDialog(
                  //           context: context,
                  //           builder: (context) {
                  //             return Dialog(
                  //               child: Container(
                  //                 // height: MediaQuery.of(context).size.height * 0.7,
                  //                 // width: MediaQuery.of(context).size.height * 0.7,
                  //                 padding: EdgeInsets.symmetric(
                  //                     horizontal: AppPadding.p12),
                  //                 decoration: BoxDecoration(
                  //                   color: ColorManager.white,
                  //                   borderRadius:
                  //                       BorderRadius.circular(AppRadius.r8),
                  //                 ),
                  //                 // child: SizedBox(
                  //                 // height: MediaQuery.of(context).size.height * 1,
                  //                 child: Container(
                  //                   height: MediaQuery.of(context).size.height *
                  //                       0.4,
                  //                   child: Column(
                  //                     children: [
                  //                       Container(
                  //                         height: MediaQuery.of(context)
                  //                                 .size
                  //                                 .height *
                  //                             0.3,
                  //                         child: CupertinoDatePicker(
                  //                           mode: CupertinoDatePickerMode.date,
                  //                           initialDateTime:
                  //                               DateTime(2023, 1, 1),
                  //                           onDateTimeChanged: (newDateTime) {
                  //                             print(
                  //                                 '======================newDate');
                  //                             print(newDateTime);
                  //                             // Do something
                  //                             setState(() {
                  //                               if (newDateTime == null) {
                  //                                 date = null;
                  //                               } else {
                  //                                 date = newDateTime;
                  //                                 dateTosend = newDateTime;
                  //                               }
                  //                             });
                  //                           },
                  //                         ),
                  //                       ),
                  //                       GestureDetector(
                  //                         onTap: () => Navigator.pop(context),
                  //                         child: Container(
                  //                           width: MediaQuery.of(context)
                  //                                   .size
                  //                                   .height *
                  //                               0.5,
                  //                           height: MediaQuery.of(context)
                  //                                   .size
                  //                                   .height *
                  //                               0.07,
                  //                           alignment: Alignment.center,
                  //                           decoration: BoxDecoration(
                  //                             color: ColorManager.primary,
                  //                             borderRadius:
                  //                                 BorderRadius.circular(
                  //                                     AppRadius.r8),
                  //                           ),
                  //                           child: Text(
                  //                             AppLocalizations.of(context)!.yes,
                  //                             textAlign: TextAlign.center,
                  //                             style: getMediumStyle(
                  //                                 color: ColorManager.white),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         );
                  //       },
                  //       child: Container(
                  //         height: AppSize.s75,
                  //         width: AppSize.s75,
                  //         padding: EdgeInsets.all(8),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(12.r),
                  //           color: Colors.white,
                  //           border: Border.all(
                  //             color: Color(0xff125051),
                  //           ),
                  //         ),
                  //         child: Icon(
                  //           Icons.date_range,
                  //           // height: AppSize.s36,
                  //           // width: AppSize.s36,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // CardField(
                  //   enablePostalCode: false,
                  //   onCardChanged: (card) {
                  //     setState(() {});
                  //   },
                  // ),
                  SizedBox(
                    height: AppSize.s44,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: AppMargin.m16,
                        ),
                        // width: double.infinity,
                        height: AppSize.s55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckOutConfirmView(),));
                            print('================================orderID');

                            print(deleveryMethod);
                            print(Helpers.formatDate(dateTosend));
                            print(myAddress);
                            print(isSwitched);
                            // if (deleveryMethod == 'Pick up' && date == 'null') {
                            //   final snackBar = SnackBar(
                            //     /// need to set following properties for best effect of awesome_snackbar_content
                            //     elevation: 0,
                            //     behavior: SnackBarBehavior.floating,
                            //     backgroundColor: Colors.transparent,
                            //     content: AwesomeSnackbarContent(
                            //       title: 'Oh No!',
                            //       message: 'You must pick a date please !',
                            //
                            //       /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            //       contentType: ContentType.failure,
                            //     ),
                            //   );
                            // }

                            if (_checkData(deleveryName)) {}
                            if (_checkData(deleveryName) == false) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .enter_required_data),
                                  backgroundColor: Colors.red,
                                ));
                              // final snackBar = SnackBar(
                              //   /// need to set following properties for best effect of awesome_snackbar_content
                              //   elevation: 0,
                              //   behavior: SnackBarBehavior.floating,
                              //   backgroundColor: Colors.transparent,
                              //   content: AwesomeSnackbarContent(
                              //     title: 'Oh No!',
                              //     message: 'You must pick a delivery method !',
                              //
                              //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                              //     contentType: ContentType.failure,
                              //   ),
                              // );
                            }
                            print(
                                'orderaddrs ----------------------${myAddress.id}');
                            // if (deleveryMethod != 'Pick up' && addresses == null) {
                            //
                            // }else {
                            //
                            // }

                            // paymentController.makePayment(context: context,amount: payLater.toString(), currency: 'AED');
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (builder) => CheckOutConfirmView()),
                            // );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.checkout,
                            style: getSemiBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s18),
                          ),
                        ),
                      ),
                      Container(
                        height: AppSize.s55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: ColorManager.primaryDark)))),
                            onPressed: () {},
                            child: Text(
                              AppLocalizations.of(context)!.add_item,
                              style: TextStyle(color: ColorManager.primaryDark),
                            )),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s24,
                  ),
                  // SnappingSheet(
                  //   sheetBelow: SnappingSheetContent(child: Container(child: Text('HIII'),)),
                  //   grabbingHeight: 75,
                  //
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.r8),
      borderSide: BorderSide(
        width: AppSize.s1,
        color: color,
      ),
    );
  }

  // select birth date.
  void selectBirthDate({
    required BuildContext context,
  }) async {
    DateTime? date = await showDatePicker(
      context: context,
      // initialDate: birthDate == null
      //     ? DateTime(DateTime.now().year - 15)
      //     : DateTime.parse(birthDate!),
      initialDate: DateTime(DateTime.now().year - 15),
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime(DateTime.now().year - 15),
    );
    if (date == null) return;
    // birthDate = Helpers.formatDate(date);
    // birthDateTextEditingController.text = birthDate!;
  }

// Future<void> makePayment() async {
//   try {
//     //STEP 1: Create Payment Intent
//     paymentIntent = await createPaymentIntent('11000', 'USD');
//
//     //STEP 2: Initialize Payment Sheet
//     await Stripe.instance
//         .initPaymentSheet(
//
//         paymentSheetParameters: SetupPaymentSheetParameters(
//             paymentIntentClientSecret: paymentIntent![
//             'client_secret'], //Gotten from payment intent
//             style: ThemeMode.light,
//             merchantDisplayName: 'Ikay'))
//         .then((value) {});
//
//     //STEP 3: Display Payment sheet
//     displayPaymentSheet();
//   } catch (err) {
//     throw Exception(err);
//   }
// }
// createPaymentIntent(String amount, String currency) async {
//   try {
//     //Request body
//     Map<String, dynamic> body = {
//       'amount': amount,
//       'currency': currency,
//     };
//
//     //Make post request to Stripe
//     var response = await http.post(
//       Uri.parse('https://api.stripe.com/v1/payment_intents'),
//       headers: {
//         'Authorization': 'Bearer sk_test_51MLP4SIQef6xe4xw6JFXtWWrBmt2gsL4aat9wb3VKXRNp2P7tQ34iiqmg8Ua1OCUvtdne9QzOpeWinx1ix94BOto005KnKf7xD}',
//         'Content-Type': 'application/x-www-form-urlencoded'
//       },
//       body: body,
//     );
//     return json.decode(response.body);
//   } catch (err) {
//     throw Exception(err.toString());
//   }
// }
//
// displayPaymentSheet() async {
//   try {
//     await Stripe.instance.presentPaymentSheet().then((value) {
//
//       //Clear paymentIntent variable after successful payment
//       paymentIntent = null;
//
//     })
//         .onError((error, stackTrace) {
//       throw Exception(error);
//     });
//   }
//   on StripeException catch (e) {
//     print('Error is:---> $e');
//   }
//   catch (e) {
//     print('$e');
//   }
// }
}

void _infoDialog(BuildContext context, String text) async {
  showDialog(
    context: context,
    builder: (context) {
      return Stack(
        children: [
          SharedPrefController().lang1 == 'en'
              ? Positioned(
                  top: 0,
                  bottom: -230,
                  child: Dialog(
                    backgroundColor: ColorManager.greyLight,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      width: 250,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: ColorManager.greyLight,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(text,
                              style:
                                  TextStyle(color: ColorManager.primaryDark))),
                    ),
                  ),
                )
              : Positioned(
                  top: 0,
                  bottom: -250,
                  child: Dialog(
                    backgroundColor: ColorManager.greyLight,
                    child: Container(
                      height: 85,
                      width: 100,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: ColorManager.greyLight,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(AppLocalizations.of(context)!.pay_later_text,
                          style: TextStyle(color: ColorManager.primaryDark)),
                    ),
                  ),
                ),
        ],
      );
    },
  );
}
