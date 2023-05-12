import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/resources/color_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'package:ghaf_application/presentation/screens/home_view/filter_screen.dart';
import 'package:ghaf_application/presentation/screens/home_view/sheets/filter_sheet_widget_getx_controller.dart';
import 'package:ghaf_application/presentation/widgets/app_text_field.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';

class FilterSheetWidget extends StatefulWidget {
  const FilterSheetWidget({Key? key}) : super(key: key);

  @override
  State<FilterSheetWidget> createState() => _FilterSheetWidgetState();
}

class _FilterSheetWidgetState extends State<FilterSheetWidget> {
  // controller.
  // late final FilterSheetWidgetGetXController _filterSheetWidgetGetXController =
  //     Get.find<FilterSheetWidgetGetXController>();

  late TextEditingController _minPriceController = TextEditingController();
  late TextEditingController _maxPriceController = TextEditingController();

  //new
  var color1 = Colors.white;
  var colorText1 = Color(0xff125051);
  var color2 = Colors.white;
  var colorText2 = Color(0xff125051);
  var onPressDiscount = 'productDiscount.discount';

  // dispose.
  @override
  void dispose() {
    Get.delete<FilterSheetWidgetGetXController>();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  var type;
  var search = '';
  var did = '';

  List<String> flitterType = [
    'Price',
    'New arrival',
    'Free delivery',
    'Pick up order',
    'Deliver to car window',
    'Fast Delivery',
    'recommended'
  ];

  var isSelected = false;
  var selected = -1;

  var stars = '';

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<ProductProvider>(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.filter,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.sort_by,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverDynamicHeightGridView(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        // shrinkWrap: true,
                        itemCount: flitterType.length,

                        builder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = index;

                                  if (flitterType[index] == 'recommended') {
                                    stars = 'stars';
                                    type = 'Name';
                                    did = '';
                                  } else if (flitterType[index] == 'New arrival') {
                                    stars = 'Name';
                                    type = 'Name';
                                    did = '';
                                  } else if (flitterType[index] ==
                                      'Pick up order') {
                                    type = 'Name';
                                    stars = 'Name';
                                    did = '7cc577e9-7d5c-4a12-0149-08dafd69d37b';
                                  } else if (flitterType[index] == 'Price') {
                                    search = '';
                                    type = null;
                                    did = '';
                                  } else if (flitterType[index] ==
                                      'Deliver to car window') {
                                    type = 'Name';
                                    stars = 'Name';
                                    did = 'bbcb7d68-8dc4-46ae-014a-08dafd69d37b';
                                  } else if (flitterType[index] ==
                                      'Fast Delivery') {
                                    type = 'Name';
                                    stars = 'Name';
                                    did = 'bc4f3b43-df7b-48ca-014c-08dafd69d37b';
                                  } else if (flitterType[index] ==
                                      'Free delivery') {
                                    type = flitterType[index];
                                  }
                                  print(selected);
                                });
                              },
                              child: selected == index
                                  ? containerFilterSelected(flitterType[index])
                                  : containerFilter(flitterType[index]));
                        },
                      )
                    ],
                  )),
              // Row(
              //   children: [
              //     Spacer(),
              //     GetBuilder<FilterSheetWidgetGetXController>(
              //       id: 'filterBYDiscount',
              //       builder:(controller) => GestureDetector(
              //         onTap: () {
              //           onPressDiscount = 'productDiscount.discount';
              //           controller.filterBy1 = onPressDiscount;
              //           setState(() {
              //             if (color1 == Color(0xff125051)) {
              //               color1 = Colors.white;
              //               color2 = Color(0xff125051);
              //               colorText2 = Colors.white;
              //               colorText1 = Color(0xff125051);
              //               onPressDiscount = '';
              //             }else if (color1 == Colors.white) {
              //               color1 = Color(0xff125051);
              //               colorText1 = Colors.white;
              //               color2 = Colors.white;
              //               colorText2 = Color(0xff125051);
              //               onPressDiscount = 'productDiscount.discount';
              //             }
              //           });
              //
              //         },
              //         child: Container(
              //           padding: EdgeInsets.symmetric(
              //               vertical: 16.h, horizontal: 16.w),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(12.r),
              //             color: color1,
              //             border: Border.all(
              //               color: Color(0xff125051),
              //             ),
              //           ),
              //           child: Center(
              //             child: Text(
              //               AppLocalizations.of(context)!.discount,
              //               style: TextStyle(
              //                 color: colorText1,
              //                 fontSize: 16.sp,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //
              //     Spacer(),
              //
              //     GetBuilder<FilterSheetWidgetGetXController>(
              //       id: 'filterBYPrice',
              //       builder:(controller) => GestureDetector(
              //         onTap: () {
              //           onPressDiscount = 'price';
              //           controller.filterBy1 = onPressDiscount;
              //           setState(() {
              //             if (color2 == Color(0xff125051)) {
              //               color2 = Colors.white;
              //               colorText2 = Color(0xff125051);
              //               color1 = Color(0xff125051);
              //               colorText1 = Colors.white;
              //               onPressDiscount = '';
              //             }else if (color2 == Colors.white) {
              //               color2 = Color(0xff125051);
              //               colorText2 = Colors.white;
              //               onPressDiscount = 'price';
              //               color1 = Colors.white;
              //               colorText1 = Color(0xff125051);
              //             }
              //           });
              //
              //         },
              //         child: Container(
              //           padding: EdgeInsets.symmetric(
              //               vertical: 16.h, horizontal: 16.w),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(12.r),
              //             color: color2,
              //             border: Border.all(
              //               color: Color(0xff125051),
              //             ),
              //           ),
              //           child: Center(
              //             child: Text(
              //               AppLocalizations.of(context)!.price,
              //               style: TextStyle(
              //                 color: colorText2,
              //                 fontSize: 16.sp,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Spacer(),
              //   ],
              // ),

              Container(
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.range,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: AppTextField(
                      hint: AppLocalizations.of(context)!.min_price,
                      textController: _minPriceController,
                    )),
                    Expanded(
                        child: AppTextField(
                      hint: AppLocalizations.of(context)!.max_price,
                      textController: _maxPriceController,
                    ))
                  ],
                ),
              ),
              // GetBuilder<FilterSheetWidgetGetXController>(
              //   id: 'price',
              //   builder: (controller) => RangeSlider(
              //     min: 0,
              //     max: 500,
              //     activeColor: Color(0xff125051),
              //     values: controller.rangeValues,
              //     onChanged: _filterSheetWidgetGetXController.onSliderChanged,
              //     labels: RangeLabels(
              //       controller.rangeValues.start.toInt().toString(),
              //       controller.rangeValues.end.toInt().toString(),
              //     ),
              //     divisions: 100,
              //   ),
              // ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      // onTap: _filterSheetWidgetGetXController.onApplyTapped,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FilterScreen(
                              did: did,
                              search: search,
                              stars: stars,
                              minPrice: _minPriceController.text.isEmpty
                                  ? 0
                                  : num.parse(_minPriceController.text),
                              maxPrice: _maxPriceController.text.isEmpty
                                  ? 1000
                                  : num.parse(_maxPriceController.text),
                              filterBy: type),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Color(0xff125051),
                          border: Border.all(
                            color: Color(0xff125051),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.apply_filter,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      // onTap: _filterSheetWidgetGetXController.onClearTapped,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Color(0xff125051),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.clear,
                            style: TextStyle(
                              color: Color(0xff125051),
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget containerFilter(String filterType) {
    return Container(
      decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorManager.primaryDark)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Flexible(
          child: Center(
            child: Text(filterType,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    color: ColorManager.primaryDark,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget containerFilterSelected(String filterType) {
    return Container(
      decoration: BoxDecoration(
          color: ColorManager.primaryDark,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorManager.primaryDark)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Flexible(
          child: Center(
            child: Text(filterType,
                style: TextStyle(
                    color: ColorManager.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
