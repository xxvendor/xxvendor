import 'package:flutter/material.dart';

class DivideWidget extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;

  const DivideWidget(
      {Key? key, this.color, this.height, this.width, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height ?? 0.5,
      color: color ?? Colors.grey,
      width: width ?? MediaQuery.of(context).size.width,
    );
  }
}
