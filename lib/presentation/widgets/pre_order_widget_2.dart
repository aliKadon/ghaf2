import 'package:flutter/material.dart';

import '../../app/preferences/shared_pref_controller.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';
import '../screens/orders/schedual_order_orders.dart';

class PreOrderWidget2 extends StatefulWidget {

  final String storeName;
  final String image;

  PreOrderWidget2({required this.storeName, required this.image,});

  @override
  State<PreOrderWidget2> createState() => _PreOrderWidget2State();
}

class _PreOrderWidget2State extends State<PreOrderWidget2> {

  var language = SharedPrefController().lang1;

  @override
  void initState() {
    // TODO: implement initState
    print('============================PreOrderWidget2');
    print(widget.storeName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SchedualOrderOrders(branchName: widget.storeName),
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(AppSize.s8),
        child: Container(
          child: Row(
            children: [
              Image.network(
                widget.image,
                height: AppSize.s65,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    ImageAssets.albaik,
                    height: AppSize.s85,
                  );
                },
              ),
              SizedBox(
                width: AppSize.s30,
              ),
              Text(
                '${widget.storeName}',
                style: TextStyle(
                    color: ColorManager.primaryDark,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              language == 'en'
                  ? Image.asset(
                SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                height: AppSize.s30,
                color: ColorManager.primary,
              )
                  : Image.asset(
                SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                height: AppSize.s30,
                color: ColorManager.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}