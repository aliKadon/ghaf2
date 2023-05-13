import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../app/preferences/shared_pref_controller.dart';
import '../../domain/model/address.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';
import '../screens/checkout/check_out_getx_controller.dart';
import '../screens/store_view/store_view.dart';

class NearByWidget extends StatefulWidget {
  final int index;
  final String imageUrl;
  final String storeName;
  final String branchId;
  final Address address;
  final String details;
  final bool is24;
  String? addressLong;
  String? addressLat;

  NearByWidget({
    required this.index,
    required this.imageUrl,
    required this.details,
    required this.is24,
    required this.storeName,
    required this.address,
    required this.branchId,
    required this.addressLat,
    required this.addressLong,
  });

  @override
  State<NearByWidget> createState() => _NearByWidgetState();
}

class _NearByWidgetState extends State<NearByWidget> {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());

  var dur = "0";

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController
        .getDurationGoogleMap(
            LatOne: widget.addressLat == null || widget.addressLat!.isEmpty
                ? SharedPrefController().locationLat
                : double.parse((widget.addressLat!)),
            LonOne: widget.addressLong == null || widget.addressLong!.isEmpty
                ? SharedPrefController().locationLong
                : double.parse((widget.addressLong!)),
            LatTow: double.parse((widget.address.altitude!)),
            LonTow: double.parse((widget.address.longitude!)))
        .then((value) => dur = _checkOutGetxController.duration);
    super.initState();
  }

  // late var dur = _checkOutGetxController.duration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              StoreView(branchId: widget.branchId, is24: widget.is24),
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(AppSize.s8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.imageUrl == ''
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width * 0.27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s10),
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
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          image: DecorationImage(
                            image: NetworkImage(widget.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                SizedBox(
                  width: AppSize.s14,
                )
              ],
            ),
            SizedBox(
              height: AppSize.s8,
            ),
            Container(
              width: AppSize.s154,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.storeName,
                      style: TextStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.primaryDark)),
                  Text(widget.details,
                      style: TextStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.greyLight)),
                  Row(
                    children: [
                      Image.asset(
                        IconsAssets.timer,
                        height: AppSize.s20,
                        width: AppSize.s20,
                      ),
                      SizedBox(
                        width: AppSize.s8,
                      ),
                      GetBuilder<CheckOutGetxController>(
                        builder: (controller) => Text('${dur}',
                            style: TextStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.primaryDark)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 8,
            // ),
          ],
        ),
      ),
    );
  }
}
