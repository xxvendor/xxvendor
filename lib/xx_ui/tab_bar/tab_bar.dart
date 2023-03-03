import 'package:flutter/material.dart';

export 'package:xx_vendor/xx_ui/tab_bar/indicator/indicator.dart';

class XXTabBar extends StatelessWidget {
  final TabController controller;
  final List<Widget> tabs;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final double? indicatorWeight;
  final Decoration? indicator;
  final bool? isScrollable;
  final TabBarIndicatorSize? indicatorSize;
  final EdgeInsets? padding;
  final EdgeInsets? indicatorPadding;
  final EdgeInsets? labelPadding;
  final ValueChanged<int>? onTap;
  const XXTabBar(
      {Key? key,
      required this.controller,
      required this.tabs,
      this.labelStyle,
      this.indicatorColor,
      this.labelColor,
      this.unselectedLabelColor,
      this.indicatorWeight,
      this.indicator,
      this.isScrollable,
      this.indicatorSize,
      this.unselectedLabelStyle,
      this.padding,
      this.indicatorPadding,
      this.labelPadding, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(splashColor: Colors.transparent),
      child: TabBar(
        controller: controller,
        tabs: tabs,
        padding: padding,
        labelStyle: labelStyle,
        indicatorPadding: indicatorPadding ?? EdgeInsets.zero,
        indicatorColor: indicatorColor,
        indicatorWeight: indicatorWeight ?? 2,
        indicator: indicator,
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
        unselectedLabelStyle: unselectedLabelStyle,
        isScrollable: isScrollable ?? false,
        indicatorSize: indicatorSize ?? TabBarIndicatorSize.label,
        labelPadding: labelPadding,
        onTap: onTap,
      ),
    );
  }
}
