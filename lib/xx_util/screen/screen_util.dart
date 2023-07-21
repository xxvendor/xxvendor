import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../xx_ui/base/base.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';


initScreenUtil({
  required double width,
  required double height,
  required BuildContext context,
}) {
  ScreenUtil.init(
    //设备像素大小
    context,
    //设计尺寸
    designSize: Size(width, height),
  );
}

///按照屏幕宽缩放
double scale(num width) {
  return ScreenUtil().setWidth(width);
}

///字体适配
double font(num fontSize) {
  return ScreenUtil().setSp(fontSize);
}

///屏幕宽度
double getScreenWidth() {
  return MediaQuery.of(Get.context!).size.width;
}

///屏幕高度
double getScreenHeight() {
  return MediaQuery.of(Get.context!).size.height;
}
