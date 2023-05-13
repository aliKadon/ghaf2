import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/pay_later/pay_later_product_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';

class PayLaterProductWidget extends StatefulWidget {
  final String name;
  final num price;
  final num stars;
  final int index;
  final String id;
  final String imageUrl;

  PayLaterProductWidget(
      {required this.price,
      required this.name,
      required this.id,
      required this.index,
      required this.stars,
      required this.imageUrl});

  @override
  State<PayLaterProductWidget> createState() => _PayLaterProductWidgetState();
}

class _PayLaterProductWidgetState extends State<PayLaterProductWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PayLaterProductView(index: widget.index,id: widget.id),
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
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      widget.imageUrl == '' ? Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s15),
                          image: DecorationImage(
                            image: AssetImage(ImageAssets.pizza),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ) : Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s15),
                          image: DecorationImage(
                            image: NetworkImage(widget.imageUrl),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.all(AppSize.s8),
                      //   child: Container(
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(100),
                      //           color: Colors.black54),
                      //       padding: EdgeInsets.all(AppSize.s8),
                      //       child: Image.asset(
                      //         IconsAssets.heart,
                      //         height: AppSize.s24,
                      //         width: AppSize.s24,
                      //       )),
                      // ),
                    ],
                  ),
                  SizedBox(
                    width: AppSize.s14,
                  )
                ],
              ),
              Container(
                // color: Colors.red,
                width: AppSize.s222,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.name,
                        style: TextStyle(
                            fontSize: FontSize.s16,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primaryDark)),
                  ],
                ),
              ),
              Container(
                // color: Colors.green,
                width: AppSize.s222,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${widget.price} ${AppLocalizations.of(context)!.aed}',
                        style: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primaryDark)),
                    SizedBox(
                      width: AppSize.s28,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: AppSize.s8,
                    ),
                    Text('${widget.stars}.0',
                        style: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.primaryDark)),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
