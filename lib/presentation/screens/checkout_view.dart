import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/checkout_confirm_view.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:ghaf_application/services/payment_service.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


import '../../domain/model/available_delevey_method.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
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

  var visibility = false;
  var isSwitchedPayLater = false;
  var isSwitched = false;
  var visibilityChecked = false;
  late var payLater = widget.order.orderDetails['totalCostForItems'];
  late var paymentIntent;
  DateTime? date;

  final paymentController = Get.put(PaymentController());


  @override
  void initState() {
    // Provider.of<ProductProvider>(context,listen: false).getAllDetailsOrder();
    Provider.of<ProductProvider>(context, listen: false).getAddress();
    if (widget.order.orderDetails['canPayLaterValue'] == 0) {
      visibilityChecked = false;
    }else {
      visibilityChecked = true;
    }
    super.initState();
    _paymentMethodTextController = TextEditingController();
  }

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
                  Text(
                    AppLocalizations.of(context)!.delivery_method,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s16,
                    ),
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
                              if (widget.order.availableDeliveryMethod[index]
                                      ['methodName'] ==
                                  'Pick up') {
                                setState(() {
                                  visibility = false;
                                });
                              } else {
                                setState(() {
                                  visibility = true;
                                });
                              }
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: AppSize.s8,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: AppSize.s75,
                                    width: AppSize.s75,
                                    padding: EdgeInsets.all(AppPadding.p12),
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      border: Border.all(
                                          width: AppSize.s1,
                                          color: ColorManager.greyLight),
                                      borderRadius:
                                          BorderRadius.circular(AppRadius.r4),
                                    ),
                                    child: Image.asset(
                                      IconsAssets.cart,
                                      height: AppSize.s36,
                                      width: AppSize.s36,
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
                    'Order Summary',
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
                              'TOTAL ',
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${widget.order.orderDetails['totalCostForItems'].toString()} AED',
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
                                'You can pay later ',
                                style: getSemiBoldStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${widget.order.orderDetails['canPayLaterValue'].toString()} AED',
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      return Visibility(
                        visible: visibility,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {

                            });
                          },
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
                                // Image.asset(
                                //   IconsAssets.plus2,
                                //   height: AppSize.s22,
                                //   width: AppSize.s22,
                                // ),
                              ]),
                              SizedBox(
                                height: AppSize.s12,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppPadding.p8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r8),
                                  border: Border.all(
                                      width: AppSize.s1,
                                      color: ColorManager.grey),
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
                                          addresses[index].addressName!,
                                          style: getSemiBoldStyle(
                                            color: ColorManager.primaryDark,
                                            fontSize: FontSize.s16,
                                          ),
                                        ),
                                        Spacer(),
                                        Visibility(
                                          visible: false,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.lightGreenAccent,
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
                                        addresses[index].addressName!,
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
                              SizedBox(
                                height: AppSize.s10,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(
                    height: AppSize.s12,
                  ),
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
                  Row(
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
                              ? 'pick a date'
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  height: AppSize.s258,
                                  width: AppSize.s258,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p12),
                                  decoration: BoxDecoration(
                                    color: ColorManager.white,
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.r8),
                                  ),
                                  child: SizedBox(
                                    height: 200,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: DateTime(2023, 1, 1),
                                      onDateTimeChanged:
                                          (DateTime newDateTime) {
                                        // Do something
                                        setState(() {
                                          date = newDateTime;
                                        });
                                      },
                                    ),
                                  ),
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
                  ),
                  SizedBox(
                    height: AppSize.s44,
                  ),
                  Container(
                    child: Visibility(
                      visible: visibilityChecked,
                      child: Row(
                        children: [
                          Text(
                            'Pay later',
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
                                } else {
                                  isSwitchedPayLater = false;
                                }
                                if (isSwitchedPayLater) {
                                  setState(() {
                                    payLater = widget.order.orderDetails['canPayLaterValue'];
                                  });
                                }else {
                                  setState(() {
                                    payLater = widget.order.orderDetails['totalCostForItems'];
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
                    height: AppSize.s44,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          'Use Your Redeem Points',
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
                              } else {
                                isSwitched = false;
                              }
                              print(isSwitched);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
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
                        paymentController.makePayment(context: context,amount: payLater.toString(), currency: 'AED');
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (builder) => CheckOutConfirmView()),
                        // );
                      },
                      child: Text(
                        'Pay ${payLater.toString()} AED',
                        style: getSemiBoldStyle(
                            color: ColorManager.white, fontSize: FontSize.s18),
                      ),
                    ),
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
