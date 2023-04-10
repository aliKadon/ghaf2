import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../app/preferences/shared_pref_controller.dart';
import '../../domain/model/address.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../screens/checkout/check_out_getx_controller.dart';
import '../screens/store_view/store_view.dart';

class NearByWidget extends StatefulWidget {
  final int index;
  final String imageUrl;
  final String storeName;
  final String branchId;
  final Address address;
  final String details;

  NearByWidget(
      {required this.index,
      required this.imageUrl,
      required this.details,
      required this.storeName,
      required this.address,
      required this.branchId});

  @override
  State<NearByWidget> createState() => _NearByWidgetState();
}

class _NearByWidgetState extends State<NearByWidget> {

  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController
          .getDurationGoogleMap(
              LatOne: SharedPrefController().locationLat,
              LonOne: SharedPrefController().locationLong,
              LatTow: double.parse((widget.address.altitude!)),
              LonTow: double.parse((widget.address.longitude!)));
    print('============================duration in widget');
    print(_checkOutGetxController.duration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              StoreView(branchId: widget.branchId),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.imageUrl ==
                            ''
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width * 0.27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(ImageAssets.coffeeHouse),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width * 0.27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(widget.imageUrl),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                SizedBox(
                  width: 14,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(widget.storeName,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.primaryDark)),
            // SizedBox(
            //   height: 8,
            // ),
            Text(widget.details,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.greyLight)),
            Row(
              children: [
                Icon(
                  Icons.timer,
                  color: ColorManager.grey,
                ),
                SizedBox(
                  width: 8,
                ),
                GetBuilder<CheckOutGetxController>(
                  builder: (controller) => Text('${controller.duration}',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.primaryDark)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
