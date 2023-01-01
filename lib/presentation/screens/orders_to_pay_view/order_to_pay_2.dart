import 'package:flutter/material.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/order_widget.dart';

class OrderToPay2 extends StatefulWidget {

  @override
  State<OrderToPay2> createState() => _OrderToPay2State();
}

class _OrderToPay2State extends State<OrderToPay2> {

  var isLoading = true;

  @override
  void initState() {
    Provider.of<ProductProvider>(context,listen: false).getAllDetailsOrder().then((value) => isLoading = false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var order = Provider.of<ProductProvider>(context).orderAllInformation;
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
                    onTap: () => Navigator.pop(context),
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
                child: isLoading
                      ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  )
                      : order.isEmpty
                      ? Center(
                    child: Text(
                      'No orders found',
                    ),
                  )
                      : ListView.separated(
                    itemCount: order.length,
                    separatorBuilder: (_, index) => Divider(),
                    itemBuilder: (context, index) {
                      print('+++++++++++++++++++++++++++++++================');
                      print(order[index]);
                      return OrderWidget(
                        // order: _ordersToPayViewGetXController
                        //     .orders[index],
                        order: order[index],
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