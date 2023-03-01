import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ghaf_application/presentation/screens/my_wallet/transaction.dart';

import '../../resources/assets_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppSize.s32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: EdgeInsets.all(AppSize.s6),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    IconsAssets.arrow,
                    height: AppSize.s18,
                    width: AppSize.s10,
                    color: ColorManager.primaryDark,
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Transaction',
                style: getSemiBoldStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s18,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: AppSize.s16,
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: AppSize.s222,
                color: ColorManager.grey.withOpacity(0.2),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available credit',
                      style: getRegularStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    Text(
                      'AED 0.00',
                      style: getSemiBoldStyle(
                        color: ColorManager.primaryDark,
                        fontSize: FontSize.s18,
                      ),
                    ),
SizedBox(height: AppSize.s28,),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap:(){

                            },
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(IconsAssets.top_up,
                                    height: AppSize.s55,width: AppSize.s55,),
                                ),
                                SizedBox(height: AppSize.s4,),
                                Text(
                                  'Top up',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){},
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(IconsAssets.add_credit,
                                    height: AppSize.s55,width: AppSize.s55,),
                                ),SizedBox(height: AppSize.s4,),
                                Text(
                                  'Add Credit',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){},
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(IconsAssets.manage,
                                    height: AppSize.s55,width: AppSize.s55,),
                                ),SizedBox(height: AppSize.s4,),
                                Text(
                                  'Manage',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.primaryDark,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
          SizedBox(
            height: AppSize.s36,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  'October 2022',
                  style: getRegularStyle(
                    color: ColorManager.grey,
                    fontSize: FontSize.s18,
                  ),
                ),

              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              itemCount: 100,
              shrinkWrap: true,

              physics: BouncingScrollPhysics(),
              itemBuilder:(context,data) {
                return Column(
                  children: [
                    Text('data'),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
