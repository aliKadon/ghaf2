import 'package:get/get.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/branch.dart';

import '../../../domain/model/store.dart';

class CategoriesGetxController extends GetxController {
  late final StoreApiController _storeApiController = StoreApiController();

  List<Branch> stores = [];

  void getStores(
      {String? cid,
      String? filterType = '',
      String? filterContent = '',
      String? sortType= ''}) async {
    stores = await _storeApiController.getStoreByCategoriy(
        cid: cid,
        filterContent: filterContent,
        filterType: filterType,
        sortType: sortType);

    update();
  }
}
