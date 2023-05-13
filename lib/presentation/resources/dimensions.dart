
import 'package:flutter/material.dart';

class AppDimensions {
  



  // static double width10 = scrnWidth / 2;

  static double getWidth(double percVal,context) {
     double scrnWidth = MediaQuery.of(context).size.width;
    if (scrnWidth != 0) {
      double val =scrnWidth * percVal;
      return val.round().toDouble();
    } else {
      return 0;
    }
  }
  static double getHeight(double percVal,context) {
    double scrnHeight = MediaQuery.of(context).size.height;
    if (scrnHeight != 0) {
      double val =scrnHeight * percVal;
      return val.round().toDouble();
    } else {
      return 0;
    }
  }
  
}
