import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/presentation/screens/rewards/rewards_getx_controller.dart';

import '../../../app/preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class RedeemHistoryScreen extends StatefulWidget {
  @override
  State<RedeemHistoryScreen> createState() => _RedeemHistoryScreenState();
}

class _RedeemHistoryScreenState extends State<RedeemHistoryScreen> {
  //controller
  late final RewardsGetxController _rewardsGetxController =
      Get.find<RewardsGetxController>();

  @override
  void initState() {
    // TODO: implement initState
    // _rewardsGetxController.getRedeemHistory(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // _rewardsGetxController.isLoadingHistory
          //     ? Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :
          SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(AppSize.s12),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // allRedeemPoint = 0;
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.038,
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Image.asset(
                        SharedPrefController().lang1 == 'ar' ?IconsAssets.arrow2 : IconsAssets.arrow,
                        height: AppSize.s18,
                        width: AppSize.s10,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.redeem_history,
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
              // SizedBox(
              //   height: AppSize.s30,
              // ),
              GetBuilder<RewardsGetxController>(
                builder: (controller) => controller
                            .redeemHistory!.list!.length ==
                        0
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: Center(
                          child: Text(
                              AppLocalizations.of(context)!.no_items_found,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize.s16,
                                  color: ColorManager.primary)),
                        ))
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.redeemHistory!.list!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(AppSize.s8),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(AppSize.s8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorManager.greyLight,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      controller.redeemHistory!.list![index]
                                                  .storeLogo ==
                                              null
                                          ? Image.asset(ImageAssets.brStore,
                                              height: AppSize.s82)
                                          : Image.network(
                                              controller.redeemHistory!
                                                  .list![index].storeLogo!,
                                              height: AppSize.s82,
                                            ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Text(
                                              controller.redeemHistory!
                                                  .list![index].storeName!,
                                              style: TextStyle(
                                                  color:
                                                      ColorManager.primaryDark,
                                                  fontSize: FontSize.s16,
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                              controller.redeemHistory!
                                                  .list![index].paymentDate!
                                                  .substring(0, 10),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: ColorManager.greyLight,
                                                  fontSize: FontSize.s16)),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                          '${controller.redeemHistory!.list![index].balance} ${AppLocalizations.of(context)!.point}',
                                          style: TextStyle(
                                              fontSize: FontSize.s16,
                                              color: ColorManager.primary,
                                              fontWeight: FontWeight.w600)),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                // SizedBox(height: AppSize.s30,),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(
                height: AppSize.s30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
