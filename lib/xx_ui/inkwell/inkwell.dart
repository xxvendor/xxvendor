import 'package:flutter/material.dart';

import 'gradient_inkwell.dart';
import 'ink_config.dart';
import 'pure_color_inkwell.dart';



export 'gradient_inkwell.dart';
export 'ink_config.dart';
export 'pure_color_inkwell.dart';

class XXInkWell extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget? child;
  final InkShape? inkShape;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapUpCallback? onTapUp;
  final Color? color;
  final Color? splashColor;
  final Color? highlightColor;
  final double? radius;
  final BorderRadius? borderRadius;
  final BorderSide? side;
  final Gradient? gradient;
  final InkType inkType;
  final Color? disableColor;
  final Gradient? disableGradient;
  final bool enable;

  const XXInkWell({
    Key? key,
    this.color=Colors.transparent,
    this.onTap,
    required this.child,
    this.inkShape,
    this.borderRadius,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.splashColor = Colors.transparent,
    this.highlightColor = Colors.transparent,
    this.radius,
    this.side,
    this.gradient,
    this.inkType = InkType.solid,
    this.disableColor,
    this.disableGradient,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return inkType == InkType.gradient
        ? GradientInkWell(
            enable: enable,
            disableGradient: disableGradient,
            onTap: onTap,
            inkShape: inkShape,
            onDoubleTap: onDoubleTap,
            onLongPress: onLongPress,
            onTapDown: onTapDown,
            onTapCancel: onTapCancel,
            onTapUp: onTapUp,
            splashColor: splashColor,
            highlightColor: highlightColor,
            radius: radius,
            borderRadius: borderRadius,
            side: side,
            gradient: gradient,
            child: child)
        : PureColorInkWell(
            onTap: onTap,
            disableColor: disableColor,
            enable: enable,
            inkShape: inkShape,
            onDoubleTap: onDoubleTap,
            onLongPress: onLongPress,
            onTapDown: onTapDown,
            onTapCancel: onTapCancel,
            onTapUp: onTapUp,
            splashColor: splashColor,
            highlightColor: highlightColor,
            radius: radius,
            borderRadius: borderRadius,
            side: side,
            color: color,
            child: child);
  }
}
