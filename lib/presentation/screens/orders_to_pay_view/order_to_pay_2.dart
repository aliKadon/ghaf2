import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/order_widget.dart';
import '../../widgets/order_widget2.dart';
import '../cart_view/cart_view_getx_controller.dart';

class OrderToPay2 extends StatefulWidget {
  final String isOrderTrack;

  OrderToPay2(this.isOrderTrack);

  @override
  State<OrderToPay2> createState() => _OrderToPay2State();
}

class _OrderToPay2State extends State<OrderToPay2> {
  var listOrder;
  late final CartViewGetXController _cartViewGetXController =
      Get.put(CartViewGetXController());
  var isLoading = true;

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false)
        .getUnpaidOrder()
        .then((value) => isLoading = false);

    Provider.of<ProductProvider>(context, listen: false)
        .getAllDetailsOrder()
        .then((value) => isLoading = false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var order = Provider.of<ProductProvider>(context).orderAllInformation;

    if (widget.isOrderTrack == 'Pending') {
      listOrder = Provider.of<ProductProvider>(context).orderspending;
    } else if (widget.isOrderTrack == 'Completed') {
      listOrder = Provider.of<ProductProvider>(context).ordersPay;
    } else if (widget.isOrderTrack == 'Delivery') {
      listOrder = Provider.of<ProductProvider>(context).ordersdelivery;
    } else if (widget.isOrderTrack == 'In Progress') {
      listOrder = Provider.of<ProductProvider>(context).ordersinProgress;
    } else if (widget.isOrderTrack == 'orderTrack') {
      listOrder = Provider.of<ProductProvider>(context).orderAllInformation;
    } else {
      listOrder = Provider.of<ProductProvider>(context).orderAllInformation;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _cartViewGetXController.init(
                        context: context,
                      );
                    },
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  widget.isOrderTrack == 'Pending' ? Text(
                    AppLocalizations.of(context)!.pending_order,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ) : widget.isOrderTrack == 'Completed' ? Text(
                    AppLocalizations.of(context)!.completed_order,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ) : widget.isOrderTrack == 'Delivery' ? Text(
                    AppLocalizations.of(context)!.delivery_Orders,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ): widget.isOrderTrack == 'In Progress' ?Text(
                    AppLocalizations.of(context)!.in_Progress_Orders,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ) :Text(
                    AppLocalizations.of(context)!.orders_to_pay,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ) ,
                  Spacer(),
                ],
              ),
              SizedBox(
                height: AppSize.s12,
              ),
              Divider(height: 1, color: ColorManager.greyLight),
              Expanded(
                child: listOrder == null
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.no_order_found,
                        ),
                      )
                    : listOrder.length == 0
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.no_order_found,
                            ),
                          )
                        : ListView.separated(
                            itemCount: listOrder.length,
                            separatorBuilder: (_, index) => Divider(),
                            itemBuilder: (context, index) {
                              print(
                                  '+++++++++++++++++++++++++++++++================');
                              print(listOrder[index]);
                              return widget.isOrderTrack == 'Pending' ||
                                      widget.isOrderTrack == 'Completed' ||
                                      widget.isOrderTrack == 'Delivery' ||
                                      widget.isOrderTrack == 'In Progress' ||
                                      widget.isOrderTrack == 'orderTrack'
                                  ? OrderWidget2(
                                      // order: _ordersToPayViewGetXController
                                      //     .orders[index],
                                      listOrder![index],
                                      widget.isOrderTrack,
                                    )
                                  : OrderWidget(
                                      listOrder![index], widget.isOrderTrack);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
