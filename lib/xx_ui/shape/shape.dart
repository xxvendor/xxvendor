import 'package:flutter/material.dart';

class XXShape extends StatelessWidget {
  final BoxShape? boxShape;
  final Widget? child;
  final BorderRadius? borderRadius;

  const XXShape({Key? key, this.boxShape, this.child, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget = SizedBox(
      child: child,
    );
    if (boxShape == BoxShape.rectangle) {
      if (borderRadius == null) {
        widget = SizedBox(
          child: child,
        );
      } else {
        widget = ClipRRect(
          borderRadius: borderRadius,
          child: child,
        );
      }
    } else if (boxShape == BoxShape.circle) {
      widget = ClipOval(
        child: child,
      );
    }

    return widget;
  }
}
