import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/resources/assets_manager.dart';
import 'package:ghaf_application/presentation/resources/font_manager.dart';

import '../../app/constants.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class CouponsView extends StatefulWidget {
  const CouponsView({Key? key}) : super(key: key);

  @override
  State<CouponsView> createState() => _CouponsViewState();
}

class _CouponsViewState extends State<CouponsView> {
  int index1 = 0;

  @override
  Widget build(BuildContext context) {
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
                    AppLocalizations.of(context)!.vouchers,
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
                child: GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: AppPadding.p4),
                    shrinkWrap: true,
                    itemCount: 10,
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
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r14),
                                  child: Image.asset(
                                    ImageAssets.test,
                                    height: AppSize.s211,
                                    width: AppSize.s154,
                                  ),
                                ),
                                PositionedDirectional(
                                  end: AppSize.s12,
                                  top: AppSize.s12,
                                  child: CircleAvatar(
                                    radius: AppRadius.r14,
                                    backgroundColor: ColorManager.burgundy,
                                    child: Image.asset(
                                      IconsAssets.heart,
                                      height: AppSize.s16,
                                      width: AppSize.s16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'Modern light clothes',
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryDark,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            SizedBox(
                              height: AppSize.s4,
                            ),
                            Container(
                              padding: EdgeInsetsDirectional.only(
                                  start: AppPadding.p22),
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                'Dress modern',
                                style: getRegularStyle(
                                  color: ColorManager.grey,
                                  fontSize: FontSize.s10,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AppSize.s8,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: AppPadding.p22),
                              child: Row(
                                children: [
                                  Text(
                                    '\$212.99',
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
                                  Text(
                                    '5.0',
                                    style: getRegularStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                          ],
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
