import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/domain/model/meal_times.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/categories_view/categories_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/categories_view/pre_order_products_screen.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/home_view/home_view_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/login_view/login_view.dart';
import 'package:ghaf_application/presentation/screens/register_view/register_view.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/payment_view_for_subscribe_new.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/subscribe_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/dialogs/loading_dialog_widget.dart';
import 'package:intl/intl.dart';
import 'package:redirect_icon/redirect_icon.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:social_media_flutter/widgets/icons.dart';

import '../../domain/model/address.dart';
import '../../domain/model/payment_mathod.dart';
import '../../domain/model/subscription_plan.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/styles_manager.dart';
import '../../presentation/screens/checkout/cancelling_order_screen.dart';
import '../../presentation/screens/terms_use_view.dart';

mixin Helpers {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.find<CheckOutGetxController>();

  String dropdownValue = 'Sunday';
  String dropdownValue1 = '0';
  var numberOfDay = 0;

  var isAsap = true;
  var isSelectedToday = false;
  var isSelectedAsap = true;
  var isOneTime = false;
  var isWeekly = false;
  var isMonthly = false;
  var frequency = 0;
  var selected;

  List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  List<String> hours = ['Time'];

  void showSnackBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  // show loading dialog.
  void showLoadingDialog({
    required BuildContext context,
    String? title,
  }) {
    showDialog(
      context: context,
      builder: (_) => LoadingDialogWidget(
        title: title,
      ),
      barrierDismissible: false,
    );
  }

  // format date.
  static String formatDate(DateTime dateTime, {bool withTime = false}) {
    if (withTime) {
      return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
    } else {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }

  Future showSheetGetHelpConfirm(BuildContext context) =>
      showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.4, 0.7],
          ),
          builder: (context, state) => Material(
            child: Padding(
              padding: EdgeInsets.all(AppSize.s15),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        AppLocalizations.of(context)!
                            .your_request_will_be_handled_by_the_relevant_team_Thank_you,
                        style: TextStyle(
                            fontSize: FontSize.s16,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.grey)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //   builder: (context) => RegisterScreen(),
                          // ));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(ColorManager.primary),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    side:
                                        BorderSide(color: ColorManager.primary),
                                    borderRadius: BorderRadius.circular(AppSize.s10)))),
                        child: Text(
                          AppLocalizations.of(context)!.ok,
                          // 'Login',
                          style: getSemiBoldStyle(
                              color: ColorManager.white, fontSize: FontSize.s18),
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

  Future showSheet(BuildContext context) => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.4, 0.7],
          ),
          builder: (context, state) => Material(
            child: Padding(
              padding: EdgeInsets.all(AppSize.s15),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Text(AppLocalizations.of(context)!.canceling_order,
                        style: TextStyle(
                            fontSize: FontSize.s25,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.primaryDark)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Text(AppLocalizations.of(context)!.are_you_sure_cancel,
                        style: TextStyle(
                            fontSize: FontSize.s15,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.primary)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CancellingOrderScreen(),
                              ));
                              // Navigator.of(context).pushReplacement(MaterialPageRoute(
                              //   builder: (context) => LoginScreen(),
                              // ));
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    ColorManager.primaryDark),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s10)))),
                            child: Text(
                              AppLocalizations.of(context)!.yes,
                              // 'Login',
                              style: getSemiBoldStyle(
                                  color: ColorManager.white, fontSize: FontSize.s18),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).pushReplacement(MaterialPageRoute(
                              //   builder: (context) => RegisterScreen(),
                              // ));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: ColorManager.primaryDark),
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s10)))),
                            child: Text(
                              AppLocalizations.of(context)!.no,
                              // 'Login',
                              style: getSemiBoldStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s18),
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s150,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Future showSubscribeSheet(
      {required BuildContext context,
      required List<SubscriptionPlan> subscriptionPlan,
      String? last4DigitNumber,
      required PaymentMethod paymentMethod,
      required List<PaymentMethod> paymentMethodId}) {
    IconData icon = Icons.radio_button_off;
    IconData icon1 = Icons.radio_button_off;
    num priceAmount = 0;
    num freeDays = 0;
    String planId = '';
    String paymentId = '';
    return showSlidingBottomSheet(
      context,
      builder: (context) => SlidingSheetDialog(
        snapSpec: SnapSpec(
          snappings: [0.6, 0.7],
        ),
        builder: (context, state) => Material(
          child: StatefulBuilder(
            builder: (context, setState) => Padding(
              padding: EdgeInsets.all(AppSize.s15),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Text(AppLocalizations.of(context)!.choose_plan,
                        style: TextStyle(
                            fontSize: FontSize.s24,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.black)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s15),
                          color: ColorManager.greyLight),
                      padding: EdgeInsets.all(AppSize.s14),
                      child: Row(children: [
                        Icon(
                          Icons.wallet_giftcard,
                          color: ColorManager.primaryDark,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.012,
                        ),
                        Text(
                          '${subscriptionPlan[0].freeDays} ${AppLocalizations.of(context)!.two_weeks_free_trail}',
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s14),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.012,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          paymentId = paymentMethodId[0].id!;
                          planId = subscriptionPlan[0].id!;
                          freeDays = subscriptionPlan[0].freeDays!;
                          priceAmount = subscriptionPlan[0].priceAmount!;
                          if (icon1 == Icons.radio_button_off) {
                            icon1 = Icons.radio_button_on_outlined;
                            icon = Icons.radio_button_off;
                          } else {
                            icon1 = Icons.radio_button_off;
                            icon = Icons.radio_button_on_outlined;
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s15),
                          border: Border.all(color: ColorManager.greyLight),
                        ),
                        padding: EdgeInsets.all(AppSize.s12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.monthly_plan1,
                                style: TextStyle(color: ColorManager.grey)),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.aed} ${subscriptionPlan[0].priceAmount}/month',
                                  style: TextStyle(
                                      color: ColorManager.primaryDark,
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSize.s18),
                                ),
                                Spacer(),
                                Icon(
                                  icon1,
                                  color: ColorManager.primary,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                            Text(
                                AppLocalizations.of(context)!
                                    .billed_every_month,
                                style: TextStyle(color: ColorManager.grey)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.012,
                    ),
                    subscriptionPlan.length < 2
                        ? Container()
                        : InkWell(
                            onTap: () {
                              setState(() {
                                paymentId = paymentMethodId[1].id!;
                                planId = subscriptionPlan[1].id!;
                                freeDays = subscriptionPlan[1].freeDays!;
                                priceAmount = subscriptionPlan[1].priceAmount!;
                                if (icon == Icons.radio_button_off) {
                                  icon = Icons.radio_button_on_outlined;
                                  icon1 = Icons.radio_button_off;
                                } else {
                                  icon = Icons.radio_button_off;
                                  icon1 = Icons.radio_button_on_outlined;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSize.s15),
                                border:
                                    Border.all(color: ColorManager.greyLight),
                              ),
                              padding: EdgeInsets.all(AppSize.s12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      AppLocalizations.of(context)!.yearly_plan,
                                      style:
                                          TextStyle(color: ColorManager.grey)),
                                  SizedBox(
                                    height: AppSize.s10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.aed} ${subscriptionPlan[1].priceAmount}/month',
                                        style: TextStyle(
                                            color: ColorManager.primaryDark,
                                            fontWeight: FontWeight.bold,
                                            fontSize: FontSize.s18),
                                      ),
                                      Spacer(),
                                      Icon(
                                        icon,
                                        color: ColorManager.primary,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppSize.s10,
                                  ),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .billed_every_year,
                                      style:
                                          TextStyle(color: ColorManager.grey)),
                                ],
                              ),
                            ),
                          ),
                    Container(
                      height: AppSize.s82,
                      width: double.infinity,
                      padding: EdgeInsets.all(AppSize.s12),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showAddPaymentDetailsForSubscribeSheet(
                                context: context,
                                priceAmount: priceAmount,
                                freeDays: freeDays,
                                paymentMethod: paymentMethod,
                                last4DigitNumber: last4DigitNumber,
                                planId: planId,
                                paymentMethodId: paymentId);
                          },
                          child: Text(AppLocalizations.of(context)!.continue1)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future showAddPaymentDetailsForSubscribeSheet(
      {required BuildContext context,
      required num priceAmount,
      required num freeDays,
      String? last4DigitNumber,
      required PaymentMethod paymentMethod,
      required String planId,
      required String paymentMethodId}) {
    late final SubscribeViewGetXController _subscribeViewGetXController =
        Get.put<SubscribeViewGetXController>(
            SubscribeViewGetXController(context: context));
    return showSlidingBottomSheet(
      context,
      builder: (context) => SlidingSheetDialog(
        snapSpec: SnapSpec(
          snappings: [0.6, 0.7],
        ),
        builder: (context, state) => Material(
          child: StatefulBuilder(
            builder: (context, setState) => Padding(
              padding: EdgeInsets.all(AppSize.s15),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Row(
                      children: [
                        Text(AppLocalizations.of(context)!.add_payment_details,
                            style: TextStyle(
                                fontSize: FontSize.s24,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.black)),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.wallet_giftcard,
                          color: ColorManager.primaryDark,
                        ),
                        Text(
                          '${freeDays} ${AppLocalizations.of(context)!.two_weeks_free_trail}',
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s14),
                        ),
                        Text(
                          '${AppLocalizations.of(context)!.cancel_anytime_before_your_trial_ends}',
                          style: TextStyle(
                              color: ColorManager.greyLight,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppSize.s12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          border: Border.all(color: ColorManager.greyLight)),
                      child: Row(
                        children: [
                          Image.network(
                            paymentMethod.image!,
                            height: AppSize.s15,
                          ),
                          SizedBox(
                            width: AppSize.s10,
                          ),
                          last4DigitNumber == null
                              ? Text(
                                  "**** **** **** ${paymentMethod.last4Digits} ",
                                  style: TextStyle(
                                      color: ColorManager.primaryDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize.s12),
                                )
                              : Text(
                                  "**** **** **** ${last4DigitNumber} ",
                                  style: TextStyle(
                                      color: ColorManager.primaryDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize.s12),
                                ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    PaymentViewForSubscribeNew(),
                              ));
                            },
                            child: Text(AppLocalizations.of(context)!.change,
                                style: TextStyle(color: ColorManager.primary)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.019,
                    ),
                    Divider(color: ColorManager.greyLight, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.aed} $priceAmount/month ⚫ ',
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TermsOfUseView(),
                            ));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.terms_apply1,
                            style: TextStyle(
                                color: ColorManager.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.s14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.012,
                    ),
                    Container(
                      height: AppSize.s82,
                      width: double.infinity,
                      padding: EdgeInsets.all(AppSize.s12),
                      child: ElevatedButton(
                          onPressed: () {
                            _subscribeViewGetXController.subscribeAsGhafGolden(
                                context: context,
                                paymentMethodId: paymentMethodId,
                                planId: planId);
                          },
                          child: Text(AppLocalizations.of(context)!.join_ghaf)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future showSortBySheet(
          {required BuildContext context,
          required CategoriesGetxController categoriesGetxController,
          required String cid}) =>
      showSlidingBottomSheet(context,
          // var List<String> sortedType = [AppLocalizations.of(context)!.recommended]
          builder: (context) {
        List<String> sortedType = [
          AppLocalizations.of(context)!.recommended,
          AppLocalizations.of(context)!.rating
        ];
        return SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.5, 0.7],
          ),
          builder: (context, state) => StatefulBuilder(
            builder: (context, setState) => Material(
              child: Padding(
                padding: EdgeInsets.all(AppSize.s15),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.024,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              ImageAssets.x,
                              height: AppSize.s18,
                              width: AppSize.s18,
                              color: ColorManager.greyLight,
                            ),
                          ),
                          SizedBox(
                            width: AppSize.s10,
                          ),
                          Text(AppLocalizations.of(context)!.sort_by,
                              style: TextStyle(
                                  fontSize: FontSize.s24,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.black)),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.024,
                      ),
                      Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: sortedType.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected = index;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(sortedType[index],
                                            style: TextStyle(
                                                color: ColorManager.primaryDark,
                                                fontWeight: FontWeight.w600,
                                                fontSize: FontSize.s18)),
                                        // SizedBox(width: AppSize.s30,),
                                        Spacer(),
                                        selected == null
                                            ? Image.asset(
                                                ImageAssets.unChecked,
                                                height: AppSize.s20,
                                                width: AppSize.s20,
                                              )
                                            : selected == index
                                                ? Image.asset(
                                                    ImageAssets.checked,
                                                    height: AppSize.s20,
                                                    width: AppSize.s20,
                                                  )
                                                : Image.asset(
                                                    ImageAssets.unChecked,
                                                    height: AppSize.s20,
                                                    width: AppSize.s20,
                                                  )
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.024,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Container(
                            height: AppSize.s82,
                            width: double.infinity,
                            padding: EdgeInsets.all(AppSize.s12),
                            child: ElevatedButton(
                                onPressed: () {
                                  categoriesGetxController.getBranches(
                                      cid: cid,
                                      sortType: sortedType[selected] ==
                                              AppLocalizations.of(context)!
                                                  .recommended
                                          ? 'storeSales'
                                          : 'storeStars');
                                  Navigator.of(context).pop();
                                },
                                child:
                                    Text(AppLocalizations.of(context)!.apply)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.024,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });

  Future showArrivalTimeAsapSheet({
    required List<String> mealTimes,
    required BuildContext context,
    required String text,
  }) =>
      showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.5, 0.7],
          ),
          builder: (context, state) => Material(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: EdgeInsets.all(AppSize.s15),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Text('$text',
                            style: TextStyle(
                                fontSize: FontSize.s20,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.primaryDark)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                print('=======================asap');
                                print(isAsap);
                                setState(() {
                                  if (isSelectedToday == true) {
                                    isSelectedAsap = true;
                                    isSelectedToday = false;
                                    isAsap = true;
                                  }
                                  if (isSelectedToday == false) {
                                    isAsap = false;
                                    isSelectedAsap = false;
                                    isSelectedToday = true;
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: ColorManager.primary,
                                  ),
                                  SizedBox(
                                    width: AppSize.s10,
                                  ),
                                  Text(AppLocalizations.of(context)!.asap,
                                      style: TextStyle(
                                          color: ColorManager.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.s18)),
                                  // SizedBox(width: AppSize.s30,),
                                  Spacer(),
                                  isSelectedToday
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: ColorManager.primary,
                                        )
                                      : Icon(
                                          Icons.radio_button_off,
                                          color: ColorManager.primary,
                                        )
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                            InkWell(
                              onTap: () {
                                print('=======================asap');
                                print(isAsap);
                                setState(() {
                                  if (isSelectedAsap == true) {
                                    isSelectedAsap = false;
                                    isSelectedToday = true;
                                    isAsap = false;
                                  }
                                  if (isSelectedAsap == false) {
                                    isAsap = true;
                                    isSelectedAsap = true;
                                    isSelectedToday = false;
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImageAssets.tomorrowTimer,
                                    height: AppSize.s20,
                                    width: AppSize.s20,
                                  ),
                                  SizedBox(
                                    width: AppSize.s10,
                                  ),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .schedule_for_later,
                                      style: TextStyle(
                                          color: ColorManager.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.s18)),
                                  // SizedBox(width: AppSize.s30,),
                                  Spacer(),
                                  isSelectedAsap
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: ColorManager.primary,
                                        )
                                      : Icon(
                                          Icons.radio_button_off,
                                          color: ColorManager.primary,
                                        )
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                            Visibility(
                              visible: isSelectedAsap,
                              child: Row(
                                children: [
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppSize.s10),
                                        border: Border.all(
                                            color: ColorManager.greyLight)),
                                    padding:EdgeInsets.all(AppSize.s5),
                                    child: DropdownButton<String>(
                                      // Step 3.
                                      value: dropdownValue,
                                      // Step 4.

                                      items: days.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: ColorManager.primaryDark,
                                                fontWeight: FontWeight.w600,
                                                fontSize: AppSize.s12),
                                          ),
                                        );
                                      }).toList(),
                                      // Step 5.
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                          print(
                                              '=====================number of days');
                                          print(days.indexOf(newValue));
                                          numberOfDay = days.indexOf(newValue);
                                        });
                                      },
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppSize.s10),
                                        border: Border.all(
                                            color: ColorManager.greyLight)),
                                    padding:EdgeInsets.all(AppSize.s5),
                                    child: DropdownButton<String>(
                                      // Step 3.
                                      value: dropdownValue1,
                                      // Step 4.
                                      items: mealTimes.toSet().toList()
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: ColorManager.primaryDark,
                                                fontWeight: FontWeight.w600,
                                                fontSize: AppSize.s12),
                                          ),
                                        );
                                      }).toList(),
                                      // Step 5.
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          print(
                                              '=========================hours');
                                          print(dropdownValue1);
                                          dropdownValue1 = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                            Container(
                              height: AppSize.s82,
                              width: double.infinity,
                              padding: EdgeInsets.all(AppSize.s12),
                              child: ElevatedButton(
                                  onPressed: () {
                                    print('=============result');
                                    print(frequency);
                                    print(numberOfDay);
                                    print(dropdownValue1);
                                    print(isAsap);
                                    Navigator.of(context).pop({
                                      'WeeklyOrMonthly': frequency,
                                      'DayNumber': numberOfDay,
                                      'HourNumber': int.parse(dropdownValue1),
                                      'MinuteNumber': 0,
                                      'asap': !isAsap,
                                    });
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.confirm)),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

  Future showArrivalTimeTodaySheet({
    required List<String> mealTimes,
    required BuildContext context,
    required String text,
  }) =>
      showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.5, 0.7],
          ),
          builder: (context, state) {
            return Material(
              child: StatefulBuilder(
                builder: (context, setState) {

                  print('====================hours1');
                  print(hours);
                  return Padding(
                    padding: EdgeInsets.all(AppSize.s15),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.024,
                          ),
                          Text('$text',
                              style: TextStyle(
                                  fontSize: FontSize.s20,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.primaryDark)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.024,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isSelectedToday == true) {
                                      isSelectedAsap = true;
                                      isSelectedToday = false;
                                      isAsap = true;
                                    }
                                    if (isSelectedToday == false) {
                                      isAsap = false;
                                      isSelectedAsap = false;
                                      isSelectedToday = true;
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: ColorManager.primary,
                                    ),
                                    SizedBox(
                                      width: AppSize.s10,
                                    ),
                                    Text(AppLocalizations.of(context)!.today,
                                        style: TextStyle(
                                            color: ColorManager.grey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize.s18)),
                                    // SizedBox(width: AppSize.s30,),
                                    Spacer(),
                                    isSelectedToday
                                        ? Icon(
                                      Icons.radio_button_checked,
                                      color: ColorManager.primary,
                                    )
                                        : Icon(
                                      Icons.radio_button_off,
                                      color: ColorManager.primary,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.024,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isSelectedAsap == true) {
                                      isSelectedAsap = false;
                                      isSelectedToday = true;
                                      isAsap = false;
                                    }
                                    if (isSelectedAsap == false) {
                                      isAsap = true;
                                      isSelectedAsap = true;
                                      isSelectedToday = false;
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      ImageAssets.tomorrowTimer,
                                      height: AppSize.s20,
                                      width: AppSize.s20,
                                    ),
                                    SizedBox(
                                      width: AppSize.s10,
                                    ),
                                    Text(AppLocalizations.of(context)!.tomorrow,
                                        style: TextStyle(
                                            color: ColorManager.grey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize.s18)),
                                    // SizedBox(width: AppSize.s30,),
                                    Spacer(),
                                    isSelectedAsap
                                        ? Icon(
                                      Icons.radio_button_checked,
                                      color: ColorManager.primary,
                                    )
                                        : Icon(
                                      Icons.radio_button_off,
                                      color: ColorManager.primary,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.024,
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppSize.s10),
                                        border: Border.all(
                                            color: ColorManager.greyLight)),
                                    padding:EdgeInsets.all(AppSize.s5),
                                    child: DropdownButton<String>(
                                      // Step 3.
                                      value: dropdownValue,
                                      // Step 4.

                                      items: days.map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: ColorManager.primaryDark,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: AppSize.s12),
                                              ),
                                            );
                                          }).toList(),
                                      // Step 5.
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                          print(
                                              '=====================number of days');
                                          print(days.indexOf(newValue));
                                          numberOfDay = days.indexOf(newValue);
                                        });
                                      },
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppSize.s10),
                                        border: Border.all(
                                            color: ColorManager.greyLight)),
                                    padding:EdgeInsets.all(AppSize.s5),
                                    child: DropdownButton<String>(
                                      // Step 3.
                                      value: dropdownValue1,
                                      // Step 4.
                                      items: mealTimes.toSet().toList().map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: ColorManager.primaryDark,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: AppSize.s12),
                                              ),
                                            );
                                          }).toList(),
                                      // Step 5.
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          print('=========================hours');
                                          print(dropdownValue1);
                                          dropdownValue1 = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(AppSize.s8),
                                child: Row(
                                  children: [
                                    Text(AppLocalizations.of(context)!.frequency,
                                        style: TextStyle(
                                            color: ColorManager.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: FontSize.s14)),
                                    // SizedBox(width: AppSize.s30,),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.024,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isOneTime == true) {
                                          isWeekly = false;
                                          isMonthly = false;
                                          isOneTime = false;
                                        }
                                        if (isOneTime == false) {
                                          isWeekly = false;
                                          isMonthly = false;
                                          isOneTime = true;
                                        }
                                        frequency = 0;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        isOneTime
                                            ? Icon(
                                          Icons.radio_button_checked,
                                          color: ColorManager.primary,
                                        )
                                            : Icon(
                                          Icons.radio_button_off,
                                          color: ColorManager.primary,
                                        ),
                                        SizedBox(
                                          width: AppSize.s8,
                                        ),
                                        Text(AppLocalizations.of(context)!
                                            .one_time),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isWeekly == true) {
                                          isWeekly = false;
                                          isMonthly = false;
                                          isOneTime = false;
                                        }
                                        if (isWeekly == false) {
                                          isWeekly = true;
                                          isMonthly = false;
                                          isOneTime = false;
                                        }
                                        frequency = 1;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        isWeekly
                                            ? Icon(
                                          Icons.radio_button_checked,
                                          color: ColorManager.primary,
                                        )
                                            : Icon(
                                          Icons.radio_button_off,
                                          color: ColorManager.primary,
                                        ),
                                        SizedBox(
                                          width: AppSize.s8,
                                        ),
                                        Text(
                                            AppLocalizations.of(context)!.weekly),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isMonthly == true) {
                                          isWeekly = false;
                                          isMonthly = false;
                                          isOneTime = false;
                                        }
                                        if (isMonthly == false) {
                                          isWeekly = false;
                                          isMonthly = true;
                                          isOneTime = false;
                                        }
                                        frequency = 2;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        isMonthly
                                            ? Icon(
                                          Icons.radio_button_checked,
                                          color: ColorManager.primary,
                                        )
                                            : Icon(
                                          Icons.radio_button_off,
                                          color: ColorManager.primary,
                                        ),
                                        SizedBox(
                                          width: AppSize.s8,
                                        ),
                                        Text(AppLocalizations.of(context)!
                                            .monthly),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.024,
                              ),
                              Container(
                                height: AppSize.s82,
                                width: double.infinity,
                                padding: EdgeInsets.all(AppSize.s12),
                                child: ElevatedButton(
                                    onPressed: () {
                                      print('=============result');
                                      print(frequency);
                                      print(numberOfDay);
                                      print(dropdownValue1);
                                      print(isAsap);
                                      Navigator.of(context).pop({
                                        'WeeklyOrMonthly': frequency,
                                        'DayNumber': numberOfDay,
                                        'HourNumber': int.parse(dropdownValue1),
                                        'MinuteNumber': 0,
                                        'asap': false,
                                      });
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.confirm)),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.024,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        ),
      );

  Future showArrivalTimeSheet({
    required BuildContext context,
    required String orderId,
    required String deliveryMethodId,
    required Address deliveryPoint,
    required String PaymentMethodId,
    String? OrderNotes,
    String? PromoCode,
    bool? useWallet,
    bool? useRedeemPoints = false,
    bool? usePayLater = false,
    String? desiredDeliveryDate,
  }) =>
      showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.5, 0.7],
          ),
          builder: (context, state) => Material(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: EdgeInsets.all(AppSize.s15),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Text(AppLocalizations.of(context)!.arrival_time,
                            style: TextStyle(
                                fontSize: FontSize.s20,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.primaryDark)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (isSelectedToday == true) {
                                    isSelectedAsap = true;
                                    isSelectedToday = false;
                                    isAsap = true;
                                  }
                                  if (isSelectedToday == false) {
                                    isAsap = false;
                                    isSelectedAsap = false;
                                    isSelectedToday = true;
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: ColorManager.primary,
                                  ),
                                  SizedBox(
                                    width: AppSize.s10,
                                  ),
                                  Text(AppLocalizations.of(context)!.today,
                                      style: TextStyle(
                                          color: ColorManager.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.s18)),
                                  // SizedBox(width: AppSize.s30,),
                                  Spacer(),
                                  isSelectedToday
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: ColorManager.primary,
                                        )
                                      : Icon(
                                          Icons.radio_button_off,
                                          color: ColorManager.primary,
                                        )
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (isSelectedAsap == true) {
                                    isSelectedAsap = false;
                                    isSelectedToday = true;
                                    isAsap = false;
                                  }
                                  if (isSelectedAsap == false) {
                                    isAsap = true;
                                    isSelectedAsap = true;
                                    isSelectedToday = false;
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImageAssets.tomorrowTimer,
                                    height: AppSize.s20,
                                    width: AppSize.s20,
                                  ),
                                  SizedBox(
                                    width: AppSize.s10,
                                  ),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .fastest_delivery,
                                      style: TextStyle(
                                          color: ColorManager.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.s18)),
                                  // SizedBox(width: AppSize.s30,),
                                  Spacer(),
                                  isSelectedAsap
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: ColorManager.primary,
                                        )
                                      : Icon(
                                          Icons.radio_button_off,
                                          color: ColorManager.primary,
                                        )
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                            Visibility(
                              visible: !isSelectedAsap,
                              child: Row(
                                children: [
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppSize.s10),
                                        border: Border.all(
                                            color: ColorManager.greyLight)),
                                    padding:EdgeInsets.all(AppSize.s5),
                                    child: DropdownButton<String>(
                                      // Step 3.
                                      value: dropdownValue,
                                      // Step 4.

                                      items: days.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: ColorManager.primaryDark,
                                                fontWeight: FontWeight.w600,
                                                fontSize: AppSize.s12),
                                          ),
                                        );
                                      }).toList(),
                                      // Step 5.
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                          print(
                                              '=====================number of days');
                                          print(days.indexOf(newValue));
                                          numberOfDay = days.indexOf(newValue);
                                        });
                                      },
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppSize.s10),
                                        border: Border.all(
                                            color: ColorManager.greyLight)),
                                    padding:EdgeInsets.all(AppSize.s5),
                                    child: DropdownButton<String>(
                                      // Step 3.
                                      value: dropdownValue1,
                                      // Step 4.
                                      items: hours
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: ColorManager.primaryDark,
                                                fontWeight: FontWeight.w600,
                                                fontSize: AppSize.s12),
                                          ),
                                        );
                                      }).toList(),
                                      // Step 5.
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          print(
                                              '=========================hours');
                                          print(dropdownValue1);
                                          dropdownValue1 = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: !isSelectedAsap,
                              child: Row(
                                children: [
                                  Text(AppLocalizations.of(context)!.frequency,
                                      style: TextStyle(
                                          color: ColorManager.primaryDark,
                                          fontWeight: FontWeight.w400,
                                          fontSize: FontSize.s14)),
                                  // SizedBox(width: AppSize.s30,),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                            Visibility(
                              visible: !isSelectedAsap,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isOneTime == true) {
                                          isWeekly = false;
                                          isMonthly = false;
                                          isOneTime = false;
                                        }
                                        if (isOneTime == false) {
                                          isWeekly = false;
                                          isMonthly = false;
                                          isOneTime = true;
                                        }
                                        frequency = 0;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        isOneTime
                                            ? Icon(
                                                Icons.radio_button_checked,
                                                color: ColorManager.primary,
                                              )
                                            : Icon(
                                                Icons.radio_button_off,
                                                color: ColorManager.primary,
                                              ),
                                        SizedBox(
                                          width: AppSize.s8,
                                        ),
                                        Text(AppLocalizations.of(context)!
                                            .one_time),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isWeekly == true) {
                                          isWeekly = false;
                                          isMonthly = false;
                                          isOneTime = false;
                                        }
                                        if (isWeekly == false) {
                                          isWeekly = true;
                                          isMonthly = false;
                                          isOneTime = false;
                                        }
                                        frequency = 1;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        isWeekly
                                            ? Icon(
                                                Icons.radio_button_checked,
                                                color: ColorManager.primary,
                                              )
                                            : Icon(
                                                Icons.radio_button_off,
                                                color: ColorManager.primary,
                                              ),
                                        SizedBox(
                                          width: AppSize.s8,
                                        ),
                                        Text(AppLocalizations.of(context)!
                                            .weekly),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isMonthly == true) {
                                          isWeekly = false;
                                          isMonthly = false;
                                          isOneTime = false;
                                        }
                                        if (isMonthly == false) {
                                          isWeekly = false;
                                          isMonthly = true;
                                          isOneTime = false;
                                        }
                                        frequency = 2;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        isMonthly
                                            ? Icon(
                                                Icons.radio_button_checked,
                                                color: ColorManager.primary,
                                              )
                                            : Icon(
                                                Icons.radio_button_off,
                                                color: ColorManager.primary,
                                              ),
                                        SizedBox(
                                          width: AppSize.s8,
                                        ),
                                        Text(AppLocalizations.of(context)!
                                            .monthly),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                            Container(
                              height: AppSize.s82,
                              width: double.infinity,
                              padding: EdgeInsets.all(AppSize.s12),
                              child: ElevatedButton(
                                  onPressed: () {
                                    print(frequency);
                                    print(isAsap);
                                    print(numberOfDay);
                                    print(int.parse(dropdownValue1));
                                    _checkOutGetxController.payForOrder(
                                      context: context,
                                      orderId: orderId,
                                      deliveryMethodId: deliveryMethodId,
                                      deliveryPoint: deliveryPoint,
                                      PaymentMethodId: PaymentMethodId,
                                      useRedeemPoints: useRedeemPoints,
                                      useWallet: useWallet,
                                      usePayLater: usePayLater,
                                      desiredDeliveryDate: desiredDeliveryDate,
                                      asap: isAsap,
                                      SheduleInfo: isAsap
                                          ? null
                                          : {
                                              'WeeklyOrMonthly': frequency,
                                              'DayNumber': numberOfDay,
                                              'HourNumber':
                                                  int.parse(dropdownValue1),
                                              'MinuteNumber': 0,
                                            },
                                      OrderNotes: OrderNotes,
                                      PromoCode: PromoCode,
                                    );
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.confirm)),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

  Future showFeesExplainSheet(BuildContext context) => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.7, 0.7],
          ),
          builder: (context, state) => Material(
            child: Padding(
              padding: EdgeInsets.all(AppSize.s15),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Text(AppLocalizations.of(context)!.our_fees_explained,
                        style: TextStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.primaryDark)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              ImageAssets.deliveryFee,
                              height: AppSize.s20,
                              width: AppSize.s20,
                            ),
                            SizedBox(
                              width: AppSize.s24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.delivery_fee,
                                    style: TextStyle(
                                        color: ColorManager.primaryDark,
                                        fontWeight: FontWeight.w600,
                                        fontSize: FontSize.s18)),
                                Container(
                                  width: AppSize.s258,
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .delivery_fee_text,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: ColorManager.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: FontSize.s14)),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              ImageAssets.serviceFee,
                              height: AppSize.s20,
                              width: AppSize.s20,
                            ),
                            SizedBox(
                              width: AppSize.s24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.service_fee,
                                    style: TextStyle(
                                        color: ColorManager.primaryDark,
                                        fontWeight: FontWeight.w600,
                                        fontSize: FontSize.s18)),
                                Container(
                                  width: AppSize.s258,
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .service_fee_text,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: ColorManager.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: FontSize.s14)),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Container(
                              height: AppSize.s82,
                              // width: double.infinity,
                              padding: EdgeInsets.all(AppSize.s12),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white),
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: ColorManager.primary),
                                            borderRadius:
                                                BorderRadius.circular(AppSize.s10)),
                                      )),
                                  onPressed: () {},
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .read_about_fee,
                                    style:
                                        TextStyle(color: ColorManager.primary),
                                  )),
                            ),
                            Spacer(),
                            Container(
                              height: AppSize.s82,
                              // width: double.infinity,
                              padding: EdgeInsets.all(AppSize.s12),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.got_it)),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Future showStoreClosedPreOrderSheet(
          {required BuildContext context,
          required String bid,
          required HomeViewGetXController homeViewGetXController}) =>
      showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.4, 0.7],
          ),
          builder: (context, state) => Material(
            child: Padding(
              padding: EdgeInsets.all(AppSize.s15),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Image.asset(
                      ImageAssets.coffeeHouse,
                      height: AppSize.s60,
                      width: AppSize.s60,
                    ),
                    // Text(AppLocalizations.of(context)!.our_fees_explained,
                    //     style: TextStyle(
                    //         fontSize: FontSize.s20,
                    //         fontWeight: FontWeight.w600,
                    //         color: ColorManager.primaryDark)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Column(
                      children: [
                        Text(
                            AppLocalizations.of(context)!
                                .store_currently_closed,
                            style: TextStyle(
                                fontSize: FontSize.s20,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.primaryDark)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Center(
                            child: Text(
                                AppLocalizations.of(context)!.do_not_worry,
                                style: TextStyle(
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.greyLight)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Container(
                              height: AppSize.s82,
                              // width: double.infinity,
                              padding: EdgeInsets.all(AppSize.s12),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white),
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    ColorManager.primaryDark),
                                            borderRadius:
                                                BorderRadius.circular(AppSize.s10)),
                                      )),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.back,
                                    style: TextStyle(
                                        color: ColorManager.primaryDark),
                                  )),
                            ),
                            Spacer(),
                            Container(
                              height: AppSize.s82,
                              // width: double.infinity,
                              padding: EdgeInsets.all(AppSize.s12),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PreOrderProductsScreen(bid: bid),));
                                    // homeViewGetXController.getProducts(
                                    //     context: context, bid: bid);
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.pre_order)),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Future showInviteSheet(BuildContext context) => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.6, 0.7],
          ),
          builder: (context, state) => Material(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSize.s15),
                  child: Row(
                    children: [
                      RedirectSocialIcon(
                        url: "https://www.instagram.com/",
                        icon: SocialIconsFlutter.instagram,
                        radius: 25,
                        size: 30,
                        iconColor: Colors.white,
                        circleAvatarColor: Colors.pink,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      RedirectSocialIcon(
                        url:
                            "fb://facewebmodal/f?href=https://www.facebook.com/al.mamun.me12",
                        icon: SocialIconsFlutter.facebook,
                        radius: 25,
                        size: 30,
                        iconColor: Colors.white,
                        circleAvatarColor: Colors.blue,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      RedirectSocialIcon(
                        url: "https://www.twitter.com/",
                        icon: SocialIconsFlutter.twitter,
                        radius: 25,
                        size: 30,
                        iconColor: Colors.white,
                        circleAvatarColor: Colors.blue,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      RedirectSocialIcon(
                        url: "https://wa.me/?text=YourTextHere",
                        icon: Icons.whatshot,
                        radius: 25,
                        size: 30,
                        iconColor: Colors.white,
                        circleAvatarColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppSize.s60,
                )
              ],
            ),
          ),
        ),
      );

  Future showSignInSheet(
          {required BuildContext context, required String role}) =>
      showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.4, 0.7],
          ),
          builder: (context, state) => Material(
            child: Padding(
              padding: EdgeInsets.all(AppSize.s15),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Text(AppLocalizations.of(context)!.register_now,
                        style: TextStyle(
                            fontSize: FontSize.s25,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.primary)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Text(
                        AppLocalizations.of(context)!
                            .you_must_register_or_log_in,
                        style: TextStyle(
                            fontSize: FontSize.s15,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.primaryDark)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginView(role: role),
                          ));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ColorManager.primaryDark),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppSize.s10)))),
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          // 'Login',
                          style: getSemiBoldStyle(
                              color: ColorManager.white, fontSize: FontSize.s18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => RegisterView(role: {
                              'role': role,
                            }),
                          ));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: ColorManager.primaryDark),
                                    borderRadius: BorderRadius.circular(AppSize.s10)))),
                        child: Text(
                          AppLocalizations.of(context)!.sign_up,
                          // 'Login',
                          style: getSemiBoldStyle(
                              color: ColorManager.primaryDark, fontSize: FontSize.s18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s150,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
