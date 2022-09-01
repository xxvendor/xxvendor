import 'package:flutter/material.dart';

import 'inkwell.dart';
import 'ink_config.dart';

class GradientInkWell extends StatelessWidget {
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
  final Gradient? gradient;
  final Gradient? disableGradient;
  final bool enable;

  const GradientInkWell({
    Key? key,
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
    this.gradient,
    this.disableGradient,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShapeBorder shapeBorder = const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, side: BorderSide.none);

    BorderRadius? mBorderRadius = borderRadius;
    BoxShape boxShape = BoxShape.rectangle;
    if (inkShape != null) {
      switch (inkShape!) {
        case InkShape.roundedRectangle:
          shapeBorder = RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.zero,
              side: side ?? BorderSide.none);
          boxShape = BoxShape.rectangle;
          break;
        case InkShape.circle:
          shapeBorder = CircleBorder(side: side ?? BorderSide.none);
          boxShape = BoxShape.circle;
          mBorderRadius = null;
          break;
        case InkShape.beveledRectangle:
          // TODO: Handle this case.
          break;
        case InkShape.stadium:
          // TODO: Handle this case.
          break;
      }
    }

    return DecoratedBox(
      decoration: BoxDecoration(
          shape: boxShape,
          gradient: enable ? gradient : disableGradient,
          borderRadius: mBorderRadius),
      child: Material(
        type: MaterialType.transparency,
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
      ),
    );
  }
}
