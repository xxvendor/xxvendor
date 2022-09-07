
import 'package:flutter/cupertino.dart';
import 'package:xx_vendor/xx_ui/marquee/marquee.dart';

export 'horizontal_marquee.dart';
export 'vertical_marquee.dart';

class XXMarquee extends StatelessWidget {
  final int? duration;
  final double? stepOffset;
  final double? paddingLeft;
  final List<Widget> items;
  final Axis? scrollDirection;

  const XXMarquee(
      {Key? key,
      this.paddingLeft,
      this.duration,
      this.stepOffset,
      this.scrollDirection = Axis.vertical,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return scrollDirection == Axis.vertical
        ? VerticalMarquee(
            items: items,
            duration: duration,
          )
        : HorizontalMarquee(
            items: items,
            duration: duration,
            paddingLeft: paddingLeft,
            stepOffset: stepOffset,
          );
  }
}
