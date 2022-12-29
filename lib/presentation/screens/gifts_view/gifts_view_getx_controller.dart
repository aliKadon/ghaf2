import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/gifts_api_controller.dart';
import 'package:ghaf_application/domain/model/gift.dart';

class GiftsViewGetXController extends GetxController with Helpers {
  // notifiable.
  bool _isGiftsLoading = true;

  bool get isGiftsLoading => _isGiftsLoading;

  set isGiftsLoading(bool value) {
    _isGiftsLoading = value;
    update(['isGiftsLoading']);
  }

  // vars.
  late final GiftsApiController _giftsApiController = GiftsApiController();
  List<Gift> gifts = [];

  // constructor fields.
  final BuildContext context;

  // constructor.
  GiftsViewGetXController({
    required this.context,
  });

  // init.
  @override
  void onInit() {
    getGifts();
    super.onInit();
  }

  // get gifts.
  void getGifts() async {
    try {
      gifts = await _giftsApiController.getGifts();
      isGiftsLoading = false;
    } catch (error) {
      // error.
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
