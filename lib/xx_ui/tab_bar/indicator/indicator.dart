import 'package:flutter/material.dart';


class XXTabIndicator extends Decoration {
  final double indicatorWidth;

  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const XXTabIndicator(
      {required this.borderSide,
      this.insets = EdgeInsets.zero,
      required this.indicatorWidth});

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the
  /// tab indicator's bounds in terms of its (centered) tab widget with
  /// [TabIndicatorSize.label], or the entire tab with [TabIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is XXTabIndicator) {
      return XXTabIndicator(
          borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
          insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
          indicatorWidth: indicatorWidth);
    }
    return super.lerpTo(b, t);
  }

  @override
  XXUnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return XXUnderlinePainter(this, indicatorWidth, onChanged!);
  }
}

class XXUnderlinePainter extends BoxPainter {
  final double wantWidth;

  XXUnderlinePainter(
      this.decoration, this.wantWidth, VoidCallback onChanged)
      : super(onChanged);

  final XXTabIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;

  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    double cw = (indicator.left + indicator.right) / 2;
    return Rect.fromLTWH(cw - wantWidth / 2,
        indicator.bottom - borderSide.width, wantWidth, borderSide.width);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator =
        _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    final Paint paint = borderSide.toPaint()..strokeCap = StrokeCap.square;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}
