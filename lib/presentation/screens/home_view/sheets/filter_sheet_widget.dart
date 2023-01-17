import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/home_view/sheets/filter_sheet_widget_getx_controller.dart';
import 'package:ghaf_application/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FilterSheetWidget extends StatefulWidget {
  const FilterSheetWidget({Key? key}) : super(key: key);

  @override
  State<FilterSheetWidget> createState() => _FilterSheetWidgetState();
}

class _FilterSheetWidgetState extends State<FilterSheetWidget> {
  // controller.
  late final FilterSheetWidgetGetXController _filterSheetWidgetGetXController =
      Get.find<FilterSheetWidgetGetXController>();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<ProductProvider>(context);
    return Container(
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
             Row(
               children: [
                 Spacer(),
                 GetBuilder<FilterSheetWidgetGetXController>(
                   id: 'filterBYDiscount',
                   builder:(controller) => GestureDetector(
                     onTap: () {
                       onPressDiscount = 'productDiscount.discount';
                       controller.filterBy1 = onPressDiscount;
                       setState(() {
                         if (color1 == Color(0xff125051)) {
                           color1 = Colors.white;
                           color2 = Color(0xff125051);
                           colorText2 = Colors.white;
                           colorText1 = Color(0xff125051);
                           onPressDiscount = '';
                         }else if (color1 == Colors.white) {
                           color1 = Color(0xff125051);
                           colorText1 = Colors.white;
                           color2 = Colors.white;
                           colorText2 = Color(0xff125051);
                           onPressDiscount = 'productDiscount.discount';
                         }
                       });

                     },
                     child: Container(
                       padding: EdgeInsets.symmetric(
                           vertical: 16.h, horizontal: 16.w),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(12.r),
                         color: color1,
                         border: Border.all(
                           color: Color(0xff125051),
                         ),
                       ),
                       child: Center(
                         child: Text(
                           AppLocalizations.of(context)!.discount,
                           style: TextStyle(
                             color: colorText1,
                             fontSize: 16.sp,
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),

                 Spacer(),

                 GetBuilder<FilterSheetWidgetGetXController>(
                   id: 'filterBYPrice',
                   builder:(controller) => GestureDetector(
                     onTap: () {
                       onPressDiscount = 'price';
                       controller.filterBy1 = onPressDiscount;
                       setState(() {
                         if (color2 == Color(0xff125051)) {
                           color2 = Colors.white;
                           colorText2 = Color(0xff125051);
                           color1 = Color(0xff125051);
                           colorText1 = Colors.white;
                           onPressDiscount = '';
                         }else if (color2 == Colors.white) {
                           color2 = Color(0xff125051);
                           colorText2 = Colors.white;
                           onPressDiscount = 'price';
                           color1 = Colors.white;
                           colorText1 = Color(0xff125051);
                         }
                       });

                     },
                     child: Container(
                       padding: EdgeInsets.symmetric(
                           vertical: 16.h, horizontal: 16.w),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(12.r),
                         color: color2,
                         border: Border.all(
                           color: Color(0xff125051),
                         ),
                       ),
                       child: Center(
                         child: Text(
                           AppLocalizations.of(context)!.price,
                           style: TextStyle(
                             color: colorText2,
                             fontSize: 16.sp,
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
                 Spacer(),
               ],
             ),


            Row(
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
            SizedBox(
              height: 5.h,
            ),
            GetBuilder<FilterSheetWidgetGetXController>(
              id: 'price',
              builder: (controller) => RangeSlider(
                min: 0,
                max: 500,
                activeColor: Color(0xff125051),
                values: controller.rangeValues,
                onChanged: _filterSheetWidgetGetXController.onSliderChanged,
                labels: RangeLabels(
                  controller.rangeValues.start.toInt().toString(),
                  controller.rangeValues.end.toInt().toString(),
                ),
                divisions: 100,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: _filterSheetWidgetGetXController.onApplyTapped,
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
                    onTap: _filterSheetWidgetGetXController.onClearTapped,
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
    );
  }
}
