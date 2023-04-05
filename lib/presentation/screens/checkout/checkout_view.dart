import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/presentation/screens/addresses_view/addresses_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/checkout/payment_method_redeem_point_screen.dart';
import 'package:ghaf_application/presentation/screens/main_view.dart';
import 'package:ghaf_application/presentation/screens/register_view/register_view_getx_controller.dart';
import 'package:ghaf_application/services/payment_service.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class CheckOutView extends StatefulWidget {
  String? cardNumber;
  String? paymentMethodId;

  CheckOutView({this.cardNumber, this.paymentMethodId});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> with Helpers {
  late TextEditingController _paymentMethodTextController;

  //controller
  late final RegisterViewGetXController _registerViewGetXController =
  Get.find<RegisterViewGetXController>();
  late final CheckOutGetxController _checkOutGetxController =
  Get.put(CheckOutGetxController());
  late final AddressesViewGetXController _addressesViewGetXController =
  Get.put(AddressesViewGetXController(context: context));

  final TextEditingController _enterPromoCode = TextEditingController();
  final TextEditingController _sendNote = TextEditingController();

  var visibility = false;
  var isSwitchedPayLater = false;
  var isSwitched = false;
  var isUseWallet = false;
  var visibilityChecked = false;
  late var paymentIntent;
  DateTime? date;
  var myAddress;
  var isAddressSelected = false;
  var deleveryMethod;
  var deleveryName;
  var selectedAddress;
  var isLoading = true;
  var isSelectedDelivery = true;

  var dateTosend = DateTime.now();

  var selected;
  int selectedTime = 0;
  var pickUPID = '4f0db097-378f-4efa-bc17-08daf719ffd5';

  final paymentController = Get.put(PaymentController());

  bool _checkData() {
    if (selected != null &&
        widget.cardNumber != null &&
        widget.paymentMethodId != null) {
      return true;
    }
    return false;
  }

  //
  @override
  void initState() {
    _checkOutGetxController.getOrderToPay(context: context);
    _addressesViewGetXController.getMyAddresses(notifyLoading: true);
    //
    super.initState();
    _paymentMethodTextController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showFeesExplainSheet(context);
    });

  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _paymentMethodTextController.dispose();
    super.dispose();
  }

  var deliveryFees = 0;
  var result;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainView(),));
        return false;
      },
      child: Scaffold(
        body: GetBuilder<CheckOutGetxController>(
          id: "orderToPay",
          builder: (controller) =>
          controller.isLoadingOrderToPay
              ? Center(
            child: Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          )
              : SafeArea(
            // key: _scaffoldKey,
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
                            onTap: () {
                              _checkOutGetxController.deleteUnpaidOrder(
                                  context: context,
                                  orderId: _checkOutGetxController
                                      .orderToPay[_checkOutGetxController
                                      .orderToPay.length -
                                      1]
                                      .orderDetails!
                                      .id!);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainView(),
                                  ));
                            },
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
                            itemCount: _checkOutGetxController
                                .orderToPay[_checkOutGetxController
                                .orderToPay.length -
                                1]
                                .availableDeliveryMethod!
                                .length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected = index;
                                    selectedTime = index;
                                    if (_checkOutGetxController
                                        .orderToPay[
                                    _checkOutGetxController
                                        .orderToPay.length -
                                        1]
                                        .availableDeliveryMethod?[
                                    selected]
                                        .methodName ==
                                        'Pick up') {
                                      isSelectedDelivery = false;
                                    } else {
                                      isSelectedDelivery = true;
                                    }
                                    deliveryFees = (_checkOutGetxController
                                        .orderToPay[
                                    _checkOutGetxController
                                        .orderToPay.length -
                                        1]
                                        .availableDeliveryMethod![
                                    selected]
                                        .cost!)
                                        .toInt();
                                  });
                                  final snackBar = SnackBar(

                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Great!',

                                      message:
                                      '${AppLocalizations.of(context)!
                                          .you_choose} !',

                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                      contentType: ContentType.success,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                  setState(() {});
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
                                        padding: EdgeInsets.all(
                                            AppPadding.p12),
                                        decoration: BoxDecoration(
                                          color: ColorManager.primary,
                                          border: Border.all(
                                              width: AppSize.s1,
                                              color: ColorManager
                                                  .greyLight),
                                          borderRadius:
                                          BorderRadius.circular(
                                              AppRadius.r4),
                                        ),
                                        child: Image.network(
                                          _checkOutGetxController
                                              .orderToPay[
                                          _checkOutGetxController
                                              .orderToPay
                                              .length -
                                              1]
                                              .availableDeliveryMethod![
                                          index]
                                              .methodImage!,
                                          color: ColorManager.white,
                                        ),
                                      )
                                          : Container(
                                        height: AppSize.s75,
                                        width: AppSize.s75,
                                        padding: EdgeInsets.all(
                                            AppPadding.p12),
                                        decoration: BoxDecoration(
                                          color: ColorManager.white,
                                          border: Border.all(
                                              width: AppSize.s1,
                                              color: ColorManager
                                                  .greyLight),
                                          borderRadius:
                                          BorderRadius.circular(
                                              AppRadius.r4),
                                        ),
                                        child: Image.network(
                                          _checkOutGetxController
                                              .orderToPay[
                                          _checkOutGetxController
                                              .orderToPay
                                              .length -
                                              1]
                                              .availableDeliveryMethod![
                                          index]
                                              .methodImage!,
                                          color: ColorManager
                                              .primaryDark,
                                        ),
                                      ),
                                      SizedBox(
                                        height: AppSize.s7,
                                      ),
                                      Text(
                                        _checkOutGetxController
                                            .orderToPay[
                                        _checkOutGetxController
                                            .orderToPay.length -
                                            1]
                                            .availableDeliveryMethod![index]
                                            .methodName!,
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
                            border:
                            Border.all(color: ColorManager.greyLight)),
                        child: Row(
                          children: [
                            Icon(Icons.delivery_dining),
                            SizedBox(
                              width: AppSize.s20,
                            ),
                            GetBuilder<CheckOutGetxController>(
                              builder: (controller) =>
                                  Text(
                                      'It takes ${controller.duration}',
                                      style: TextStyle(
                                          color: ColorManager.primary,
                                          fontWeight: FontWeight.w500)),
                            ),
                            // SizedBox(width: AppSize.s20,),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                if (selected == null) {
                                  showSnackBar(context,
                                      message:
                                      'please select delivery method first.',
                                      error: true);
                                } else {
                                  if (_checkOutGetxController
                                      .orderToPay[
                                  _checkOutGetxController
                                      .orderToPay.length -
                                      1]
                                      .availableDeliveryMethod![
                                  selected]
                                      .methodName! ==
                                      'Pick up') {
                                    result = await showArrivalTimeTodaySheet(
                                        context: context,
                                        text:
                                        '${AppLocalizations.of(context)!
                                            .arrival_time}');
                                  } else if (_checkOutGetxController
                                      .orderToPay[
                                  _checkOutGetxController
                                      .orderToPay.length -
                                      1]
                                      .availableDeliveryMethod![
                                  selected]
                                      .methodName! ==
                                      'Delivery') {
                                    result = await showArrivalTimeAsapSheet(
                                        context: context,
                                        text: AppLocalizations.of(context)!
                                            .delivery_time);
                                  }
                                }
                                // showArrivalTimeTodaySheet(context: context);
                                // showArrivalTimeAsapSheet(context: context);
                              },
                              child: Text(
                                'change',
                                style:
                                TextStyle(fontWeight: FontWeight.w500),
                              ),
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
                            border:
                            Border.all(color: ColorManager.greyLight)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: AppSize.s20,
                            ),
                            widget.cardNumber == null
                                ? Text(
                                AppLocalizations.of(context)!
                                    .select_the_payment_method,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13))
                                : Row(
                              children: [
                                Icon(Icons.credit_card,
                                    color: ColorManager.primary),
                                SizedBox(
                                  width: AppSize.s24,
                                ),
                                Text(
                                    '**** **** **** ${widget.cardNumber}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13))
                              ],
                            ),
                            // SizedBox(width: AppSize.s20,),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
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
                        height: AppSize.s12,
                      ),
                      Container(
                        child: Visibility(
                          visible: true,
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.use_wallet,
                                style: getSemiBoldStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                              // GestureDetector(
                              //     onTap: () {
                              //       _infoDialog(
                              //           context,
                              //           AppLocalizations.of(context)!
                              //               .pay_later_text);
                              //     },
                              //     child: Icon(Icons.info_outline,
                              //         color: ColorManager.greyLight)),
                              Spacer(),
                              CupertinoSwitch(
                                value: isUseWallet,
                                onChanged: (_) {
                                  setState(() {
                                    if (isUseWallet == false) {
                                      isUseWallet = true;
                                    } else {
                                      isUseWallet = false;
                                    }
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
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: _checkOutGetxController
                                  .orderToPay[_checkOutGetxController
                                  .orderToPay.length -
                                  1]
                                  .orderDetails!
                                  .items!
                                  .length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Text(
                                      '${_checkOutGetxController
                                          .orderToPay[_checkOutGetxController
                                          .orderToPay.length - 1].orderDetails!
                                          .items![index]
                                          .quanity} x ${_checkOutGetxController
                                          .orderToPay[_checkOutGetxController
                                          .orderToPay.length - 1].orderDetails!
                                          .items![index].name}',
                                      style: getSemiBoldStyle(
                                        color: ColorManager.grey,
                                        fontSize: FontSize.s16,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${((_checkOutGetxController
                                          .orderToPay[_checkOutGetxController
                                          .orderToPay.length - 1].orderDetails!
                                          .items![index].price!) *
                                          (_checkOutGetxController
                                              .orderToPay[_checkOutGetxController
                                              .orderToPay.length - 1]
                                              .orderDetails!.items![index]
                                              .quanity!))} ${AppLocalizations
                                          .of(
                                          context)!.aed}',
                                      style: getSemiBoldStyle(
                                        color: ColorManager.grey,
                                        fontSize: FontSize.s16,
                                      ),
                                    ),
                                  ],
                                );
                              },
                              //count of items
                            ),
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
                                  '${_checkOutGetxController
                                      .orderToPay[_checkOutGetxController
                                      .orderToPay.length - 1].orderDetails!
                                      .totalCostForItems!} ${AppLocalizations
                                      .of(
                                      context)!.aed}',
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
                                  '${_checkOutGetxController
                                      .orderToPay[_checkOutGetxController
                                      .orderToPay.length - 1].orderDetails
                                      ?.totalCostForItems} ${AppLocalizations
                                      .of(
                                      context)!.aed}',
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
                                    '${(_checkOutGetxController
                                        .orderToPay[_checkOutGetxController
                                        .orderToPay.length - 1].orderDetails!
                                        .totalCostForItems!) -
                                        (_checkOutGetxController
                                            .orderToPay[_checkOutGetxController
                                            .orderToPay.length - 1]
                                            .orderDetails!
                                            .orderCostForCustomer!)} ${AppLocalizations
                                        .of(context)!.aed}',
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
                                  AppLocalizations.of(context)!
                                      .delivery_fee,
                                  style: getSemiBoldStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${deliveryFees} ${AppLocalizations.of(
                                      context)!
                                      .aed}',
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
                                  AppLocalizations.of(context)!
                                      .redeem_point,
                                  style: getSemiBoldStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${_checkOutGetxController
                                      .orderToPay[_checkOutGetxController
                                      .orderToPay.length - 1].orderDetails!
                                      .redeemPointsFactor!} ${AppLocalizations
                                      .of(
                                      context)!.point}',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                                thickness: 1,
                                color: ColorManager.greyLight),
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
                                  '${(_checkOutGetxController
                                      .orderToPay[_checkOutGetxController
                                      .orderToPay.length - 1].orderDetails!
                                      .orderCostForCustomer!) +
                                      (deliveryFees)} ${AppLocalizations.of(
                                      context)!.aed}',
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
                        child: Row(
                          children: [
                            Container(
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.6,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.06,
                                child: TextField(
                                    controller: _enterPromoCode,
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
                      Visibility(
                        visible: isSelectedDelivery,
                        child: Row(children: [
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
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount:
                        _addressesViewGetXController.addresses.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedAddress = index;
                                _checkOutGetxController.getDurationGoogleMap(
                                    LatOne: SharedPrefController().locationLat,
                                    LonOne: SharedPrefController().locationLong,
                                    LatTow: double.parse(
                                        _addressesViewGetXController
                                            .addresses[selectedAddress]!
                                            .altitude!),
                                    LonTow: double.parse(
                                        _addressesViewGetXController
                                            .addresses[selectedAddress]!
                                            .longitude!));
                              });
                              print('====================address checkout');

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
                              visible: isSelectedDelivery,
                              child: Column(
                                children: [
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
                                              _addressesViewGetXController
                                                  .addresses[index]
                                                  .addressName!,
                                              style: getSemiBoldStyle(
                                                color: ColorManager
                                                    .primaryDark,
                                                fontSize:
                                                FontSize.s16,
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
                                            _addressesViewGetXController
                                                .addresses[index]
                                                .cityName!,
                                            style: getRegularStyle(
                                              color:
                                              ColorManager.black,
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
                                            color: ColorManager
                                                .primaryDark,
                                          ),
                                          SizedBox(
                                            width: AppSize.s8,
                                          ),
                                          Text(
                                            '${AppSharedData.currentUser
                                                ?.firstName}',
                                            style: getRegularStyle(
                                              color:
                                              ColorManager.black,
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
                                            _addressesViewGetXController
                                                .addresses[index]
                                                .phone!,
                                            style: getRegularStyle(
                                              color:
                                              ColorManager.black,
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
                                              _addressesViewGetXController
                                                  .addresses[index]
                                                  .addressName!,
                                              style: getSemiBoldStyle(
                                                color: ColorManager
                                                    .primaryDark,
                                                fontSize:
                                                FontSize.s16,
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
                                            ),
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
                                            _addressesViewGetXController
                                                .addresses[index]
                                                .cityName!,
                                            style: getRegularStyle(
                                              color:
                                              ColorManager.black,
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
                                            '${AppSharedData.currentUser
                                                ?.firstName}',
                                            style: getRegularStyle(
                                              color:
                                              ColorManager.black,
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
                                            _addressesViewGetXController
                                                .addresses[index]
                                                .phone!,
                                            style: getRegularStyle(
                                              color:
                                              ColorManager.black,
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: AppSize.s22,
                                        ),
                                      ],
                                    ),
                                  ),
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
                                _infoDialog(
                                    context,
                                    AppLocalizations.of(context)!
                                        .order_note_info);
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
                            border:
                            Border.all(color: ColorManager.greyLight)),
                        child: TextField(
                            controller: _sendNote,
                            decoration: InputDecoration(
                              label: Text(
                                AppLocalizations.of(context)!.send_note,
                              ),
                            ),
                            maxLines: 3),
                      ),
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
                                print('====================result');
                                print(result);
                                if (_checkData()) {
                                  _checkOutGetxController.payForOrder(
                                    context: context,
                                    orderId: _checkOutGetxController
                                        .orderToPay[_checkOutGetxController
                                        .orderToPay.length -
                                        1]
                                        .orderDetails!
                                        .id!,
                                    deliveryMethodId:
                                    _checkOutGetxController
                                        .orderToPay[
                                    _checkOutGetxController
                                        .orderToPay.length -
                                        1]
                                        .availableDeliveryMethod![
                                    selected]
                                        .id!,
                                    deliveryPoint: selectedAddress == null
                                        ? null
                                        : _addressesViewGetXController
                                        .addresses[selectedAddress],
                                    PaymentMethodId:
                                    widget.paymentMethodId!,
                                    useRedeemPoints: isSwitched,
                                    useWallet: isUseWallet,
                                    usePayLater: isSwitchedPayLater,
                                    // desiredDeliveryDate: desiredDeliveryDate,
                                    asap: result == null
                                        ? true
                                        : result['asap'],
                                    SheduleInfo: result == null
                                        ? null
                                        : result['asap']
                                        ? null
                                        : {
                                      'WeeklyOrMonthly':
                                      result['WeeklyOrMonthly'],
                                      'DayNumber':
                                      result['DayNumber'],
                                      'HourNumber':
                                      result['HourNumber'],
                                      'MinuteNumber': 0,
                                    },
                                    OrderNotes: _sendNote.text,
                                    PromoCode: _enterPromoCode.text == ''
                                        ? null
                                        : _enterPromoCode.text,
                                  );
                                }

                                // if (_checkData()) {
                                //   showArrivalTimeSheet(
                                //     context: context,
                                //     orderId: _checkOutGetxController
                                //         .orderToPay[_checkOutGetxController
                                //                 .orderToPay.length -
                                //             1]
                                //         .orderDetails!
                                //         .id!,
                                //     deliveryPoint:
                                //         _addressesViewGetXController
                                //             .addresses[selectedAddress],
                                //     usePayLater: isSwitchedPayLater,
                                //     useRedeemPoints: isSwitched,
                                //     useWallet: isUseWallet,
                                //     PromoCode: _enterPromoCode.text == ''
                                //         ? null
                                //         : _enterPromoCode.text,
                                //     OrderNotes: _sendNote.text,
                                //     deliveryMethodId:
                                //         _checkOutGetxController
                                //             .orderToPay[
                                //                 _checkOutGetxController
                                //                         .orderToPay.length -
                                //                     1]
                                //             .availableDeliveryMethod![
                                //                 selected]
                                //             .id!,
                                //     PaymentMethodId:
                                //         widget.paymentMethodId!,
                                //   );
                                // }
                                if (_checkData() == false) {
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(SnackBar(
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .enter_required_data),
                                      backgroundColor: Colors.red,
                                    ));
                                }
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
                                    MaterialStatePropertyAll(
                                        Colors.white),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            side: BorderSide(
                                                color: ColorManager
                                                    .primaryDark)))),
                                onPressed: () {

                                },
                                child: Text(
                                  AppLocalizations.of(context)!.add_item,
                                  style: TextStyle(
                                      color: ColorManager.primaryDark),
                                )),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: AppSize.s24,
                      ),
                    ],
                  ),
                ),
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
      initialDate: DateTime(DateTime
          .now()
          .year - 15),
      firstDate: DateTime(DateTime
          .now()
          .year - 50),
      lastDate: DateTime(DateTime
          .now()
          .year - 15),
    );
    if (date == null) return;
    // birthDate = Helpers.formatDate(date);
    // birthDateTextEditingController.text = birthDate!;
  }
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
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.14,
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
