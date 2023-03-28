import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/app_shared_data.dart';
import 'package:ghaf_application/app/utils/helpers.dart';
import 'package:ghaf_application/data/api/controllers/store_api_controller.dart';
import 'package:ghaf_application/domain/model/popular_search.dart';

class SearchGetxController extends GetxController with Helpers {

  late final StoreApiController _storeApiController = StoreApiController();

  List<PopularSearch>? popularSearch;
  List<String>? recentSearch;
  var isLoadingPopularSearches = true;
  var isLoadingRecentSearches = true;

  void init(BuildContext context) {
    getPopularSearches(context);
    if(AppSharedData.currentUser != null) {
      getRecentSearches(context);
    }
  }

  void getPopularSearches(BuildContext context) async {
    try {
      popularSearch = await _storeApiController.getPopularSearches();
      isLoadingPopularSearches = false;
      update(['popularSearches']);
    }catch(error) {
      showSnackBar(context, message: error.toString(),error: true);
    }
  }

  void getRecentSearches(BuildContext context) async{
    try{
      recentSearch = await _storeApiController.getRecentSearches();
      isLoadingRecentSearches = false;
      update(['recentSearch']);
    }catch(error) {
      showSnackBar(context, message: error.toString(),error: true);
    }
  }
}