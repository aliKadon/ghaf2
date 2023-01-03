
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../app/constants.dart';
import '../app/preferences/shared_pref_controller.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required BuildContext context,required String amount, required String currency}) async {
    // displayPaymentSheet(context);
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      print('=================STRIPE');
      print(paymentIntentData);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              // applePay: true,
              // googlePay: true,
              // testEnv: true,
              // merchantCountryCode: 'US',
              merchantDisplayName: 'Kadon',
              customerId: paymentIntentData!['customer'],
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
            ));
        displayPaymentSheet(context);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // Get.snackbar('Payment', 'Payment Successful',
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.green,
      //     colorText: Colors.white,
      //     margin: const EdgeInsets.all(10),
      //     duration: const Duration(seconds: 2));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment Success',style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2)));

    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      //https://api.stripe.com/v1/payment_intents
      // Bearer sk_test_51MLP4SIQef6xe4xw6JFXtWWrBmt2gsL4aat9wb3VKXRNp2P7tQ34iiqmg8Ua1OCUvtdne9QzOpeWinx1ix94BOto005KnKf7xD
      //'Authorization':
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':'Bearer sk_test_51MLP4SIQef6xe4xw6JFXtWWrBmt2gsL4aat9wb3VKXRNp2P7tQ34iiqmg8Ua1OCUvtdne9QzOpeWinx1ix94BOto005KnKf7xD',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}





















// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';







// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:http/http.dart' as http;
//
//
// Map<String, dynamic>? paymentIntentData;
//
// Future<void> makePayment(
//   BuildContext context, {
//   String? amount,
//   String? eventId,
// }) async {
//   try {
//     paymentIntentData = await createPaymentIntent(amount!,'AED');
//     await Stripe.instance.initPaymentSheet(
//       paymentSheetParameters: SetupPaymentSheetParameters(paymentIntentClientSecret:
//         paymentIntentData!['client_secret'],
//     applePay: true,
//     googlePay: true,
//     style: ThemeMode.dark,
//     merchantCountryCode: 'UAE'))
//     .then((value) => {})
//     .catchError(e) {
//       print(e);
//     });
//
//       displayPaymentSheet(context,eventId!);
//   }catch(e) {
//     print('HIII');
//   }
//
//   displayPaymentSheet(BuildContext context,String eventId ) async{
//     try {
//       await Stripe.instance.presentPaymentSheet(parameters: presentPaymentSheetParameters(
//   clientSecret : paymentIntentData!['client_secret'],
//   confirmPayment: true,
//   )).then((value) => null);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('GOOD')));
//       Timer(Duration(seconds: 3), () {Get.back();});
//   }catch(e){
//
//   }
//
//   }
// }
//
// createPaymentIntent(String amount, String currency)async {
//   try {
//     Map<String,dynamic> body = {
//       'amount' : amount,
//       'currency' : currency,
//       'payment_method_type[]' : 'card'
//     };
//     var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
//     body: body,
//     headers: {
//       'Authorization': 'Bearer sk_test_51MLP4SIQef6xe4xw6JFXtWWrBmt2gsL4aat9wb3VKXRNp2P7tQ34iiqmg8Ua1OCUvtdne9QzOpeWinx1ix94BOto005KnKf7xD}',
//       'Content-Type': 'application/x-www-form-urlencoded'
//     });
//     return jsonDecode(response.body);
//   }catch (e) {
//
//   }
// }
//
// calcolateAmount(String amount) {
//   final a = (int.parse(amount)) * 100;
//   return a.toString();
// }
