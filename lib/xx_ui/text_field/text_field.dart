import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class XXTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Decoration? decoration;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hintText;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool autoFocus;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final bool? showCursor;
  final bool readOnly;
  final EdgeInsets scrollPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final String? prefixText;
  final String? suffixText;
  final TextStyle? prefixStyle;
  final TextStyle? suffixStyle;
  final Color? filledColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final bool? filled;
  final EdgeInsetsGeometry? contentPadding;
  final bool isCollapsed;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enableBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final TextInputType? keyboardType;
  final GestureTapCallback? onTap;
  final Widget? counter;
  final int? maxLength;
  final String? counterText;
  final InputCounterWidgetBuilder? buildCounter;
  final TextStyle? countStyle;

  const XXTextField(
      {Key? key,
      required this.controller,
      this.focusNode,
      this.decoration,
      this.textInputAction,
      this.textCapitalization,
      this.style,
      this.hintStyle,
      this.hintText,
      this.textAlign = TextAlign.start,
      this.autoFocus = false,
      this.obscureText = false,
      this.maxLines,
      this.minLines,
      this.onChanged,
      this.onEditingComplete,
      this.onSubmitted,
      this.inputFormatters,
      this.enabled,
      this.cursorWidth = 2,
      this.cursorHeight,
      this.cursorRadius,
      this.cursorColor,
      this.showCursor,
      this.readOnly = false,
      this.scrollPadding = const EdgeInsets.all(20.0),
      this.filledColor,
      this.filled,
      this.contentPadding = const EdgeInsets.symmetric(horizontal: 20),
      this.isCollapsed = true,
      this.textDirection,
      this.border,
      this.prefixIcon,
      this.suffixIcon,
      this.prefixText,
      this.suffixText,
      this.prefixStyle,
      this.prefixIconConstraints,
      this.prefixIconColor,
      this.suffixIconConstraints,
      this.suffixStyle,
      this.suffixIconColor,
      this.keyboardType,
      this.onTap,
      this.focusedBorder,
      this.enableBorder,
      this.errorBorder,
      this.disabledBorder,
      this.counter,
      this.maxLength,
      this.counterText,
      this.buildCounter,
      this.countStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      keyboardType: keyboardType,
      focusNode: focusNode,
      controller: controller,
      textAlign: textAlign,
      textDirection: textDirection,
      textInputAction: textInputAction,
      style: style ??
          const TextStyle(
              color: Color(0xff333333),
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.47),
      autofocus: autoFocus,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      enabled: enabled,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorColor: cursorColor ?? Colors.black,
      showCursor: showCursor,
      readOnly: readOnly,
      scrollPadding: scrollPadding,
      buildCounter: buildCounter,
      decoration: InputDecoration(
        counter: counter,
        counterText: counterText,
        counterStyle: countStyle,
        isCollapsed: isCollapsed,
        contentPadding: contentPadding,
        hintText: hintText,
        hintStyle: hintStyle ??
            const TextStyle(
                color: Color(0xffC5C5C5),
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.47),
        /* prefix: prefix,
        suffix: suffix,*/
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        prefixText: prefixText,
        prefixStyle: prefixStyle,
        prefixIconColor: prefixIconColor,
        suffixIconColor: suffixIconColor,
        suffixText: suffixText,
        suffixIconConstraints: suffixIconConstraints,
        suffixStyle: suffixStyle,
        fillColor: filledColor,
        filled: filled,
        focusedBorder: focusedBorder ?? InputBorder.none,
        border: border ?? InputBorder.none,
        enabledBorder: enableBorder ?? InputBorder.none,
        errorBorder: errorBorder ?? InputBorder.none,
        disabledBorder: disabledBorder ?? InputBorder.none,
      ),
    );
  }
}
