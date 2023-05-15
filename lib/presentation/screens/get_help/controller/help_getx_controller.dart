import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/help_api_controller.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../../../domain/model/api_response.dart';
import '../../../../domain/model/items_to_return.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../checkout/cancelling_order_screen.dart';

class HelpGetxController extends GetxController with Helpers {
  List<ItemsToReturn> itemsToReturn = [];
  late ApiResponse apiResponse;
  late ApiResponse apiResponse1;
  late ApiResponse apiResponse2;
  late ApiResponse apiResponse3;

  final HelpApiController _helpApiController = HelpApiController();

  void getItemsToReturn(
      {required BuildContext context, String? productName = ''}) async {
    try {
      itemsToReturn =
      await _helpApiController.getItemsToReturn(productName: productName);
      update();
    } catch (e) {
      showSnackBar(context, message: e.toString(), error: true);
    }
  }

  void itemToReturn({required BuildContext context,
    required String orderId,
    required String productId,
    required String comment,
    required String ticketImage}) async {
    try {
      showLoadingDialog(context: context, title: 'loading...');
      apiResponse = await _helpApiController.returnItemTicket(
          orderId: orderId,
          productId: productId,
          comment: comment,
          ticketImage: ticketImage);
      Navigator.of(context).pop();
      showSheetGetHelpConfirm(context);
      update();
    } catch (e) {
      showSnackBar(context, message: e.toString(), error: true);
    }
  }

  void reportOrderIssueTicket(
      {required BuildContext context, required String orderId, required String comment}) async {
    try {
      showLoadingDialog(context: context, title: 'loading...');
      apiResponse1 = await _helpApiController.reportOrderIssueTicket(
          orderId: orderId, comment: comment);
      Navigator.of(context).pop();
      showSheetGetHelpConfirm(context);
      update();
    }catch (e) {
      showSnackBar(context, message: e.toString(),error: true);
    }
  }

  void reportGeneralIssueTicket(
      {required BuildContext context, required String comment}) async {
    try {
      showLoadingDialog(context: context, title: 'loading...');
      apiResponse1 = await _helpApiController.reportGeneralIssueTicket(
           comment: comment);
      Navigator.of(context).pop();
      showSheetGetHelpConfirm(context);
      update();
    }catch (e) {
      showSnackBar(context, message: e.toString(),error: true);
    }
  }

  void requestCallBack({required BuildContext context , required String bid}) async {
    try {
      showLoadingDialog(context: context, title: 'loading...');
      apiResponse2 = await _helpApiController.requestCallBack(bid: bid);
      Navigator.of(context).pop();
      showSnackBar(context, message: apiResponse2.message);
      update();
    }catch(e) {
      showSnackBar(context, message: e.toString(),error: true);
    }
  }

  void cancelOrder({required BuildContext context,required String id}) async {


    try {
      showLoadingDialog(context: context, title: 'loading...');
      apiResponse3 = await _helpApiController.cancelOrder(orderId: id);
      Navigator.of(context).pop();
      showSnackBar(context, message: apiResponse3.message);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CancellingOrderScreen(),
      ));
      update();
    }catch(e) {
      showSnackBar(context, message: e.toString(),error: true);
    }
  }
}
