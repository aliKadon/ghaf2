import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaf_application/app/utils/helpers.dart';

class ProductViewGetXController extends GetxController with Helpers {
  // vars.
  late BuildContext context;

  // init.
  void init({
    required BuildContext context,
  }) {
    this.context = context;
  }
}
