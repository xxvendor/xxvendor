import 'package:flutter/material.dart';

import 'inkwell.dart';
import 'ink_config.dart';

class PureColorInkWell extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget? child;
  final InkShape? inkShape;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapUpCallback? onTapUp;
  final Color? splashColor;
  final Color? highlightColor;
  final double? radius;
  final BorderRadius? borderRadius;
  final BorderSide? side;
  final Color? color;
  final Color? disableColor;
  final bool enable;

  const PureColorInkWell({
    Key? key,
    this.color,
    this.onTap,
    required this.child,
    this.inkShape,
    this.borderRadius,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.splashColor,
    this.highlightColor,
    this.radius,
    this.side,
    this.disableColor,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShapeBorder shapeBorder = const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, side: BorderSide.none);
    if (inkShape != null) {
      switch (inkShape!) {
        case InkShape.roundedRectangle:
          shapeBorder = RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.zero,
              side: side ?? BorderSide.none);
          break;
        case InkShape.circle:
          shapeBorder = CircleBorder(side: side ?? BorderSide.none);
          break;
        case InkShape.stadium:
          shapeBorder = StadiumBorder(side: side ?? BorderSide.none);
          break;
        case InkShape.beveledRectangle:
          shapeBorder = BeveledRectangleBorder(
            side: side ?? BorderSide.none,
            borderRadius: borderRadius ?? BorderRadius.zero,
          );
          break;
      }
    }

    return Material(
      color: enable ? color : disableColor,
      shape: shapeBorder,
      child: InkWell(
        customBorder: shapeBorder,
        splashColor: splashColor,
        highlightColor: highlightColor,
        onTap: enable ? onTap : null,
        radius: radius,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onTapUp: onTapUp,
        child: child,
      ),
    );
  }
}
