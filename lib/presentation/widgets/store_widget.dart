import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/categories_view/categories_getx_controller.dart';

import '../../domain/model/store_delivery_cost.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';

class StoreWidget extends StatefulWidget {
  final String storeName;
  final String storeImageUrl;
  final num storeStars;
  final String workTime;
  final List<StoreDeliveryCost> imageDeliveryUrl;
  final bool isOpen;

  StoreWidget(
      {required this.storeName,
      required this.storeImageUrl,
      required this.storeStars,
      required this.isOpen,
      required this.imageDeliveryUrl,
      required this.workTime});

  @override
  State<StoreWidget> createState() => _StoreWidgetState();
}

class _StoreWidgetState extends State<StoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.storeImageUrl.isEmpty ? Image.asset(
                  ImageAssets.brStore,
                  height: AppSize.s75,
                ) : Image.network(
                  widget.storeImageUrl,
                  height: AppSize.s75,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${widget.storeName}',
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.w600,
                              fontSize: AppSize.s16),
                        ),
                        SizedBox(
                          width: AppSize.s92,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text('1'),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        Text('(100+)')
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.timer_sharp,
                          color: ColorManager.primary,
                        ),
                        SizedBox(
                          width: AppSize.s6,
                        ),
                        Text(
                          '${widget.workTime}',
                          style: TextStyle(
                              color: ColorManager.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: AppSize.s14),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: AppSize.s30,
                          // width: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.imageDeliveryUrl.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Image.network(
                                widget.imageDeliveryUrl[index].methodImage!,
                                height: AppSize.s20,
                                width: AppSize.s20,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorManager.primaryDark),
                          child: Text('deals up to 50 % off',
                              style: TextStyle(
                                  color: Colors.white, fontSize: FontSize.s10)),
                        ),
                        SizedBox(
                          width: AppSize.s6,
                        ),
                        Column(
                          children: [
                            Image.asset(
                              ImageAssets.preOrder,
                              height: AppSize.s20,
                              width: AppSize.s20,
                            ),
                            Text(
                              'pre order',
                              style: TextStyle(
                                  fontSize: FontSize.s10,
                                  color: ColorManager.primary),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
