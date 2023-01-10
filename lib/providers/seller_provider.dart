import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghaf_application/app/constants.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/domain/model/ghaf_image.dart';
import 'package:ghaf_application/domain/model/plan_seller_individual.dart';
import 'package:http/http.dart' as http;

import '../domain/model/read-individual-products.dart';

class SellerProvider with ChangeNotifier, ApiHelper {
  List<ReadIndividualProducts> _readIndividualProducts = [];

  List<ReadIndividualProducts> get readIndividualProduct {
    return [..._readIndividualProducts];
  }

  String createPaymentLink = '';

  Map<String,dynamic> userDetails = {};

  Map<String,dynamic> sellerDetails = {};

  // Map<String, dynamic> get createPaymentLink {
  //   return {..._createPaymentLink};
  // }

  List<PlanSellerIndividual> _planSellerIndividual = [];

  List<PlanSellerIndividual> get planSellerIndividual {
    return [..._planSellerIndividual];
  }

  String repo = '';

  Future<void> addPaymentCard(BuildContext context, String cardNumber,
      String cvv, int expiredMonth, int expiredYear, String PlanId) async {
    var url = Uri.parse('${Constants.urlBase}/Auth/subscripe-as-individual');
    try {
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            'paymentMethodType': 'card',
            'cardNumber': cardNumber,
            'cardExpMonth': expiredMonth,
            'cardExpCvc': cvv,
            'cardExpYear': expiredYear,
            'PlanId': PlanId,
          }));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          response.body.toString(),
        ),
      ));
      repo = json.decode(response.body)['message'];
      notifyListeners();
      // print('=====================addPaymentCard============');
      // print(response.statusCode);
      // print(response.body);
      // print(json.decode(response.body)['message']);
      // print('=====================================repo');
      repo = jsonDecode(response.body)['message'];
      notifyListeners();
      // print(repo);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> submitIndividualForm(
      BuildContext context,
      String shopName,
      String companyEmail,
      String phoneNumber,
      String companyName,
      int businessSector,
      String corporateBusiness,
      String countryName,
      String cityName,
      String addressName,
      String postalCode) async {
    var url = Uri.parse('${Constants.urlBase}/Auth/submit-individual-form');
    try {
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            'businessType': businessSector,
            'businessSector': corporateBusiness,
            'shopName': shopName,
            'phoneNumber': phoneNumber,
            'companyName': companyName,
            'countryName': countryName,
            'cityName': cityName,
            'addressName': addressName,
            'postalCode': postalCode,
          }));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          jsonDecode(response.body)['message'],
        ),
        backgroundColor: Colors.green,
      ));
      // print('=====================submitIndividualForm============');
      // print(response.statusCode);
      // print(response.body);
      // print('=====================================repo');
      repo = jsonDecode(response.body)['message'];
      notifyListeners();
      // print(repo);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> addBankInfo(BuildContext context, String swiftCode,
      String accountNumber, String name, String bankName) async {
    var url =
        Uri.parse('${Constants.urlBase}/Auth/add-individual-bank-account');
    try {
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            'swiftCode': swiftCode,
            'accountNumber': accountNumber,
            'accountHolder': name,
            'bankName': bankName,
          }));
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(
      //     response.body.toString(),
      //   ),
      // ));
      // print('=====================bank============');
      // print(response.statusCode);
      // print(response.body);
      // print('=====================================repo');
      repo = jsonDecode(response.body)['message'];
      notifyListeners();
      // print(repo);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> registration(
      String userName,
      String email,
      String role,
      String password,
      String confirmPassword,
      String firstName,
      String lastName,
      String referralcode,
      String telephone,
      String birthDate) async {
    var url = Uri.parse('${Constants.urlBase}/Auth/register');
    try {
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            'userName': userName,
            'email': email,
            'role': role,
            'password': password,
            'confirmPassword': confirmPassword,
            'firstName': firstName,
            'lastName': lastName,
            'referralcode': referralcode,
            'telephone': telephone,
            'birthDate': birthDate,
          }));

      // print('=====================register============');
      // print(response.statusCode);
      // print(response.body);
      // print('=====================================repo');
      repo = jsonDecode(response.body)['message'];
      notifyListeners();
      // print(repo);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> createIndividualProducts(
      String name,
      String description,
      String? characteristics,
      String productType,
      int price,
      List<String>? image) async {
    var url =
        Uri.parse('${Constants.urlBase}/product/create-individual-products');
    try {
      final response = await http.post(url,
          headers: headers,
          body: jsonEncode({
            'name': name,
            'description': description,
            'characteristics': characteristics,
            'productType': productType,
            'price': price,
            'images': image,
          }));

      print('=====================addItemSeller============');
      print(response.statusCode);
      print(response.body);
      print(json.decode(response.body));
      print('=====================================repo');
      repo = jsonDecode(response.body)['message'];
      notifyListeners();
      // print(repo);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> readIndividualProducts() async {
    var url =
        Uri.parse('${Constants.urlBase}/product/read-individual-products');

    final response = await http.get(url, headers: headers);

    List data = json.decode(response.body)['data'];

    List<ReadIndividualProducts> list = [];

    for (int i = 0; i < data.length; i++) {
      list.add(ReadIndividualProducts(
          data[i]['id'],
          data[i]['name'],
          data[i]['price'],
          data[i]['stripeId'] ?? '',
          data[i]['priceId'] ?? '',
          data[i]['description'],
          data[i]['characteristics'],
          data[i]['productType'],
          data[i]['isoCurrencySymbol'],
          data[i]['addedAt'],
          data[i]['ghafImageIndividual']));
      // print('=================================ReadIndividualProducts');
      // print(response.statusCode);
      // print(json.decode(response.body));
    }
    _readIndividualProducts = list;
    // print('=====================================repo');
    repo = jsonDecode(response.body)['message'];
    // print(repo);
    notifyListeners();
  }

  Future<void> getPlanForSellerIndividual() async {
    var url = Uri.parse('${Constants.urlBase}/Auth/get-individual-plans');
    final response = await http.get(url, headers: headers);

    List data = json.decode(response.body)['data'];

    List<PlanSellerIndividual> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(PlanSellerIndividual(
          id: data[i]['id'],
          name: data[i]['name'],
          description: data[i]['description'],
          priceId: data[i]['priceId'],
          stripeId: data[i]['stripeId'],
          type: data[i]['type'],
          freeDays: data[i]['freeDays'],
          hide: data[i]['hide'],
          priceAmount: data[i]['priceAmount'],
          priceCurrency: data[i]['priceCurrency'],
          priceRecuencyInterval: data[i]['priceRecuencyInterval'],
          setUpCost: data[i]['setUpCost'],
          typeName: data[i]['typeName']));
    }
    _planSellerIndividual = list;
    // print('=====================================repo');
    repo = jsonDecode(response.body)['message'];
    // print(repo);
    notifyListeners();
    // print('=================================ReadIndividualProducts');
    // print(response.statusCode);
    // print(json.decode(response.body));
  }

  Future<void> getUserDetails() async {
    var url = Uri.parse(
        '${Constants.urlBase}/Auth/getUserDetails');
    final response = await http.get(url,headers: headers);

    var data = jsonDecode(response.body)['data'];

    print('============================userDetails');
    print(data);

    userDetails = data;
    notifyListeners();
  }

  Future<void> getSellerDetails() async {
    var url = Uri.parse(
        '${Constants.urlBase}/Auth/getsellerdetails');

    final response = await http.get(url, headers: headers);
    var data = jsonDecode(response.body)['data'];
    print('response : ${response.body}');

    sellerDetails = data;
    notifyListeners();


  }

  Future<void> createPaymnetLink(String productId, int count) async {
    var url = Uri.parse(
        '${Constants.urlBase}/product/create-paymnet-link?prodId=$productId&Quantity=$count');

    final response = await http.get(url, headers: headers);
    print('response : ${response.body}');

    var data = jsonDecode(response.body)['data'];
    print('============================================data0');
    print(data.toString());

    // print('=====================================repo');
    repo = jsonDecode(response.body)['message'];
    // print(repo);
    createPaymentLink = data.toString();

    notifyListeners();
    // for (int i = 0; i < data.length; i++) {
    //   list.forEach((key, value) {
    //     'id' : data[i]['id']
    //   }) = {
    //     CreatePaymentLink(
    //       data[i]['id'],
    //       data[i]['object'],
    //       data[i]['active'],
    //       data[i]['afterCompletion'] ?? '',
    //       data[i]['allowPromotionCodes'] ?? '',
    //       data[i]['applicationFeeAmount'],
    //       data[i]['applicationFeePercent'],
    //       data[i]['automaticTax'],
    //       data[i]['billingAddressCollection'],
    //       data[i]['consentCollection'],
    //       data[i]['currency'],
    //       data[i]['customText'],
    //       data[i]['customerCreation'],
    //       data[i]['lineItems'],
    //       data[i]['livemode'],
    //       data[i]['metadata'],
    //       data[i]['onBehalfOfId'],
    //       data[i]['onBehalfOf'],
    //       data[i]['paymentIntentData'],
    //       data[i]['paymentMethodCollection'],
    //       data[i]['paymentMethodTypes'],
    //       data[i]['phoneNumberCollection'],
    //       data[i]['shippingAddressCollection'],
    //       data[i]['shippingOptions'],
    //       data[i]['submitType'],
    //       data[i]['subscriptionData'],
    //       data[i]['taxIdCollection'],
    //       data[i]['transferData'],
    //       data[i]['url'],
    //       data[i]['rawJObject'],
    //       data[i]['stripeResponse'],
    //     ),
    //   }
    // }
    // _createPaymentLink = data;
    // print('=================================createPaymnetLink');
    // print(response.statusCode);
    // print(data.toString());
  }
}
