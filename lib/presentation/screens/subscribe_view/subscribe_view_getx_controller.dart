import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/auth_api_controller.dart';
import 'package:ghaf_application/data/api/controllers/subscription_api_controller.dart';
import 'package:ghaf_application/domain/model/api_response.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';

import '../../../domain/model/subscription_plan.dart';

class SubscribeViewGetXController extends GetxController with Helpers {
  // vars.
  late final SubscriptionApiController _subscriptionApiController =
  SubscriptionApiController();
  late final AuthApiController _authApiController = AuthApiController();
  List<SubscriptionPlan> subscriptionPlan = [];

  // constructor fields.
  final BuildContext context;

  // constructor.
  SubscribeViewGetXController({
    required this.context,
  });

  // subscribe as free.
  void subscribeAsFree() async {
    try {
      showLoadingDialog(context: context, title: 'Skipping');
      final ApiResponse subscripeAsFreeApiResponse =
      await _subscriptionApiController.subscribeAsFree();
      final ApiResponse profileApiResponse = await _authApiController.profile();
      if (subscripeAsFreeApiResponse.status == 200 &&
          profileApiResponse.status == 200) {
        // success.
        showSnackBar(context,
            message: subscripeAsFreeApiResponse.message, error: false);
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.mainRoute, (_) => false);
      } else {
        // failed.
        Navigator.pop(context);
        showSnackBar(context,
            message: subscripeAsFreeApiResponse.message, error: true);
      }
    } catch (error) {
      // error.
      Navigator.pop(context);
      debugPrint(error.toString());
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  void getSubscriptionPlan() async {
    try {
      subscriptionPlan = await _subscriptionApiController.getSubscriptionPlan();
    }catch(error) {
      showSnackBar(context, message: error.toString(),error: true);
    }
  }

  // subscribe as ghaf golden.
  void subscribeAsGhafGolden({required String paymentMethodId ,required String planId}) async {
    try {
      showLoadingDialog(context: context, title: 'Subscribing');
      final ApiResponse subscribeAsGhafGoldenApiResponse =
      await _subscriptionApiController.subscribeAsGhafGolden(paymentMethodId: paymentMethodId, planId: planId);
      final ApiResponse profileApiResponse = await _authApiController.profile();
      if (subscribeAsGhafGoldenApiResponse.status == 200 &&
          profileApiResponse.status == 200) {
        // success.
        showSnackBar(context,
            message: subscribeAsGhafGoldenApiResponse.message, error: false);
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.mainRoute, (_) => false);
      } else {
        // failed.
        Navigator.pop(context);
        showSnackBar(context,
            message: subscribeAsGhafGoldenApiResponse.message, error: true);
      }
    } catch (error) {
      // error.
      Navigator.pop(context);
      debugPrint(error.toString());
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  // cancel subscription.
  void cancelSubscription() async {
    try {
      showLoadingDialog(context: context, title: 'Canceling');
      final ApiResponse cancelSubscriptionApiResponse =
      await _subscriptionApiController.cancelSubscription();
      final ApiResponse profileApiResponse = await _authApiController.profile();
      if (cancelSubscriptionApiResponse.status == 200 &&
          profileApiResponse.status == 200) {
        // success.
        showSnackBar(context,
            message: cancelSubscriptionApiResponse.message, error: false);
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.mainRoute, (_) => false);
      } else {
        // failed.
        Navigator.pop(context);
        showSnackBar(context,
            message: cancelSubscriptionApiResponse.message, error: true);
      }
    } catch (error) {
      // error.
      Navigator.pop(context);
      debugPrint(error.toString());
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
