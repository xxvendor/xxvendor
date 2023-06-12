import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../xx_ui/base/base.dart';

///按照屏幕宽缩放
double scale(num width) {
  return width.toDouble();
}

///字体适配
double font(double fontSize) {
  return fontSize;
}

///屏幕宽度
double getScreenWidth() {
  return MediaQuery.of(Get.context!).size.width;
}

///屏幕高度
double getScreenHeight() {
  return MediaQuery.of(Get.context!).size.height;
}
