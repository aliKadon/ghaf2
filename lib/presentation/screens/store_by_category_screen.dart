import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/providers/category_provider.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false)
        .getStoreForCategory(widget.productInf['id'])
        .then((value) => Provider.of<ProductProvider>(context, listen: false)
            .getDurationGoogleMap(
                LatOne: 24.600661,
                LonOne: 54.935448,
                LatTow: 24.400661,
                LonTow: 54.635448))
        .then((value) => isLoading = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<CategoryProvider>(context).storeByCategory;
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
                    ? Center(
                        child: Container(
                          width: 20.h,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      )
                    : store.length == 0
                        ? Center(
                            child: Text('No Product Found'),
                          )
                        : ListView.builder(
                            itemCount: storeName.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index1) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.products,arguments: storeid[index1]);
                                },
                                child: Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading:
                                          Image.asset('assets/images/logo1.png'),
                                      title: Text(
                                          store[index1].branch?['storeName'] ??
                                              'sasa'),
                                      subtitle: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              store[0].storeStars == null ?Text(
                                                '0.0',
                                                style: getSemiBoldStyle(
                                                  color: ColorManager.primaryDark,
                                                  fontSize: FontSize.s18,
                                                ),
                                              ):  Text(
                                                '${store[0].storeStars.toString()}.0',
                                                style: getSemiBoldStyle(
                                                  color: ColorManager.primaryDark,
                                                  fontSize: FontSize.s18,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                '(${store[0].reviewCount.toString()})',
                                                style: getSemiBoldStyle(
                                                  color: ColorManager.primaryDark,
                                                  fontSize: FontSize.s14,
                                                ),
                                              ),
                                            ],
                                          ),
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
                                                      width: 10,
                                                    ),
                                                    Text((store[0].branch?[
                                                                'storeDeliveryCost']
                                                            [index]['cost'])
                                                        .toString()),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.timer,
                                                color: ColorManager.primary,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(duration)
                                            ],
                                          ),
                                        ],
                                      ),
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
