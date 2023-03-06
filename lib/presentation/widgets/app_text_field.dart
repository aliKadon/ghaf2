import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    String? initialValue,
    void Function()? onTap,
    TextEditingController? textController,
    required String hint,
    int? lines = 1,
    this.icon,
    TextInputType textInputType = TextInputType.text,
    bool obscureText = false,
    TextInputAction textInputAction = TextInputAction.next,
    Function(String value)? onSubmitted,
    String? Function(String? value)? validator,
    void Function(String? value)? onSaved,
  })  : _textController = textController,
        _initialValue = initialValue,
        _onTap = onTap,
        _hint = hint,
        _lines = lines,
        _textInputType = textInputType,
        _obscureText = obscureText,
        _textInputAction = textInputAction,
        _onSubmitted = onSubmitted,
        _validator = validator,
        _onSaved = onSaved,
        super(key: key);

  final String? _initialValue;
  final void Function()? _onTap;
  final TextEditingController? _textController;
  final String _hint;
  final int? _lines;
  final TextInputType _textInputType;
  final bool _obscureText;
  final Widget? icon;
  final TextInputAction _textInputAction;
  final void Function(String value)? _onSubmitted;
  final String? Function(String? value)? _validator;
  final void Function(String? value)? _onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: AppMargin.m16, right: AppMargin.m16, left: AppMargin.m16),
      child: TextFormField(
        initialValue: _initialValue,
        onTap: _onTap,
        readOnly: _onTap != null,
        controller: _textController,
        keyboardType: _textInputType,
        textInputAction: _textInputAction,
        obscureText: _obscureText,
        onFieldSubmitted: _onSubmitted,
        validator: _validator,
        onSaved: _onSaved,
        textAlign: TextAlign.start,
        style: getMediumStyle(
          color: ColorManager.black,
          fontSize: FontSize.s14,
        ),
        minLines: _lines,
        maxLines: _lines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: AppPadding.p16, vertical: AppPadding.p16),
          hintText: _hint,
          icon: icon,
          hintStyle: getMediumStyle(
            color: ColorManager.hintTextFiled,
          ),
          enabledBorder: buildOutlineInputBorder(
            color: ColorManager.grey,
          ),
          focusedBorder: buildOutlineInputBorder(
            color: ColorManager.grey,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.r8),
      borderSide: BorderSide(
        width: AppSize.s1,
        color: color,
      ),
    );
  }
}
