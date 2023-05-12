import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/domain/model/address.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';

import '../../app/preferences/shared_pref_controller.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../screens/checkout/check_out_getx_controller.dart';

class PreviousOrderWidget extends StatefulWidget {
  String storeImage;
  String storeName;
  Address storeAddress;
  String? addressLong;
  String? addressLat;

  PreviousOrderWidget(
      {required this.storeName,
      required this.storeAddress,
      required this.storeImage,
      this.addressLat,
      this.addressLong,
      });

  @override
  State<PreviousOrderWidget> createState() => _PreviousOrderWidgetState();
}

class _PreviousOrderWidgetState extends State<PreviousOrderWidget> {
//controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.put(CheckOutGetxController());

  var dur = "0";

  @override
  void initState() {
    // TODO: implement initState
    _checkOutGetxController
        .getDurationGoogleMap(
            LatOne:widget.addressLat == null || widget.addressLat!.isEmpty ? SharedPrefController().locationLat : double.parse((widget.addressLat!)),
            LonOne:widget.addressLong == null || widget.addressLong!.isEmpty ? SharedPrefController().locationLong : double.parse((widget.addressLong!)),
            LatTow: double.parse((widget.storeAddress.altitude!)),
            LonTow: double.parse((widget.storeAddress.longitude!)))
        .then((value) => dur = _checkOutGetxController.duration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.11,
                width: MediaQuery.of(context).size.width * 0.27,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(widget.storeImage,
                    errorBuilder: (context, error, stackTrace) {
                  return Image.asset(ImageAssets.brStore);
                }, fit: BoxFit.scaleDown),
              ),
              SizedBox(
                width: 14,
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text('${widget.storeName}',
              style: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.primaryDark)),
          Row(
            children: [
              Icon(
                Icons.timer,
                color: ColorManager.grey,
                size: AppSize.s20,
              ),
              SizedBox(
                width: 8,
              ),
              Text('${dur}',
                  style: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.primaryDark)),
            ],
          ),
        ],
      ),
    );
  }
}
