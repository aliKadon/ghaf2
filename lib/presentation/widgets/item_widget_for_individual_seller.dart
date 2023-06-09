import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/screens/seller/controller/create_link_getx_controller.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class ItemWidgetForIndividualSeller extends StatefulWidget {
  final int index;
  String? image;
  final String name;
  final String idProduct;
  final num price;
  final String isoCurrencySymbol;

  ItemWidgetForIndividualSeller({
    required this.index,
    required this.isoCurrencySymbol,
    required this.price,
    required this.name,
    required this.idProduct,
    this.image,
  });

  @override
  State<ItemWidgetForIndividualSeller> createState() =>
      _ItemWidgetForIndividualSellerState();
}

class _ItemWidgetForIndividualSellerState
    extends State<ItemWidgetForIndividualSeller> {
  //controller
  late final CreateLinkGetxController _createLinkGetxController =
      Get.find<CreateLinkGetxController>();

  var selected = 0;
  num count = 1;
  bool isChecked = false;

  Map<String, dynamic> itemForLink = {
    'prodId': '',
    'Quantity': 1,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.s12),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // color: Colors.red,
            child: Row(
              children: [
                widget.image == null
                    ? Container(
                        height: AppSize.s70,
                        width: AppSize.s60,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ImageAssets.logo2),
                                fit: BoxFit.scaleDown),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      )
                    : Container(
                        height: AppSize.s84,
                        width: AppSize.s84,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.r10),
                          child: Image.network(
                            widget.image!,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                ImageAssets.logo2,
                                fit: BoxFit.scaleDown,
                              );
                            },
                          ),
                        ),
                      ),
                SizedBox(
                  width: AppSize.s22,
                ),
                // Spacer(),
                Expanded(
                  child: Container(
                    // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              color: ColorManager.primaryDark,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s14),
                        ),
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            print('==================check box');
                            print(isChecked);
                            setState(() {
                              isChecked = !isChecked;
                            });
                            if (isChecked) {
                              itemForLink.update(
                                  'prodId', (value) => widget.idProduct);
                              itemForLink.update('Quantity', (value) => count);

                              _createLinkGetxController.itemForLinkList
                                  .add(itemForLink);
                            } else {
                              _createLinkGetxController.itemForLinkList
                                  .remove(itemForLink);
                            }
                            print('==================productId');
                            print(_createLinkGetxController.itemForLinkList);
                          },
                        ),
                        SizedBox(height: AppSize.s20),
                        Text(
                          '${widget.price} ${widget.isoCurrencySymbol}',
                          style: TextStyle(
                              color: ColorManager.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s15),
                        ),
                      ],
                    ),
                  ),
                ),
                // Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: AppSize.s14),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = widget.index;
                              count = count + 1;
                              print(count);

                              // count = widget.productCount;
                            });

                            itemForLink.update('Quantity', (value) => count);
                            // _createLinkGetxController.productCount.add(count);
                            print('==================productCount');
                            print(_createLinkGetxController.itemForLinkList);
                          },
                          child: Icon(
                            Icons.add_circle_outline,
                            color: ColorManager.primary,
                          )),
                      Text(count.toString()),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = widget.index;
                              count--;
                              print(count);
                              itemForLink.update('Quantity', (value) => count);
                              // _createLinkGetxController.productCount.add(count);
                              print('==================productCount');
                              print(_createLinkGetxController.itemForLinkList);
                              // count = widget.productCount;
                            });
                            if (count == 0) {}
                          },
                          child: Icon(
                            Icons.remove_circle_outline,
                            color: ColorManager.primary,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: AppSize.s16,
          // )
        ],
      ),
    );
  }
}
