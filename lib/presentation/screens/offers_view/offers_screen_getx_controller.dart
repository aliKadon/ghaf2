import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/product.dart';

class OffersScreenGetXController extends GetxController with Helpers {
  // notifiable.
  bool isOffersLoading = true;

  // bool get isOffersLoading => _isOffersLoading;
  //
  // set isOffersLoading(bool value) {
  //   _isOffersLoading = value;
  //   update();
  // }

  var isCanBuyFromOnSale = false;
  num total = 0;
  num subtotal = 0;


  void addItemToonSaleCart({required num price,required num minOrder}) {
    total += price;
    subtotal = minOrder;

    if(subtotal > 0) {
      subtotal = minOrder - total;
    }



    update();
  }

  // vars.
  late final StoreApiController _storeApiController = StoreApiController();
  List<Product> offers = [];
  List<Product> gifts = [];

  // // constructor fields.
  // final BuildContext context;
  //
  // // constructor.
  // OffersScreenGetXController({
  //   required this.context,
  // });

  // init.
  // @override
  // void onInit() {
  //   getOffers();
  //   super.onInit();
  // }

  // get offers.
  void getOffers({required BuildContext context,String? cid,String? bid,String? sid}) async {

    // offers = await _storeApiController.getOffers();
    // isOffersLoading = false;
    try {
      offers = await _storeApiController.getOffers(cid: cid,bid: bid,sid: sid);
      // await _storeApiController.getProducts();
      isOffersLoading = false;
      update();
    } catch (error) {
      // error.
      showSnackBar(context, message: error.toString(), error: true);
    }
  }

  // get gifts.
  void getGifts({required BuildContext context,String? cid,String? bid,String? sid}) async {

    // offers = await _storeApiController.getOffers();
    // isOffersLoading = false;
    try {
      gifts = await _storeApiController.getGifts(cid: cid,bid: bid,sid: sid);
      // await _storeApiController.getProducts();
      isOffersLoading = false;
      update();
    } catch (error) {
      // error.
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
