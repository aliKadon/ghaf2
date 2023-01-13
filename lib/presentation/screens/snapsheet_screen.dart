import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../app/utils/helpers.dart';
import '../resources/values_manager.dart';

class SnapsheetScreen extends StatefulWidget with Helpers {
  final Map<String, dynamic> orderinfo;

  SnapsheetScreen(this.orderinfo);

  @override
  State<SnapsheetScreen> createState() => _SnapsheetScreenState();
}

class _SnapsheetScreenState extends State<SnapsheetScreen> {
//
// Stripe.setOptions(StripeOptions(
// publishableKey: 'YOUR_STRIPE_PUBLISHABLE_KEY',
// ));

  final _form = GlobalKey<FormState>();

  DateTime dateTime = DateTime.now();

  var cardInfo = {
    'cardNumber': '5555 5555 5555 4444',
    'expiredMonth': '12',
    'expiredYear': '22',
    'cvc': '1234',
  };

  void saveItem() {
    _form.currentState?.save();
  }

  var reedem = false;
  var paylater = false;
  var isCVV = false;

  TextEditingController cardNumberController = TextEditingController();

  TextEditingController creditCardController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expirationController = TextEditingController();

  bool _checkData() {
    if (cardNumberController.text.isNotEmpty) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Enter Required Data!'),
      backgroundColor: Colors.red,
    ));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
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
                              (CreditCardBrand) {}, //true when you want to show cvv(back) view
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
                          decoration: InputDecoration(hintText: "Card number"),
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
                            decoration: const InputDecoration(hintText: "CVV"),
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
                                    const InputDecoration(hintText: "MONTH"),
                                onChanged: (_) {
                                  setState(() {
                                    isCVV = false;
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
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                decoration:
                                    const InputDecoration(hintText: "YEAR"),
                                onChanged: (_) {
                                  setState(() {
                                    isCVV = false;
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
                    padding: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      child: const Text("Add card"),
                      onPressed: () {
                        // showLoadingDialog(context: context, title: 'Logging In');

                        print('=========================checkout');
                        print(
                          widget.orderinfo['orderId'],
                        );
                        print(
                          widget.orderinfo['paylater'],
                        );
                        saveItem();
                        if (_checkData()) {
                          if (widget.orderinfo['address'] == '') {
                            Provider.of<ProductProvider>(context, listen: false)
                                .addOrderWithoutAddress(
                                    orderId: widget.orderinfo['orderId'],
                                    deliveryMethodId:
                                        widget.orderinfo['deliveryMethodId'],
                                    DesiredDeliveryDate:
                                        widget.orderinfo['date'],
                                    UseRedeemPoints: widget.orderinfo['reedem'],
                                    UsePayLater: widget.orderinfo['paylater'],
                                    CardNumber: cardInfo['cardNumber']!,
                                    CardExpMonth:
                                        int.parse(cardInfo['expiredMonth']!),
                                    CardExpCvc: cardInfo['cvc']!,
                                    CardExpYear:
                                        int.parse(cardInfo['expiredYear']!))
                                .then((value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('success'),
                                      backgroundColor: Colors.green,
                                    )))
                                .then((value) => Navigator.of(context)
                                    .pushReplacementNamed(Routes.checkOutConfirmRoute,
                                        arguments: widget.orderinfo['orderId']))
                                .catchError((error) =>
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(error.toString()),
                                      backgroundColor: Colors.red,
                                    )));
                            ;
                          } else {
                            print('==================================addrress');
                            print(widget.orderinfo['address']);
                            Provider.of<ProductProvider>(context, listen: false)
                                .addOrder(
                                  widget.orderinfo['orderId'],
                                  widget.orderinfo['deliveryMethodId'],
                                  widget.orderinfo['date'],
                                  widget.orderinfo['address'],
                                  widget.orderinfo['reedem'],
                                  widget.orderinfo['paylater'],
                                  cardInfo['cardNumber']!,
                                  int.parse(cardInfo['expiredMonth']!),
                                  cardInfo['cvc']!,
                                  int.parse(cardInfo['expiredYear']!),
                                )
                                .then((value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('success'),
                                      backgroundColor: Colors.green,
                                    )))
                                .then((value) => Navigator.of(context)
                                    .pushReplacementNamed(Routes.checkOutConfirmRoute,
                                        arguments: widget.orderinfo['orderId']))
                                .catchError((error) =>
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(error.toString()),
                                      backgroundColor: Colors.red,
                                    )));
                          }
                        }
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
        //               margin: EdgeInsets.all(15),
        //               child: TextFormField(
        //                 decoration: InputDecoration(
        //                   label: Text('Card Number'),
        //                   contentPadding: EdgeInsets.all(8),
        //                   border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(10),
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
        //               margin: EdgeInsets.all(15),
        //               child: TextFormField(
        //                 decoration: InputDecoration(
        //                   label: Text('Expired Date'),
        //                   contentPadding: EdgeInsets.all(8),
        //                   border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(10),
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
        //               margin: EdgeInsets.all(15),
        //               child: TextFormField(
        //                 decoration: InputDecoration(
        //                   label: Text('Card Number'),
        //                   contentPadding: EdgeInsets.all(8),
        //                   border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(10),
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
        //             //         margin: EdgeInsets.all(15),
        //             //         child: TextFormField(
        //             //           decoration: InputDecoration(
        //             //             label: Text('Card Number'),
        //             //             contentPadding: EdgeInsets.all(8),
        //             //             border: OutlineInputBorder(
        //             //               borderRadius: BorderRadius.circular(10),
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
        //             //         margin: EdgeInsets.all(15),
        //             //         child: TextFormField(
        //             //           decoration: InputDecoration(
        //             //             label: Text('Card Number'),
        //             //             contentPadding: EdgeInsets.all(8),
        //             //             border: OutlineInputBorder(
        //             //               borderRadius: BorderRadius.circular(10),
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
