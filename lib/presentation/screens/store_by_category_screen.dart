import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/providers/category_provider.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:ghaf_application/domain/model/product2.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class StoreByCategryScreen extends StatefulWidget {
  final Map<String, dynamic> productInf;

  StoreByCategryScreen(this.productInf);

  @override
  State<StoreByCategryScreen> createState() => _StoreByCategryScreenState();
}

class _StoreByCategryScreenState extends State<StoreByCategryScreen> {
  var isLoading = true;

  double myLocationLat = SharedPrefController().locationLat;
  double myLocationLong = SharedPrefController().locationLong;

  var store;
  var duration;
  var _Duration;

  // #############################################
  //get all information from latitude and longitude
  // #############################################
  // Future<void> GetAddressFromLatLong(LatLng latLng)async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
  //   print('======================================my address');
  //   print(placemarks[0]);
  //   Placemark place = placemarks[0];
  //   // Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  //
  // }
  // ##############################################
  // ##############################################

  @override
  void initState() {

    Provider.of<CategoryProvider>(context, listen: false)
        .getStoreForCategory(widget.productInf['id'])
        .then((value) => isLoading = false);

    // Provider.of<CategoryProvider>(context, listen: false)
    //     .getStoreForCategory(widget.productInf['id'])
    //     .then((value) => Provider.of<ProductProvider>(context, listen: false)
    //         .getDurationGoogleMap(
    //             LatOne: 24.600661,
    //             LonOne: 54.935448,
    //             LatTow: 24.400661,
    //             LonTow: 54.635448))
    //     .then((value) => isLoading = false);

    // ############################################
    //get all information from latitude and longitude
    // #############################################
    // GetAddressFromLatLong(LatLng(myLocationLat,myLocationLong));
    // ##############################################
    // ##############################################
    super.initState();
  }

  Future<void> getNearestDurations(List<Product2> product2) async{
    List<dynamic> list = [];
    for (int i = 0; i < product2.length; i++) {
      await Provider.of<ProductProvider>(context,listen: false).getDurationGoogleMap(
          LatOne: 24.600661,
          LonOne: 54.935448,
          LatTow:
          double.parse(product2[i].branch!['branchAddress']['altitude']) ??
              24.400661,
          LonTow:
          double.parse(product2[i].branch!['branchAddress']['longitude']) ??
              54.635448).then((value) => list.add({
        'distance' : Provider.of<ProductProvider>(context,listen: false).distance,
        'duration': Provider.of<ProductProvider>(context,listen: false).duration
      })).then((value) => null);
      ;
    }

    for (int i = 0; i< list.length; i++ ) {
      print(i);
      var distance = list[i]['distance'];
      var min = list[i]['duration'];
      if(i+1 < list.length) {
        if(distance.compareTo(list[i+1]['distance']) == -1){
          min = list[i+1]['duration'];
        }
        setState(() {
          _Duration = min;
        });
      }else {
        _Duration = list[i]['duration'];
      }

    }}
  @override
  void didChangeDependencies() {
    // duration = Provider
    //     .of<ProductProvider>(context)
    //     .duration;

    getNearestDurations(
        Provider.of<CategoryProvider>(context,listen: false).storeByCategory);

    print('================================duration2');
    print(duration);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    store = Provider.of<CategoryProvider>(context).storeByCategory;
    var storeName = Provider.of<CategoryProvider>(context).store;
    var storeid = Provider.of<CategoryProvider>(context).storeId;

    var duration = Provider.of<ProductProvider>(context).duration;

    print('=======================================duration');
    print(duration);
    print(myLocationLat);
    print(myLocationLong);

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p16, vertical: AppPadding.p16),
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.all_stores,
                      style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                isLoading
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2),
                        child: Container(
                          width: 20.h,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      )
                    : store.length == 0
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 2),
                            child: Text('No Product Found'),
                          )
                        : ListView.builder(
                            itemCount: storeName.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index1) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.products,
                                      arguments: {
                                        'storeId': storeid[index1],
                                        'categoryId': '',
                                      });
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/images/logo1.png',
                                          height: 100,
                                          width: 100,
                                        ),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  store[index1]
                                                          .branch?['storeName'] ??
                                                      'sasa',
                                                  style: TextStyle(fontSize: 15.0),
                                                ),
                                                SizedBox(width: 11,),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.timer,
                                                      color: ColorManager.primary,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(_Duration ??
                                                        0.toString()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 2,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                store[0].storeStars == null
                                                    ? Text(
                                                  '0.0',
                                                  style: getSemiBoldStyle(
                                                    color: ColorManager
                                                        .primaryDark,
                                                    fontSize: FontSize.s18,
                                                  ),
                                                )
                                                    : Text(
                                                  '${store[0].storeStars.toString()}.0',
                                                  style: getSemiBoldStyle(
                                                    color: ColorManager
                                                        .primaryDark,
                                                    fontSize: FontSize.s18,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '(${store[0].storeReviewCount.toString()})',
                                                  style: getSemiBoldStyle(
                                                    color:
                                                    ColorManager.primaryDark,
                                                    fontSize: FontSize.s14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                           Column(
                                                children: [
                                                  Container(
                                                    // width: 200,
                                                    height:
                                                        MediaQuery.of(context).size.height *
                                                            0.1,
                                                    child: ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemCount: (store[0]
                                                              .branch?['storeDeliveryCost'])
                                                          .length,
                                                      itemBuilder: (context, index) {
                                                        return Row(
                                                          children: [
                                                            Image.network(store[0].branch?[
                                                                    'storeDeliveryCost']
                                                                [index]['methodImage']),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text((store[0].branch?[
                                                                        'storeDeliveryCost']
                                                                    [index]['cost'])
                                                                .toString()),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),

                                          ],
                                        ),

                                      ],
                                    ),

                                  ),
                                ),
                              );
                            },
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
