import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/branch.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../checkout/check_out_getx_controller.dart';

class CategoriesGetxController extends GetxController with Helpers {
  late final StoreApiController _storeApiController = StoreApiController();


  late final CheckOutGetxController _checkOutGetxController =
  Get.put(CheckOutGetxController());

  List<Branch> branches = [];
  List<dynamic> durations = [];
  Branch? branchById;
  var isLoadingBranchById = true;
  var isLoadingBranch = true;

  void getBranches(
      {
        required BuildContext context,
        String? cid,
      String? filterType = '',
      String? filterContent = '',
      String? sortType = ''}) async {
    var time = '';

    try {

      branches = await _storeApiController.getBranchByCategoriy(
          cid: cid,
          filterContent: filterContent,
          filterType: filterType,
          sortType: sortType);

      for(Branch branch in branches) {
        _checkOutGetxController
            .getDurationGoogleMap(
            LatOne: SharedPrefController().locationLat,
            LonOne: SharedPrefController().locationLong,
            LatTow: double.parse((branch.branchAddress!.altitude!)),
            LonTow: double.parse((branch.branchAddress!.longitude!)));
        time = _checkOutGetxController.duration;

        durations.add(time);
      }
      isLoadingBranch = false;

      update();

    }catch(error){
      showSnackBar(context, message: error.toString(), error: true);

    }


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
