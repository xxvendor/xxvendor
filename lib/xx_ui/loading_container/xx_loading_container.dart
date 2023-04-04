import 'package:flutter/cupertino.dart';

enum ContainerLoadingStatus { idle, loading, success, failed, noData }

class XXLoadingContainer extends StatelessWidget {
  final ContainerLoadingStatus loadingStatus;
  final Widget loadingWidget;
  final Widget failedWidget;
  final Widget noDataWidget;
  final Widget succeedWidget;
  final Widget? idleWidget;

  const XXLoadingContainer(
      {Key? key,
      required this.loadingStatus,
      required this.loadingWidget,
      required this.failedWidget,
      required this.noDataWidget,
      required this.succeedWidget,
      this.idleWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

Widget generateXXLoadingContainer(
    {required ContainerLoadingStatus loadingStatus,
    required Widget loadingWidget,
    required Widget failedWidget,
    required Widget noDataWidget,
    required Widget succeedWidget,
    Widget? idleWidget}) {
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
