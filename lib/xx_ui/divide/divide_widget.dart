import 'package:flutter/material.dart';

class XXDivide extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;

  const XXDivide({Key? key, this.color, this.height, this.width, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height ?? 0.5,
      color: color ?? const Color(0xffEDF0EF),
      width: width ?? MediaQuery.of(context).size.width,
    );
  }
}
