import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/subscribe_view/subscribe_view_getx_controller.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../../../app/utils/app_shared_data.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math; // import this

class PaymentMethodView extends StatefulWidget {
  // const PaymentMethodView({Key? key}) : super(key: key);

  // Map<String,dynamic> cardInfo;
  // PaymentMethodView(this.cardInfo);

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  SubscribeViewGetXController _subscribeViewGetXController =
  Get.find<SubscribeViewGetXController>();

  // dispose.
  @override
  void dispose() {
    Get.delete<SubscribeViewGetXController>();
    super.dispose();
  }

  @override
  void initState() {
    Provider.of<ProductProvider>(context,listen: false).getPlane();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var planId = Provider.of<ProductProvider>(context).plane;
    var result = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic> ?? {'h'};
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.038,
                        width: MediaQuery.of(context).size.width * 0.08,
                        child: Image.asset(
                          IconsAssets.arrow,
                          height: AppSize.s18,
                          width: AppSize.s10,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.payment_method,
                      style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s110
                ,
              ),
              SizedBox(
                height: AppSize.s85,
              ),
              Image.asset('assets/images/welcome.png',height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity ,fit: BoxFit.cover,),
              SizedBox(
                height: AppSize.s85,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                ),
                width: double.infinity,
                height: AppSize.s55,
                child: ElevatedButton(
                  onPressed: () {
                    // AppSharedData.currentUser!.ghafGold ?? false
                    //     ? _subscribeViewGetXController.cancelSubscription()
                    //     : _subscribeViewGetXController.subscribeAsGhafGolden(result,planId[0].id);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.done,
                    style: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s18),
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
    );
  }

  Padding aboutApp(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Row(
        children: [
          Text(
            title,
            style: getRegularStyle(
              color: ColorManager.grey,
              fontSize: FontSize.s16,
            ),
          ),
          Spacer(),
          Transform(
            transform: Matrix4.rotationY(math.pi),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.038,
              width: MediaQuery.of(context).size.width * 0.08,
              child: Image.asset(
                IconsAssets.arrow,
                height: AppSize.s18,
                width: AppSize.s10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
