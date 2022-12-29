import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';

class FilterSheetWidgetGetXController extends GetxController with Helpers {
  // notifiable.
  late RangeValues _rangeValues =
      RangeValues(minPrice?.toDouble() ?? 0, maxPrice?.toDouble() ?? 500);

  RangeValues get rangeValues => _rangeValues;

  set rangeValues(RangeValues value) {
    _rangeValues = value;
    update(['price']);
  }

  // constructor fields.
  final BuildContext context;
  num? minPrice;
  num? maxPrice;
  final void Function({
    num? minPrice,
    num? maxPrice,
  }) onFilter;

  // constructor.
  FilterSheetWidgetGetXController({
    required this.context,
    required this.onFilter,
    this.minPrice,
    this.maxPrice,
  });

  // on slider changed.
  void onSliderChanged(RangeValues rangeValues) {
    this.rangeValues = rangeValues;
  }

  // on apply tapped.
  void onApplyTapped() {
    Navigator.pop(context);
    onFilter(
      minPrice: rangeValues.start.toInt(),
      maxPrice: rangeValues.end.toInt(),
    );
  }

  // on clear tapped.
  void onClearTapped() {
    Navigator.pop(context);
    onFilter(
      minPrice: null,
      maxPrice: null,
    );
  }
}
