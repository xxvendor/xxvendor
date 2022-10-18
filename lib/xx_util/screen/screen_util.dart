import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';


///必须在首页进行初始化
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

///按照屏幕高缩放
double scaleByHeight(num height) {
  return ScreenUtil().setHeight(height);
}

///字体适配
double font(double fontSize) {
  return fontSize.sp;
}

///屏幕宽度
double getScreenWidth() {
  return ScreenUtil().screenWidth;
}

///屏幕高度
double getScreenHeight() {
  return ScreenUtil().screenHeight;
}

///屏幕密度
double getScreenPixelRatio() {
  return ScreenUtil().pixelRatio ?? 1;
}


