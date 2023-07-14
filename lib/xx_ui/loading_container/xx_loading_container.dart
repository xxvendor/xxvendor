import 'package:flutter/cupertino.dart';

enum ContainerLoadingStatus { idle, loading, success, failed, noData }

Widget generateXXLoadingContainer(
    {required ContainerLoadingStatus loadingStatus,
    Widget loadingWidget = const SizedBox(),
    Widget failedWidget = const SizedBox(),
    Widget noDataWidget = const SizedBox(),
    required Widget succeedWidget,
    Widget idleWidget = const SizedBox()}) {
  Widget child = loadingWidget;

  switch (loadingStatus) {
    case ContainerLoadingStatus.idle:
      child = idleWidget ?? const SizedBox();
      break;
    case ContainerLoadingStatus.loading:
      child = loadingWidget;
      break;
    case ContainerLoadingStatus.failed:
      child = failedWidget;
      break;
    case ContainerLoadingStatus.noData:
      child = noDataWidget;
      break;
    case ContainerLoadingStatus.success:
      child = succeedWidget;
      break;
  }
  return child;
}
