import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/screens/orders_to_pay_view/orders_to_pay_view_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/order_widget.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class OrdersToPayView extends StatefulWidget {
  const OrdersToPayView({Key? key}) : super(key: key);

  @override
  State<OrdersToPayView> createState() => _OrdersToPayViewState();
}

class _OrdersToPayViewState extends State<OrdersToPayView> {
  // controller.
  late final OrdersToPayViewGetXController _ordersToPayViewGetXController =
      Get.find<OrdersToPayViewGetXController>();


  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<ProductProvider>(context,listen: false).getOrders();
    super.didChangeDependencies();
  }
  // dispose.
  @override
  void dispose() {
    Get.delete<OrdersToPayViewGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context).orders;
    // print('++++++++++++++++++++++++++++++++++');
    // print(provider);
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
                    AppLocalizations.of(context)!.orders_to_pay,
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
                child: GetBuilder<OrdersToPayViewGetXController>(
                  id: 'isOrdersLoading',
                  builder: (controller) => controller.isOrdersLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        )
                      : _ordersToPayViewGetXController.orders.isEmpty
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!.no_order_found,
                              ),
                            ): Container(),
                          // : ListView.separated(
                          //     itemCount: controller.orders.length,
                          //     separatorBuilder: (_, index) => Divider(),
                          //     itemBuilder: (context, index) {
                          //       print('+++++++++++++++++++++++++++++++================');
                          //       // print(provider[index]);
                          //       // return OrderWidget(
                          //       //   order: _ordersToPayViewGetXController
                          //       //       .orders[index],
                          //       //   provider[index],
                          //       // );
                          //
                          //     },
                          //   ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
