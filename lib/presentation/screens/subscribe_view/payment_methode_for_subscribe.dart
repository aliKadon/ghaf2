import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/subscribe_view_getx_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../app/utils/app_shared_data.dart';
import '../../../providers/product_provider.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';

class PaymentMethodeForSubscribe extends StatefulWidget {

  @override
  State<PaymentMethodeForSubscribe> createState() => _PaymentMethodeForSubscribeState();
}

class _PaymentMethodeForSubscribeState extends State<PaymentMethodeForSubscribe> {
  final _form = GlobalKey<FormState>();

  SubscribeViewGetXController _subscribeViewGetXController =
  Get.find<SubscribeViewGetXController>();

  DateTime dateTime = DateTime.now();

  var cardInfo = {
    'cardNumber': '212151',
    'expiredMonth': '15454',
    'expiredYear': '15454',
    'cvc': '1545',
  };

  void saveItem() {
    _form.currentState?.save();
  }

  @override
  void initState() {
    Provider.of<ProductProvider>(context,listen: false).getPlane();
    super.initState();
  }

  var isCVV = false;

  TextEditingController cardNumberController = TextEditingController();

  TextEditingController creditCardController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expirationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var planId = Provider.of<ProductProvider>(context).plane;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 1,
              child: Column(
                children: [
                  SizedBox(
                    height: AppSize.s44,
                  ),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        CreditCardWidget(
                          cardNumber: cardInfo['cardNumber']!,
                          expiryDate: cardInfo['expiredYear']!,
                          cardHolderName: 'Welcome',
                          cvvCode: cardInfo['cvc']!,
                          showBackView: isCVV,
                          onCreditCardWidgetChange:
                              (
                              CreditCardBrand) {}, //true when you want to show cvv(back) view
                        ),
                        // CreditCardForm(
                        //   formKey: _form,
                        //   obscureCvv: true,
                        //   obscureNumber: true,
                        //   cardNumber: cardInfo['cardNumber']!,
                        //   cvvCode: cardInfo['cvc']!,
                        //   isHolderNameVisible: true,
                        //   isCardNumberVisible: true,
                        //   isExpiryDateVisible: true,
                        //   expiryDate: cardInfo['expiredDate']!,
                        //   themeColor: Colors.blue,
                        //   textColor: Colors.white,
                        //   cardNumberDecoration: InputDecoration(
                        //     labelText: 'Number',
                        //     hintText: 'XXXX XXXX XXXX XXXX',
                        //     hintStyle: const TextStyle(color: Colors.white),
                        //     labelStyle: const TextStyle(color: Colors.white),
                        //     // focusedBorder: border,
                        //     // enabledBorder: border,
                        //   ),
                        //   expiryDateDecoration: InputDecoration(
                        //     hintStyle: const TextStyle(color: Colors.white),
                        //     labelStyle: const TextStyle(color: Colors.white),
                        //     // focusedBorder: border,
                        //     // enabledBorder: border,
                        //     labelText: 'Expired Date',
                        //     hintText: 'XX/XX',
                        //   ),
                        //   cvvCodeDecoration: InputDecoration(
                        //     hintStyle: const TextStyle(color: Colors.white),
                        //     labelStyle: const TextStyle(color: Colors.white),
                        //     // focusedBorder: border,
                        //     // enabledBorder: border,
                        //     labelText: 'CVV',
                        //     hintText: 'XXX',
                        //   ),
                        //   cardHolderDecoration: InputDecoration(
                        //     hintStyle: const TextStyle(color: Colors.white),
                        //     labelStyle: const TextStyle(color: Colors.white),
                        //     // focusedBorder: border,
                        //     // enabledBorder: border,
                        //     labelText: 'Card Holder',
                        //   ),
                        //   onCreditCardModelChange: (_){},
                        //   cardHolderName: '',
                        // ),
                        SizedBox(
                          height: AppSize.s44,
                        ),
                        TextFormField(
                          controller: cardNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(19),
                          ],
                          decoration: InputDecoration(hintText: AppLocalizations.of(context)!.number_card),
                          onSaved: (value) {
                            cardInfo = {
                              'cardNumber': value!,
                              'expiredMonth': cardInfo['expiredMonth']!,
                              'expiredYear': cardInfo['expiredYear']!,
                              'cvc': cardInfo['cvc']!,
                            };
                          },
                          // onChanged: (value){
                          //   setState(() {
                          //     cardInfo = {
                          //       'cardNumber': value!,
                          //       'expiredMonth': cardInfo['expiredMonth']!,
                          //       'expiredYear': cardInfo['expiredYear']!,
                          //       'cvc': cardInfo['cvc']!,
                          //     };
                          //   });
                          // },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: TextFormField(
                            decoration:  InputDecoration(hintText: AppLocalizations.of(context)!.cvv),
                            onChanged: (_) {
                              setState(() {
                                isCVV = true;
                              });
                            },
                            onSaved: (value) {
                              cardInfo = {
                                'cardNumber': cardInfo['cardNumber']!,
                                'expiredMonth': cardInfo['expiredMonth']!,
                                'expiredYear': cardInfo['expiredYear']!,
                                'cvc': value!,
                              };
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  // Limit the input
                                  LengthLimitingTextInputFormatter(4),
                                ],
                                decoration:
                                 InputDecoration(hintText: AppLocalizations.of(context)!.month),
                                onChanged: (_) {
                                  setState(() {
                                    isCVV = true;
                                  });
                                },
                                onSaved: (value) {
                                  cardInfo = {
                                    'cardNumber': cardInfo['cardNumber']!,
                                    'expiredMonth': value!,
                                    'expiredYear': cardInfo['expiredYear']!,
                                    'cvc': cardInfo['cvc']!,
                                  };
                                },
                              ),
                            ),
                             SizedBox(width: AppSize.s16),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                decoration:
                                 InputDecoration(hintText: AppLocalizations.of(context)!.year),
                                onChanged: (_) {
                                  setState(() {
                                    isCVV = true;
                                  });
                                },
                                onSaved: (value) {
                                  cardInfo = {
                                    'cardNumber': cardInfo['cardNumber']!,
                                    'expiredMonth': cardInfo['expiredMonth']!,
                                    'expiredYear': value!,
                                    'cvc': cardInfo['cvc']!,
                                  };
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s44,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: AppSize.s16),
                    child: ElevatedButton(
                      child:  Text(AppLocalizations.of(context)!.add_card),
                      onPressed: () {
                        saveItem();
                        // _subscribeViewGetXController.subscribeAsGhafGolden(cardInfo,planId[0].id);
                        // AppSharedData.currentUser!.ghafGold ?? false
                        //     ? _subscribeViewGetXController.cancelSubscription()
                        //     : _subscribeViewGetXController.subscribeAsGhafGolden(cardInfo,planId[0].id);
                        // Navigator.of(context)
                        //     .pushNamed(Routes.paymentMethodRoute,arguments: cardInfo);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // child: SingleChildScrollView(
        // child: Column(
        //   children: [
        //     CreditCardWidget(
        //       cardNumber: cardInfo['cardNumber']!,
        //       expiryDate: cardInfo['expiredMonth']!,
        //       cardHolderName: cardInfo['cardNumber']!,
        //       cvvCode: cardInfo['cardNumber']!,
        //       showBackView: false,
        //       onCreditCardWidgetChange: (CreditCardBrand ) {  }, //true when you want to show cvv(back) view
        //     ),
        //     Form(
        //       key: _form,
        //       child: Container(
        //         height: 300,
        //         child: Column(
        //           children: [
        //             Container(
        //               margin:EdgeInsets.all(AppSize.s15),
        //               child: TextFormField(
        //                 decoration: InputDecoration(
        //                   label: Text('Card Number'),
        //                   contentPadding: EdgeInsets.all(AppSize.s8),
        //                   border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(AppSize.s10),
        //                   ),
        //                 ),
        //                 textInputAction: TextInputAction.next,
        //                 keyboardType: TextInputType.name,
        //                 onSaved: (value) {
        //                   cardInfo = {
        //                     'cardNumber': value!,
        //                     'expiredMonth': cardInfo['expiredMonth']!,
        //                     'expiredYear': cardInfo['expiredYear']!,
        //                     'cvc': cardInfo['cvc']!,
        //                   };
        //                 },
        //               ),
        //             ),
        //             Container(
        //               margin:EdgeInsets.all(AppSize.s15),
        //               child: TextFormField(
        //                 decoration: InputDecoration(
        //                   label: Text('Expired Date'),
        //                   contentPadding: EdgeInsets.all(AppSize.s8),
        //                   border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(AppSize.s10),
        //                   ),
        //                 ),
        //                 textInputAction: TextInputAction.next,
        //                 keyboardType: TextInputType.name,
        //                 onSaved: (value) {
        //                   cardInfo = {
        //                     'cardNumber': value!,
        //                     'expiredMonth': cardInfo['expiredMonth']!,
        //                     'expiredYear': cardInfo['expiredYear']!,
        //                     'cvc': cardInfo['cvc']!,
        //                   };
        //                 },
        //               ),
        //             ),
        //             Container(
        //               margin:EdgeInsets.all(AppSize.s15),
        //               child: TextFormField(
        //                 decoration: InputDecoration(
        //                   label: Text('Card Number'),
        //                   contentPadding: EdgeInsets.all(AppSize.s8),
        //                   border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(AppSize.s10),
        //                   ),
        //                 ),
        //                 textInputAction: TextInputAction.next,
        //                 keyboardType: TextInputType.name,
        //                 onSaved: (value) {
        //                   cardInfo = {
        //                     'cardNumber': value!,
        //                     'expiredMonth': cardInfo['expiredMonth']!,
        //                     'expiredYear': cardInfo['expiredYear']!,
        //                     'cvc': cardInfo['cvc']!,
        //                   };
        //                 },
        //               ),
        //             ),
        //             // Container(
        //             //   width: MediaQuery.of(context).size.width * 0.2,
        //             //   height: 200,
        //             //   child: Row(
        //             //     // shrinkWrap: true,
        //             //     // physics: BouncingScrollPhysics(),
        //             //     // scrollDirection: Axis.horizontal,
        //             //     children: [
        //             //       // Spacer(),
        //             //       Container(
        //             //
        //             //         margin:EdgeInsets.all(AppSize.s15),
        //             //         child: TextFormField(
        //             //           decoration: InputDecoration(
        //             //             label: Text('Card Number'),
        //             //             contentPadding: EdgeInsets.all(AppSize.s8),
        //             //             border: OutlineInputBorder(
        //             //               borderRadius: BorderRadius.circular(AppSize.s10),
        //             //             ),
        //             //           ),
        //             //           textInputAction: TextInputAction.next,
        //             //           keyboardType: TextInputType.name,
        //             //           onSaved: (value) {
        //             //             cardInfo = {
        //             //               'cardNumber': value!,
        //             //               'expiredMonth': cardInfo['expiredMonth']!,
        //             //               'expiredYear': cardInfo['expiredYear']!,
        //             //               'cvc': cardInfo['cvc']!,
        //             //             };
        //             //           },
        //             //         ),
        //             //       ),
        //             //       // Spacer(),
        //             //       Container(
        //             //         margin:EdgeInsets.all(AppSize.s15),
        //             //         child: TextFormField(
        //             //           decoration: InputDecoration(
        //             //             label: Text('Card Number'),
        //             //             contentPadding: EdgeInsets.all(AppSize.s8),
        //             //             border: OutlineInputBorder(
        //             //               borderRadius: BorderRadius.circular(AppSize.s10),
        //             //
        //             //             ),
        //             //           ),
        //             //           textInputAction: TextInputAction.next,
        //             //           keyboardType: TextInputType.name,
        //             //           onSaved: (value) {
        //             //             cardInfo = {
        //             //               'cardNumber' : value!,
        //             //               'expiredMonth': cardInfo['expiredMonth']!,
        //             //               'expiredYear':cardInfo['expiredYear']!,
        //             //               'cvc':cardInfo['cvc']!,
        //             //             };
        //             //           },
        //             //         ),
        //             //       ),
        //             //       // Spacer(),
        //             //     ],
        //             //   ),
        //             // ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}