import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/order_widget.dart';
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
    } else if (widget.isOrderTrack == 'unPay') {
      listOrder = Provider.of<ProductProvider>(context).ordersUnPay;
    } else if (widget.isOrderTrack == 'orderTrack') {
      listOrder = Provider.of<ProductProvider>(context).orderAllInformation;
    }else {
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
        } ,
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Orders To Pay',
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: AppSize.s12,
              ),
              Divider(height: 1, color: ColorManager.greyLight),
              Expanded(
                child:  listOrder == null
                        ? Center(
                            child: Text(
                              'No orders found',
                            ),
                          )
                        : listOrder.length == 0
                            ? Center(
                                child: Text(
                                  'No orders found',
                                ),
                              )
                            : ListView.separated(
                                itemCount: listOrder.length,
                                separatorBuilder: (_, index) => Divider(),
                                itemBuilder: (context, index) {
                                  print(
                                      '+++++++++++++++++++++++++++++++================');
                                  print(listOrder[index]);
                                  return OrderWidget(
                                    // order: _ordersToPayViewGetXController
                                    //     .orders[index],
                                    listOrder![index],
                                    widget.isOrderTrack,
                                  );
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
