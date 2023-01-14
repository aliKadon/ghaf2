import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/screens/register_view/register_view_getx_controller.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:ghaf_application/services/payment_service.dart';
import 'package:provider/provider.dart';

import '../../domain/model/available_delevey_method.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class CheckOutView extends StatefulWidget {
  final OrderAllInformation order;

  // const CheckOutView({
  //   Key? key,
  //   required this.order,
  // }) : super(key: key);
  // const CheckOutView({Key? key}) : super(key: key);
  CheckOutView(this.order);

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
  late var payLater = widget.order.orderDetails['totalCostForItems'];
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
  var pickUPID = 'a81c89e4-89e3-4cd9-7701-08dae6cfbd9a';

  final paymentController = Get.put(PaymentController());

  bool _checkData(String methodName) {
    print(methodName);
    if (methodName == 'Pick up') {
      if (date != null) return true;
    } else {
      if (myAddress != null) return true;
    }
    return false;
  }

  @override
  void initState() {
    // Provider.of<ProductProvider>(context,listen: false).getAllDetailsOrder();
    Provider.of<ProductProvider>(context, listen: false)
        .getAddress()
        .then((value) => isLoading = false);
    if (widget.order.orderDetails['canPayLaterValue'] == 0) {
      visibilityChecked = false;
    } else {
      visibilityChecked = true;
    }
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

    var addresses = Provider.of<ProductProvider>(context).address;
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
                        itemCount: widget.order.availableDeliveryMethod.length,
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
                                      '${AppLocalizations.of(context)!.you_choose} ${widget.order.availableDeliveryMethod[index]['methodName']}!',

                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType: ContentType.success,
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);

                              if (widget.order.availableDeliveryMethod[index]
                                      ['methodName'] ==
                                  'Pick up') {
                                setState(() {
                                  deleveryName = widget
                                          .order.availableDeliveryMethod[index]
                                      ['methodName'];
                                  visibility = true;
                                  deleveryMethod = widget.order
                                      .availableDeliveryMethod[index]['id'];
                                });
                              } else {
                                setState(() {
                                  deleveryName = widget
                                          .order.availableDeliveryMethod[index]
                                      ['methodName'];
                                  visibility = true;
                                  deleveryMethod = widget.order
                                      .availableDeliveryMethod[index]['id'];
                                });
                              }
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
                                          child: Image.network(
                                            // fit: BoxFit.contain,
                                            widget.order
                                                    .availableDeliveryMethod[
                                                index]['methodImage'],
                                            height: AppSize.s50,
                                            width: AppSize.s50,
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
                                          child: Image.network(
                                            // fit: BoxFit.contain,
                                            '${widget.order.availableDeliveryMethod[index]['methodImage']}',
                                            height: AppSize.s50,
                                            width: AppSize.s50,
                                          ),
                                        ),
                                  SizedBox(
                                    height: AppSize.s7,
                                  ),
                                  Text(
                                    // widget.order['id'],
                                    // deliveryMethode[index].methodName!,
                                    widget.order.availableDeliveryMethod[index]
                                        ['methodName'],
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
                        color: Color(0xff125051),
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
                              AppLocalizations.of(context)!.total,
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${widget.order.orderDetails['totalCostForItems'].toString()} ${AppLocalizations.of(context)!.aed}',
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: visibilityChecked,
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.you_can_pay_later,
                                style: getSemiBoldStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${widget.order.orderDetails['canPayLaterValue'].toString()} ${AppLocalizations.of(context)!.aed}',
                                style: getSemiBoldStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  isLoading
                      ? Center(
                          child: Container(
                            width: 20.h,
                            height: 20.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: addresses.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedAddress = index;
                                });
                                print('====================address checkout');
                                print(addresses[index]);
                                myAddress = addresses[index];
                                final snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Great!',
                                    message:
                                        'You pick address Number ${index + 1} !',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.success,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                                SnackBar(
                                  content:
                                      Text('You pick address Number $index'),
                                  backgroundColor: Colors.green,
                                );
                              },
                              child: Visibility(
                                visible: visibility,
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
                                                  BorderRadius.circular(
                                                      AppRadius.r8),
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
                                                      addresses[index]
                                                          .addressName!,
                                                      style: getSemiBoldStyle(
                                                        color: ColorManager
                                                            .primaryDark,
                                                        fontSize: FontSize.s16,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Visibility(
                                                      visible: false,
                                                      child: Icon(
                                                        Icons.check_circle,
                                                        color: Colors
                                                            .lightGreenAccent,
                                                      ),
                                                    )
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
                                                    addresses[index]
                                                        .addressName!,
                                                    style: getRegularStyle(
                                                      color: ColorManager.black,
                                                    ),
                                                  ),
                                                ]),
                                                SizedBox(
                                                  height: AppSize.s10,
                                                ),
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
                                                    IconsAssets.call2,
                                                    height: AppSize.s18,
                                                    width: AppSize.s18,
                                                  ),
                                                  SizedBox(
                                                    width: AppSize.s8,
                                                  ),
                                                  Text(
                                                    addresses[index].phone!,
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
                                                  BorderRadius.circular(
                                                      AppRadius.r8),
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
                                                      addresses[index]
                                                          .addressName!,
                                                      style: getSemiBoldStyle(
                                                        color: ColorManager
                                                            .primaryDark,
                                                        fontSize: FontSize.s16,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Visibility(
                                                      visible: false,
                                                      child: Icon(
                                                        Icons.check_circle,
                                                        color: Colors
                                                            .lightGreenAccent,
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
                                                    addresses[index].phone!,
                                                    style: getRegularStyle(
                                                      color: ColorManager.black,
                                                    ),
                                                  ),
                                                ]),
                                                SizedBox(
                                                  height: AppSize.s10,
                                                ),
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
                                                    IconsAssets.call,
                                                    height: AppSize.s18,
                                                    width: AppSize.s18,
                                                  ),
                                                  SizedBox(
                                                    width: AppSize.s8,
                                                  ),
                                                  Text(
                                                    addresses[index].phone!,
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

                  // SizedBox(
                  //   height: AppSize.s12,
                  // ),
                  // Container(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: AppPadding.p8),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(AppRadius.r8),
                  //     border: Border.all(
                  //         width: AppSize.s1, color: ColorManager.grey),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       SizedBox(
                  //         height: AppSize.s10,
                  //       ),
                  //       Row(children: [
                  //         Image.asset(
                  //           IconsAssets.motorcycleDelivery,
                  //           height: AppSize.s28,
                  //           width: AppSize.s28,
                  //         ),
                  //         SizedBox(
                  //           width: AppSize.s8,
                  //         ),
                  //         Text(
                  //           'It takes 11 minutes',
                  //           style: getRegularStyle(
                  //             color: ColorManager.black,
                  //           ),
                  //         ),
                  //       ]),
                  //       SizedBox(
                  //         height: AppSize.s10,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SfDateRangePicker(),
                  widget.order.availableDeliveryMethod[selectedTime]
                                  ['methodName'] ==
                              'Pick up' ||
                          widget.order.availableDeliveryMethod[selectedTime]
                                  ['methodName'] ==
                              'Car window'
                      ? Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xff125051),
                                ),
                              ),
                              child: Text(
                                date == null
                                    ? AppLocalizations.of(context)!.pick_date
                                    : date.toString().substring(0, 10),
                                style: getSemiBoldStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                // _registerViewGetXController.selectBirthDate(
                                //     context: context);
                                // selectBirthDate(context: context);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Container(
                                        // height: MediaQuery.of(context).size.height * 0.7,
                                        // width: MediaQuery.of(context).size.height * 0.7,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppPadding.p12),
                                        decoration: BoxDecoration(
                                          color: ColorManager.white,
                                          borderRadius: BorderRadius.circular(
                                              AppRadius.r8),
                                        ),
                                        // child: SizedBox(
                                        // height: MediaQuery.of(context).size.height * 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                child: CupertinoDatePicker(
                                                  mode: CupertinoDatePickerMode
                                                      .date,
                                                  initialDateTime:
                                                      DateTime(2023, 1, 1),
                                                  onDateTimeChanged:
                                                      (newDateTime) {
                                                    print(
                                                        '======================newDate');
                                                    print(newDateTime);
                                                    // Do something
                                                    setState(() {
                                                      if (newDateTime == null) {
                                                        date = null;
                                                      } else {
                                                        date = newDateTime;
                                                        dateTosend = newDateTime;
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.5,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.07,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppRadius.r8),
                                                  ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .yes,
                                                    textAlign: TextAlign.center,
                                                    style: getMediumStyle(
                                                        color:
                                                            ColorManager.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Column(
                                        //   children: [
                                        //     CupertinoDatePicker(
                                        //       mode: CupertinoDatePickerMode.date,
                                        //       initialDateTime: DateTime(2023, 1, 1),
                                        //       onDateTimeChanged:
                                        //           (DateTime newDateTime) {
                                        //         print('======================newDate');
                                        //         print(newDateTime);
                                        //         // Do something
                                        //         setState(() {
                                        //           if(newDateTime == null) {
                                        //             date = null;
                                        //           }else {
                                        //             date = newDateTime;
                                        //           }
                                        //         });
                                        //       },
                                        //     ),
                                        // GestureDetector(
                                        //   onTap: () => Navigator.pop(context),
                                        //   child: Container(
                                        //     width: AppSize.s110,
                                        //     height: AppSize.s38,
                                        //     alignment: Alignment.center,
                                        //     decoration: BoxDecoration(
                                        //       color: ColorManager.primaryDark,
                                        //       borderRadius:
                                        //       BorderRadius.circular(AppRadius.r8),
                                        //     ),
                                        //     child: Text(
                                        //       AppLocalizations.of(context)!.yes,
                                        //       textAlign: TextAlign.center,
                                        //       style:
                                        //       getMediumStyle(color: ColorManager.white),
                                        //     ),
                                        //   ),
                                        // ),
                                        //   ],
                                        // ) ,
                                        // ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: AppSize.s75,
                                width: AppSize.s75,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xff125051),
                                  ),
                                ),
                                child: Icon(
                                  Icons.date_range,
                                  // height: AppSize.s36,
                                  // width: AppSize.s36,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    child: Visibility(
                      visible: visibilityChecked,
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.pay_later,
                            style: getSemiBoldStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s16,
                            ),
                          ),
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
                                  setState(() {
                                    payLater = widget
                                        .order.orderDetails['canPayLaterValue'];
                                  });
                                } else {
                                  setState(() {
                                    payLater = widget.order
                                        .orderDetails['totalCostForItems'];
                                  });
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
                    height: AppSize.s12,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.use_reedem,
                          style: getSemiBoldStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s16,
                          ),
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
                  // CardField(
                  //   enablePostalCode: false,
                  //   onCardChanged: (card) {
                  //     setState(() {});
                  //   },
                  // ),
                  SizedBox(
                    height: AppSize.s44,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppMargin.m16,
                    ),
                    width: double.infinity,
                    height: AppSize.s55,
                    child: ElevatedButton(
                      onPressed: () {
                        print('================================orderID');
                        print(widget.order.orderDetails['id']);
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

                        if (_checkData(deleveryName)) {
                          Navigator.of(context)
                              .pushNamed(Routes.snapsheet, arguments: {
                            'branchAddress': widget.order.orderDetails['branch']
                                ['branchAddress'],
                            'deliveryPoint':
                                widget.order.orderDetails['deliveryPoint'],
                            'statusName':
                                widget.order.orderDetails['statusName'],
                            'orderId': widget.order.orderDetails['id'],
                            'item': widget.order.orderDetails['items'][0]['id'],
                            'deliveryMethodId': deleveryMethod ?? pickUPID,
                            'date': Helpers.formatDate(dateTosend).toString() ?? '',
                            'address': myAddress ?? '',
                            'reedem': isSwitched,
                            'paylater': isSwitchedPayLater
                          });
                        }
                        if (_checkData(deleveryName) == false) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)!.enter_required_data),
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
                        '${AppLocalizations.of(context)!.pay} ${payLater.toString()} ${AppLocalizations.of(context)!.aed} ',
                        style: getSemiBoldStyle(
                            color: ColorManager.white, fontSize: FontSize.s18),
                      ),
                    ),
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

// void _dateDialog(BuildContext context) async {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return Dialog(
//         child:SizedBox(
//           height: 200,
//           child: CupertinoDatePicker(
//             mode: CupertinoDatePickerMode.date,
//             initialDateTime: DateTime(1969, 1, 1),
//             onDateTimeChanged: (DateTime newDateTime) {
//               // Do something
//               setState(() {
//                 date = newDateTime;
//               });
//             },
//           ),
//         ),
//       );
//     },
//   );
// }
