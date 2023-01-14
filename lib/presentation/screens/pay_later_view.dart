import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../app/constants.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class PayLaterView extends StatefulWidget {
  const PayLaterView({Key? key}) : super(key: key);

  @override
  State<PayLaterView> createState() => _PayLaterViewState();
}

class _PayLaterViewState extends State<PayLaterView> {
  int index1 = 0;

  var isLoading = true;

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false)
        .getProducts()
        .then((value) => isLoading = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var unpaid = Provider.of<ProductProvider>(context).listPayLater1;
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
                    AppLocalizations.of(context)!.pay_later,
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
                        child: Container(
                          width: 20.h,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding: EdgeInsets.symmetric(vertical: AppPadding.p4),
                        shrinkWrap: true,
                        itemCount: unpaid.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Constants.crossAxisCount,
                          mainAxisExtent: Constants.mainAxisExtent,
                          mainAxisSpacing: Constants.mainAxisSpacing,
                        ),
                        itemBuilder: (context, index) {
                          index1 = index;
                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (builder) => ProductView()),
                              // );
                              // Navigator.of(context).pushNamed(Routes.unpaidItemScreen,arguments: unpaid[index]);
                            },
                            child: Card(
                              elevation: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(AppRadius.r14),
                                        child: Image.asset(
                                          'assets/images/product_image.png',
                                          fit: BoxFit.cover,
                                          height: AppSize.s211,
                                          width: AppSize.s154,
                                        ),
                                      ),
                                      // PositionedDirectional(
                                      //   end: AppSize.s12,
                                      //   top: AppSize.s12,
                                      //   child: CircleAvatar(
                                      //     radius: AppRadius.r14,
                                      //     backgroundColor: ColorManager.burgundy,
                                      //     child: Image.asset(
                                      //       IconsAssets.heart,
                                      //       height: AppSize.s16,
                                      //       width: AppSize.s16,
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  Text(
                                    unpaid[index].name!,
                                    style: getSemiBoldStyle(
                                      color: ColorManager.primaryDark,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppSize.s4,
                                  ),
                                  // Container(
                                  //   padding: EdgeInsetsDirectional.only(
                                  //       start: AppPadding.p22),
                                  //   alignment: AlignmentDirectional.topStart,
                                  //   child: FittedBox(
                                  //     fit: BoxFit.scaleDown,
                                  //     child: Text(
                                  //       'You have ${unpaid.length} item unpaid!',
                                  //       style: getRegularStyle(
                                  //         color: ColorManager.grey,
                                  //         fontSize: FontSize.s10,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: AppSize.s8,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: AppPadding.p22),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: AppSize.s16,
                                        ),
                                        Text(
                                          '${unpaid[index].price} ${AppLocalizations.of(context)!.aed}',
                                          style: getSemiBoldStyle(
                                            color: ColorManager.primaryDark,
                                          ),
                                        ),
                                        Spacer(),
                                        Image.asset(
                                          IconsAssets.start,
                                          height: AppSize.s14,
                                          width: AppSize.s15,
                                        ),
                                        SizedBox(
                                          width: AppSize.s8,
                                        ),
                                        // Text(
                                        //   '5.0',
                                        //   style: getRegularStyle(
                                        //     color: ColorManager.black,
                                        //     fontSize: FontSize.s12,
                                        //   ),
                                        // ),
                                        Spacer()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get isEven => index1 % 2 == 0;
}
