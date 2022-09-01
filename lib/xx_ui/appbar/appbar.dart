import 'package:flutter/material.dart';

class XXAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? actions;
  final Widget leading;
  final GestureTapCallback? onLeadingTap;
  final Color? backgroundColor;
  final Color? navigatorColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool showLeading;
  final double width;
  final double height;
  final double? iconWidth;
  final double? iconHeight;
  final TextStyle? titleTextStyle;

  const XXAppBar({
    Key? key,
    this.title,
    this.actions,
    required this.leading,
    this.backgroundColor,
    this.navigatorColor,
    this.padding,
    this.margin,
    this.showLeading = true,
    required this.height,
    required this.width,
    this.iconHeight,
    this.iconWidth,
    this.titleTextStyle,
    this.onLeadingTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.white,
      padding: padding ??
          EdgeInsets.only(
              left: 16, right: 16, top: MediaQuery.of(context).padding.top),
      child: Stack(
        alignment: Alignment.center,
        children: [
          showLeading == true
              ? Positioned(left: 0, child: leading)
              : const SizedBox(),
          Container(
            alignment: Alignment.center,
            child: Text(
              title ?? "",
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: titleTextStyle ??
                  const TextStyle(
                      color: Color(0xff333333),
                      fontWeight: FontWeight.w500,
                      fontFamily: "PingFang SC",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
            ),
          ),
          Positioned(right: 0, child: actions ?? const SizedBox()),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(width, height);
}
