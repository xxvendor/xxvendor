import 'package:flutter/cupertino.dart';

import '../swiper/swiper.dart';



class VerticalMarquee extends StatelessWidget {
  final int? duration;
  final List<Widget> items;

  const VerticalMarquee({Key? key, this.duration, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int scrollDuration = duration ?? 2000;
    return XXSwiper(
      itemCount: items.length,
      scrollDirection: Axis.vertical,
      loop: true,
      autoplay: true,
      duration: scrollDuration,
      itemBuilder: (BuildContext context, int index) {
        return items[index];
      },
    );
  }
}
