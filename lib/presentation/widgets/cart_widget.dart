import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';


class CartWidget extends StatefulWidget {

  final int index;
  CartWidget({required this.index});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  var selected = 0;

  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Container(
                height: AppSize.s110,
                width: AppSize.s110,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        ImageAssets.pizza,
                      ),
                    ),
                    borderRadius:
                    BorderRadius.all(Radius.circular(20))),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pizza meal for two',
                    style: TextStyle(
                        color: ColorManager.primaryDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  Text(
                    'item 2',
                    style: TextStyle(
                        color: ColorManager.greyLight,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '99 AED',
                    style: TextStyle(
                        color: ColorManager.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {

                          setState(() {
                            selected = widget.index;
                            count++;
                          });

                        },
                        child: Icon(
                          Icons.add_circle_outline,
                          color: ColorManager.primary,
                        )
                    ),
                    Text(count.toString()),
                    GestureDetector(
                        onTap: () {

                          setState(() {
                            selected = widget.index;
                            count--;
                          });
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
        SizedBox(
          height: AppSize.s16,
        )
      ],
    );
  }
}