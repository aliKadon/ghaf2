import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/model/unpaid_order.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class UnpaiadItemsScreen extends StatefulWidget {
  final UnpaidOrder unpaidOrder;

  UnpaiadItemsScreen(this.unpaidOrder);

  @override
  State<UnpaiadItemsScreen> createState() => _UnpaiadItemsScreenState();
}

class _UnpaiadItemsScreenState extends State<UnpaiadItemsScreen> {

  @override
  void initState() {
    Provider.of<ProductProvider>(context,listen: false).getAllDetailsOrder();
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
                    'Your Items',
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
              ListView.builder(
                shrinkWrap: true,
                
                itemCount: widget.unpaidOrder.items!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xff125051),
                      ),
                    ),
                    child: Column(
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Item name : ${widget.unpaidOrder.items![index]['name']}',
                            style: getSemiBoldStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s18,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Quantity ${widget.unpaidOrder.items![index]['quanity']}',
                                style: getSemiBoldStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s18,
                                ),
                              ),
                            ),
                            Spacer(),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Price ${widget.unpaidOrder.items![index]['price']} AED',
                                style: getSemiBoldStyle(
                                  color: ColorManager.primaryDark,
                                  fontSize: FontSize.s18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(Routes.snapsheet, arguments: {
                      'orderId': widget.unpaidOrder.id,
                      'deliveryMethodId': widget.unpaidOrder.deliveryMethod!['id'] ?? '1',
                      'date' : widget.unpaidOrder.desiredDeliveryDate,
                      'address': widget.unpaidOrder.deliveryPoint ?? '',
                      'reedem': false,
                      'paylater': false,
                    });
                    // paymentController.makePayment(context: context,amount: payLater.toString(), currency: 'AED');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (builder) => CheckOutConfirmView()),
                    // );
                  },
                  child: Text(
                    'Pay ${widget.unpaidOrder.totalCostForItems} AED',
                    style: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s18),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}