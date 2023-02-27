import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/store_view/store_view.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class StoreByCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      IconsAssets.arrow,
                      height: AppSize.s18,
                      width: AppSize.s10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.all_stores,
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryDark,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Divider(
              color: ColorManager.greyLight,
              thickness: 1,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StoreView(),
                    ));
                  },
                  child: Column(
                    children: [
                      Container(
                        color: ColorManager.greyLight,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Image.asset(
                                ImageAssets.brIcon,
                                height: 80,
                                width: 80,
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Basking Robins',
                                        style: TextStyle(
                                            color: ColorManager.primaryDark,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.22,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer,
                                            color: ColorManager.primary,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '12 min',
                                            style: TextStyle(
                                                color: ColorManager.grey,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Ice cream',
                                        style: TextStyle(
                                            color: ColorManager.grey,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.22,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '4.0',
                                        style: TextStyle(
                                            color: ColorManager.primaryDark,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '(100+)',
                                        style: TextStyle(
                                            color: ColorManager.grey,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 40,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 4,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Image.asset(
                                              ImageAssets.carDelivery,
                                              height: 20,
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text('10 AED'),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  Text(
                                    'open - closed at 10 am',
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
