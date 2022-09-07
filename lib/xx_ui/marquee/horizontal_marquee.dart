import 'dart:async';

import 'package:flutter/cupertino.dart';

class HorizontalMarquee extends StatefulWidget {
  final int? duration;
  final double? stepOffset;
  final double? paddingLeft;
  final List<Widget> items;

  const HorizontalMarquee(
      {Key? key,
      this.paddingLeft,
      this.duration,
      this.stepOffset,
      required this.items})
      : super(key: key);

  @override
  State<HorizontalMarquee> createState() => _HorizontalMarqueeState();
}

class _HorizontalMarqueeState extends State<HorizontalMarquee> {
  late ScrollController controller;
  late Timer timer;
  double offset = 0.0;

  @override
  void initState() {
    super.initState();
    Duration scrollDuration = Duration(milliseconds: widget.duration ?? 2000);
    double stepOffset = widget.stepOffset ?? 200;

    controller = ScrollController(initialScrollOffset: offset);
    timer = Timer.periodic(scrollDuration, (timer) {
      double newOffset = controller.offset + stepOffset;
      if (newOffset != offset) {
        offset = newOffset;
        controller.animateTo(offset,
            duration: scrollDuration, curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  Widget _child() {
    return Row(children: _children());
  }

  // 子视图
  List<Widget> _children() {
    double paddingLeft = widget.paddingLeft ?? 50;

    List<Widget> items = [];
    List list = widget.items;
    for (var i = 0; i < list.length; i++) {
      Container item = Container(
        margin: EdgeInsets.only(right: paddingLeft),
        child: list[i],
      );
      items.add(item);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      controller: controller,
      itemBuilder: (context, index) {
        return _child();
      },
    );
  }
}
