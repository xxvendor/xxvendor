library custom_line_indicator_bottom_navbar;

import 'package:flutter/material.dart';

import '../xx_ui.dart';



typedef OnTap = Function(int index);

class XXBottomNavigatorBar extends StatelessWidget {
  final Color? backgroundColor;
  final List<XXBottomBarItem> items;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final double unselectedFontSize;
  final Color? splashColor;
  final Color? highlightColor;
  final int currentIndex;
  final OnTap onTap;
  final double selectedFontSize;
  final double selectedIconSize;
  final double unselectedIconSize;
  final LinearGradient? gradient;
  final double? distance;
  final InkShape? buttonShape;
  final BorderRadiusGeometry? borderRadius;

  const XXBottomNavigatorBar({
    Key? key,
    this.backgroundColor,
    this.selectedColor,
    required this.items,
    this.unSelectedColor,
    this.unselectedFontSize = 12,
    this.selectedFontSize = 12,
    this.selectedIconSize = 15,
    this.unselectedIconSize = 15,
    this.splashColor,
    this.highlightColor,
    this.currentIndex = 0,
    this.distance = 5,
    this.buttonShape = InkShape.roundedRectangle,
    this.borderRadius,
    required this.onTap,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarThemeData bottomTheme =
        BottomNavigationBarTheme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? bottomTheme.backgroundColor,
        gradient: gradient,
      ),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < items.length; i++) ...[
              Expanded(
                child: XXBottomNavbarItems(
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                  item: items[i],
                  unSelectedFontSize: unselectedFontSize,
                  selectedFontSize: selectedFontSize,
                  unselectedIconSize: unselectedIconSize,
                  selectedIconSize: selectedIconSize,
                  splashColor: splashColor,
                  currentIndex: currentIndex,
                  index: i,
                  highlightColor: highlightColor,
                  onTap: onTap,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class XXBottomBarItem {
  final String icon;
  final String label;
  final ImageStyle imageStyle;
  final int bubbleNum;

  XXBottomBarItem({
    required this.icon,
    required this.imageStyle,
    required this.label,
    this.bubbleNum = 0,
  });
}

class XXBottomNavbarItems extends StatelessWidget {
  final XXBottomBarItem item;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final double unSelectedFontSize;
  final double selectedIconSize;
  final double unselectedIconSize;
  final double selectedFontSize;
  final Color? splashColor;
  final Color? highlightColor;
  final int? currentIndex;
  final int index;
  final double? distance;
  final EdgeInsetsGeometry? padding;
  final Function(int) onTap;
  final InkShape? buttonShape;
  final BorderRadius? borderRadius;

  const XXBottomNavbarItems({
    Key? key,
    required this.item,
    this.selectedColor,
    this.unSelectedColor,
    this.unSelectedFontSize = 11,
    this.selectedFontSize = 12,
    this.selectedIconSize = 20,
    this.unselectedIconSize = 15,
    this.splashColor,
    this.highlightColor,
    this.currentIndex,
    this.distance,
    this.padding,
    this.borderRadius,
    this.buttonShape,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarThemeData bottomTheme =
        BottomNavigationBarTheme.of(context);

    return SafeArea(
      child: XXInkWell(
        inkShape: buttonShape,
        borderRadius: borderRadius,
        color: Colors.transparent,
        splashColor: splashColor ?? Colors.transparent,
        highlightColor: highlightColor ?? Colors.transparent,
        onTap: () {
          onTap(index);
        },
        child: Padding(
          padding: padding ?? const EdgeInsets.only(bottom: 7, top: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  XXImage(
                    imagePath: item.icon,
                    imageStyle: ImageStyle.network,
                    size: currentIndex == index
                        ? selectedIconSize
                        : unselectedIconSize,
                    color: currentIndex == index
                        ? selectedColor ?? Colors.orange
                        : unSelectedColor ?? bottomTheme.unselectedItemColor,
                  ),
                  SizedBox(
                    height: distance,
                  ),
                  Text(
                    item.label,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: currentIndex == index
                          ? selectedFontSize
                          : unSelectedFontSize,
                      color: currentIndex == index
                          ? selectedColor ?? Colors.orange
                          : unSelectedColor ?? bottomTheme.unselectedItemColor,
                    ),
                  ),
                ],
              ),
              item.bubbleNum > 0
                  ? Positioned(
                      top: 0,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                            shape: BoxShape.rectangle),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        child: Text(
                          item.bubbleNum > 99
                              ? "99+"
                              : item.bubbleNum.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ))
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
