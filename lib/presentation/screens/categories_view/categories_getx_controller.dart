import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/branch.dart';

class CategoriesGetxController extends GetxController with Helpers {
  late final StoreApiController _storeApiController = StoreApiController();

  List<Branch> branches = [];
  Branch? branchById;
  var isLoadingBranchById = true;

  void getBranches(
      {String? cid,
      String? filterType = '',
      String? filterContent = '',
      String? sortType = ''}) async {
    branches = await _storeApiController.getBranchByCategoriy(
        cid: cid,
        filterContent: filterContent,
        filterType: filterType,
        sortType: sortType);

    update();
  }

  void getBranchById(
      {required BuildContext context, required String branchId}) async {
    try {
      branchById = await _storeApiController.getBranchById(branchId: branchId);
      isLoadingBranchById = false;

      update();
    } catch (error) {
      showSnackBar(context, message: error.toString(), error: true);
    }
  }
}
