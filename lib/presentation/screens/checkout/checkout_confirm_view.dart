import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/screens/checkout/check_out_getx_controller.dart';
import 'package:ghaf_application/presentation/screens/checkout/order_tracking_screen.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class CheckOutConfirmView extends StatefulWidget {
  // const CheckOutConfirmView({Key? key}) : super(key: key);

  final String orderId;

  CheckOutConfirmView({required this.orderId});

  @override
  State<CheckOutConfirmView> createState() => _CheckOutConfirmViewState();
}

class _CheckOutConfirmViewState extends State<CheckOutConfirmView> {
  //controller
  late final CheckOutGetxController _checkOutGetxController =
      Get.find<CheckOutGetxController>();

  var isLoading = true;

  @override
  void initState() {
    _checkOutGetxController.getOrderById(
        context: context, orderId: widget.orderId);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // Provider.of<ProductProvider>(context)
    //     .getOrderById(widget.orderId).then((value) => isLoading = false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var order = Provider.of<ProductProvider>(context, listen: false).orderById;
    // print('============================orderByID');
    // print(order);
    return GetBuilder<CheckOutGetxController>(
      builder: (controller) => Scaffold(
        body: controller.isLoadingOrderById
            ? Center(
                child: Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              )
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // GestureDetector(
                            //   // onTap: () => Navigator.pop(context),
                            //   child: Image.asset(
                            //     IconsAssets.arrow,
                            //     height: AppSize.s18,
                            //     width: AppSize.s10,
                            //   ),
                            // ),
                            Spacer(),
                            Text(
                              AppLocalizations.of(context)!.checkout,
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
                        SizedBox(
                          height: AppSize.s65,
                        ),
                        Image.asset(
                          ImageAssets.checkout,
                          height: AppSize.s263,
                          width: AppSize.s222,
                        ),
                        Container(
                          // width: double.infinity,
                          // padding: EdgeInsets.only(left: 50),
                          child: Text(
                            AppLocalizations.of(context)!.your_order_placed,
                            style: getSemiBoldStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s20,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.placed_successfully,
                          style: getSemiBoldStyle(
                            color: ColorManager.primaryDark,
                            fontSize: FontSize.s20,
                          ),
                        ),
                        SizedBox(
                          height: AppSize.s18,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorManager.greyLight),
                          padding: EdgeInsets.all(12),
                          child: Text(
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            AppLocalizations.of(context)!.payment_has_been_made,
                            style: getSemiBoldStyle(
                              color: ColorManager.primaryDark,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppSize.s35,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: AppMargin.m16,
                          ),
                          width: double.infinity,
                          height: AppSize.s55,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OrderTrackingScreen(
                                    orderId: widget.orderId,
                                    source: _checkOutGetxController
                                        .order!.deliveryPoint ?? _checkOutGetxController
                                        .order!.branch!.branchAddress!,
                                    destination: _checkOutGetxController
                                        .order!.branch!.branchAddress!),
                              ));
                              print(
                                  '=================================checkout confirm orderInfo');
                            },
                            child: Text(
                              AppLocalizations.of(context)!.order_tracking,
                              style: getSemiBoldStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppSize.s22,
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed(Routes.mainRoute),
                          child: Text(
                            AppLocalizations.of(context)!.back_to_home,
                            style: getSemiBoldStyle(
                              color: ColorManager.grey,
                              fontSize: FontSize.s20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppSize.s22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void _customDialogProgress() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: AppSize.s214,
              width: AppSize.s258,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s28,
                    ),
                    Text(
                      AppLocalizations.of(context)!.rewarding_progress,
                      style: getMediumStyle(
                          color: ColorManager.primaryDark,
                          fontSize: FontSize.s20),
                    ),
                    SizedBox(
                      height: AppSize.s40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p12,
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        AppLocalizations.of(context)!
                            .you_have_completed_10_orders,
                        style: getMediumStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s12),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s24,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName(Routes.mainRoute));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p55,
                          vertical: AppPadding.p8,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryDark,
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.close,
                          style: getMediumStyle(color: ColorManager.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s18,
                    ),
                  ]),
            ),
          );
        });
  }
}
