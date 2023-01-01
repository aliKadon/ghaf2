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

  late String _filterBy;
  String get filterBy1 => _filterBy;

  set filterBy1(String value) {
    _filterBy = value;
    print('=================================HERE');
    print(_filterBy);
    update(['filterBYPrice']);
  }

  // constructor fields.
  final BuildContext context;
  num? minPrice;
  num? maxPrice;
  String? filterBy;
  final void Function({
    num? minPrice,
    num? maxPrice,
    String? filterBy,
  }) onFilter;

  // constructor.
  FilterSheetWidgetGetXController({
    required this.context,
    required this.onFilter,
    this.filterBy,
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
      filterBy: filterBy1,
    );
    filterBy = filterBy1;
    print('====================================HERE1');
    print(filterBy);
  }

  // on clear tapped.
  void onClearTapped() {
    Navigator.pop(context);
    onFilter(
      minPrice: null,
      maxPrice: null,
    );
  }

  String? getFilterBy(String filter) {
    filterBy = filter;
    print('=================================HERE');
    print(filterBy);
    return filterBy;
  }
}
