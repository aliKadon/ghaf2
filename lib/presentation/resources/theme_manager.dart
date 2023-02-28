import 'package:flutter/material.dart';
import 'package:ghaf_application/presentation/resources/styles_manager.dart';
import 'package:ghaf_application/presentation/resources/values_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    // primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.primaryDark,
    disabledColor: ColorManager.grey,
    splashColor: ColorManager.greyLight,
    // cardView theme
    cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s2),
    // app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.white,
        elevation: AppSize.s0,
        shadowColor: ColorManager.transparent,
        titleTextStyle:
            getBoldStyle(fontSize: FontSize.s20, color: ColorManager.black)),
    // button theme
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)),
        ),
        disabledColor: ColorManager.grey,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.greyLight),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getMediumStyle(
                color: ColorManager.white, fontSize: FontSize.s18),
            // foregroundColor: ColorManager.primary,
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r8)))),

    textTheme: TextTheme(
        displayLarge:
            getMediumStyle(color: ColorManager.black, fontSize: FontSize.s14),
        headlineLarge: getRegularStyle(
            color: ColorManager.primary, fontSize: FontSize.s14),
        headlineMedium:
            getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s10),
        titleMedium:
            getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s16),
        titleSmall:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
        bodyLarge: getRegularStyle(color: ColorManager.grey),
        bodySmall: getRegularStyle(color: ColorManager.grey),
        bodyMedium:
            getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s12),
        labelSmall:
            getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s12)),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(

        // content padding
        contentPadding: EdgeInsets.all(AppPadding.p10),
        // hint style
        hintStyle:
            getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        labelStyle:
            getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManager.red),
        // enabled border style
        enabledBorder:
        OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey, ),
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8))),


        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.red, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)))),
    // label style
  );
}
