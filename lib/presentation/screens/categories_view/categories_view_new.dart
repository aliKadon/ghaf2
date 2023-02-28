import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class CategoriesViewNew extends StatefulWidget {
  @override
  State<CategoriesViewNew> createState() => _CategoriesViewNewState();
}

class _CategoriesViewNewState extends State<CategoriesViewNew> {
  var selected = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.categories_by_store,
                style: getSemiBoldStyle(
                  color: ColorManager.primaryDark,
                  fontSize: FontSize.s18,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSize.s12,
          ),
          Divider(height: 1, color: ColorManager.greyLight),
          SizedBox(
            height: AppSize.s10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.03,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: selected == index
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Row(
                            children: [
                              Text('categories',
                                  style: TextStyle(
                                      color: ColorManager.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize.s14)),
                              SizedBox(
                                width: AppSize.s30,
                              )
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Row(
                            children: [
                              Text('categories'),
                              SizedBox(
                                width: AppSize.s30,
                              )
                            ],
                          ),
                        ),
                );
              },
            ),
          ),
          Divider(thickness: 1,color: ColorManager.greyLight),
        ],
      ),
    );
  }
}
