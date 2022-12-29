import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/presentation/screens/home_view/sheets/filter_sheet_widget_getx_controller.dart';

class FilterSheetWidget extends StatefulWidget {
  const FilterSheetWidget({Key? key}) : super(key: key);

  @override
  State<FilterSheetWidget> createState() => _FilterSheetWidgetState();
}

class _FilterSheetWidgetState extends State<FilterSheetWidget> {
  // controller.
  late final FilterSheetWidgetGetXController _filterSheetWidgetGetXController =
      Get.find<FilterSheetWidgetGetXController>();

  // dispose.
  @override
  void dispose() {
    Get.delete<FilterSheetWidgetGetXController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  'Filter',
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
                  'Price Range',
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
                          'Apply Filter',
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
                          'Clear',
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
