import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/checkout/checkout_confirm_view.dart';
import 'package:ghaf_application/presentation/screens/login_view/login_view.dart';
import 'package:ghaf_application/presentation/screens/register_view/register_view.dart';
import 'package:ghaf_application/presentation/widgets/dialogs/loading_dialog_widget.dart';
import 'package:intl/intl.dart';
import 'package:redirect_icon/redirect_icon.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:social_media_flutter/widgets/icons.dart';

import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/styles_manager.dart';
import '../../presentation/screens/checkout/cancelling_order_screen.dart';

mixin Helpers {
  String dropdownValue = 'Today';
  String dropdownValue1 = '11:00';

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
              padding: const EdgeInsets.all(15),
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
                                    borderRadius: BorderRadius.circular(10)))),
                        child: Text(
                          AppLocalizations.of(context)!.ok,
                          // 'Login',
                          style: getSemiBoldStyle(
                              color: ColorManager.white, fontSize: 18),
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
              padding: const EdgeInsets.all(15),
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
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.primaryDark)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Text(AppLocalizations.of(context)!.are_you_sure_cancel,
                        style: TextStyle(
                            fontSize: 15,
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
                                            BorderRadius.circular(10)))),
                            child: Text(
                              AppLocalizations.of(context)!.yes,
                              // 'Login',
                              style: getSemiBoldStyle(
                                  color: ColorManager.white, fontSize: 18),
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
                                            BorderRadius.circular(10)))),
                            child: Text(
                              AppLocalizations.of(context)!.no,
                              // 'Login',
                              style: getSemiBoldStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Future showSubscribeSheet(BuildContext context) => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.6, 0.7],
          ),
          builder: (context, state) => Material(
            child: Padding(
              padding: const EdgeInsets.all(15),
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
                          borderRadius: BorderRadius.circular(15),
                          color: ColorManager.greyLight),
                      padding: EdgeInsets.all(14),
                      child: Row(children: [
                        Icon(
                          Icons.wallet_giftcard,
                          color: ColorManager.primaryDark,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.012,
                        ),
                        Text(
                          AppLocalizations.of(context)!.two_weeks_free_trail,
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: ColorManager.greyLight),
                      ),
                      padding: EdgeInsets.all(12),
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
                                'AED 29/month',
                                style: TextStyle(
                                    color: ColorManager.primaryDark,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.s18),
                              ),
                              Spacer(),
                              Icon(
                                Icons.radio_button_checked,
                                color: ColorManager.primary,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          Text(AppLocalizations.of(context)!.billed_every_month,
                              style: TextStyle(color: ColorManager.grey)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.012,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: ColorManager.greyLight),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.yearly_plan,
                              style: TextStyle(color: ColorManager.grey)),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          Row(
                            children: [
                              Text(
                                'AED 19/month',
                                style: TextStyle(
                                    color: ColorManager.primaryDark,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.s18),
                              ),
                              Spacer(),
                              Icon(
                                Icons.radio_button_off,
                                color: ColorManager.primary,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          Text(AppLocalizations.of(context)!.billed_every_year,
                              style: TextStyle(color: ColorManager.grey)),
                        ],
                      ),
                    ),
                    Container(
                      height: AppSize.s82,
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text(AppLocalizations.of(context)!.continue1)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Future showSortBySheet(BuildContext context) => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.5, 0.7],
          ),
          builder: (context, state) => Material(
            child: Padding(
              padding: const EdgeInsets.all(15),
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
                        Row(
                          children: [
                            Text(AppLocalizations.of(context)!.recommended,
                                style: TextStyle(
                                    color: ColorManager.primaryDark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.s18)),
                            // SizedBox(width: AppSize.s30,),
                            Spacer(),
                            Image.asset(
                              ImageAssets.unChecked,
                              height: AppSize.s20,
                              width: AppSize.s20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Divider(
                          thickness: 1,
                          color: ColorManager.greyLight,
                        ),
                        Row(
                          children: [
                            Text(AppLocalizations.of(context)!.fastest_delivery,
                                style: TextStyle(
                                    color: ColorManager.primaryDark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.s18)),
                            // SizedBox(width: AppSize.s30,),
                            Spacer(),
                            Image.asset(
                              ImageAssets.unChecked,
                              height: AppSize.s20,
                              width: AppSize.s20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Divider(
                          thickness: 1,
                          color: ColorManager.greyLight,
                        ),
                        Row(
                          children: [
                            Text(AppLocalizations.of(context)!.rating,
                                style: TextStyle(
                                    color: ColorManager.primaryDark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.s18)),
                            // SizedBox(width: AppSize.s30,),
                            Spacer(),
                            Image.asset(
                              ImageAssets.checked,
                              height: AppSize.s20,
                              width: AppSize.s20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Container(
                          height: AppSize.s82,
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text(AppLocalizations.of(context)!.apply)),
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

  Future showArrivalTimeSheet(BuildContext context) => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.5, 0.7],
          ),
          builder: (context, state) => Material(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(15),
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
                            Row(
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
                                Icon(
                                  Icons.radio_button_checked,
                                  color: ColorManager.primary,
                                )
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                            Row(
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
                                Icon(
                                  Icons.radio_button_off,
                                  color: ColorManager.greyLight,
                                )
                              ],
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
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorManager.greyLight)),
                                  padding: EdgeInsets.all(5),
                                  child: DropdownButton<String>(
                                    // Step 3.
                                    value: dropdownValue,
                                    // Step 4.
                                    items: <String>[
                                      'Today',
                                      'sunday',
                                      'monday',
                                      'friday'
                                    ].map<DropdownMenuItem<String>>(
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
                                      });
                                    },
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorManager.greyLight)),
                                  padding: EdgeInsets.all(5),
                                  child: DropdownButton<String>(
                                    // Step 3.
                                    value: dropdownValue1,
                                    // Step 4.
                                    items: <String>[
                                      '11:00',
                                      '12:00',
                                      '1:00',
                                      '2:00'
                                    ].map<DropdownMenuItem<String>>(
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
                                        dropdownValue1 = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                Text(AppLocalizations.of(context)!.frequency,
                                    style: TextStyle(
                                        color: ColorManager.primaryDark,
                                        fontWeight: FontWeight.w400,
                                        fontSize: FontSize.s14)),
                                // SizedBox(width: AppSize.s30,),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.024,
                            ),
                            Row(
                              children: [
                                Icon(Icons.radio_button_off),
                                SizedBox(
                                  width: AppSize.s8,
                                ),
                                Text(AppLocalizations.of(context)!.one_time),
                                Spacer(),
                                Icon(Icons.radio_button_off),
                                SizedBox(
                                  width: AppSize.s8,
                                ),
                                Text(AppLocalizations.of(context)!.weekly),
                                Spacer(),
                                Icon(Icons.radio_button_off),
                                SizedBox(
                                  width: AppSize.s8,
                                ),
                                Text(AppLocalizations.of(context)!.monthly),
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
                              padding: EdgeInsets.all(12),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          CheckOutConfirmView(),
                                    ));
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
              padding: const EdgeInsets.all(15),
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
                              padding: EdgeInsets.all(12),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white),
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: ColorManager.primary),
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                              padding: EdgeInsets.all(12),
                              child: ElevatedButton(
                                  onPressed: () {},
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

  Future showStoreClosedPreOrderSheet(BuildContext context) =>
      showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          snapSpec: SnapSpec(
            snappings: [0.4, 0.7],
          ),
          builder: (context, state) => Material(
            child: Padding(
              padding: const EdgeInsets.all(15),
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
                              padding: EdgeInsets.all(12),
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
                                                BorderRadius.circular(10)),
                                      )),
                                  onPressed: () {},
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
                              padding: EdgeInsets.all(12),
                              child: ElevatedButton(
                                  onPressed: () {},
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
                  padding: const EdgeInsets.all(15),
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

  Future showSignInSheet(BuildContext context) => showSlidingBottomSheet(
    context,
    builder: (context) => SlidingSheetDialog(
      snapSpec: SnapSpec(
        snappings: [0.4, 0.7],
      ),
      builder: (context, state) => Material(
        child: Padding(
          padding: const EdgeInsets.all(15),
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
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.primary)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.024,
                ),
                Text(AppLocalizations.of(context)!.you_must_register_or_log_in,
                    style: TextStyle(
                        fontSize: 15,
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => LoginView(),
                      ));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            ColorManager.primaryDark),
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      // 'Login',
                      style: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: 18),
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => RegisterView(),
                      ));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll(Colors.white),
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                side: BorderSide(
                                    color: ColorManager.primaryDark),
                                borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      AppLocalizations.of(context)!.sign_up,
                      // 'Login',
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryDark, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
