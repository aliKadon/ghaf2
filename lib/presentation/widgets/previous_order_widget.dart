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
      padding: EdgeInsets.all(AppSize.s8),
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
                  borderRadius: BorderRadius.circular(AppSize.s10),
                ),
                child: Image.network(widget.storeImage,
                    errorBuilder: (context, error, stackTrace) {
                  return Image.asset(ImageAssets.logo2);
                }, fit: BoxFit.cover),
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
            width: AppSizeWidth.s110,
            child: Text('${widget.storeName}',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.primaryDark)),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer,
                color: ColorManager.grey,
                size: AppSize.s20,
              ),
              SizedBox(
                width: AppSize.s8,
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
