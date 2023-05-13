import 'package:flutter/material.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double? fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize ?? FontSize.s14,
      fontFamily: FontConstants.fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// regular style
TextStyle getRegularStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

// medium style
TextStyle getMediumStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// bold style
TextStyle getSemiBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

// bold style
TextStyle getBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

// bold style
TextStyle getExtraBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.extraBold, color);
}

