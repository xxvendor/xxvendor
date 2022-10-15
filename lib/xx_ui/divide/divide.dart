import 'package:flutter/material.dart';

class XXDivide extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final Color? frontColor;

  const XXDivide(
      {Key? key,
      this.color,
      this.height,
      this.width,
      this.margin,
      this.frontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 0.5,
      color: frontColor ?? color ?? const Color(0xffEDF0EF),
      width: width ?? MediaQuery.of(context).size.width,
      child: Container(
        margin: margin,
        height: height ?? 0.5,
        color: color ?? const Color(0xffEDF0EF),
        width: width ?? MediaQuery.of(context).size.width,
      ),
    );
  }
}
