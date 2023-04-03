import 'package:flutter/cupertino.dart';


enum LoadingStatus { idle, loading, success, failed, noData }

class XXLoadingContainer extends StatelessWidget {
  final LoadingStatus loadingStatus;
  final Widget loadingWidget;
  final Widget failedWidget;
  final Widget noDataWidget;
  final Widget succeedWidget;
  final Widget? idleWidget;

  const XXLoadingContainer({Key? key, required this.loadingStatus, required this.loadingWidget, required this.failedWidget, required this.noDataWidget, required this.succeedWidget, this.idleWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = loadingWidget;

    switch (loadingStatus) {
      case LoadingStatus.idle:
        child = idleWidget ?? const SizedBox();
        break;
      case LoadingStatus.loading:
        child = loadingWidget;
        break;
      case LoadingStatus.failed:
        child = failedWidget;
        break;
      case LoadingStatus.noData:
        child = noDataWidget;
        break;
      case LoadingStatus.success:
        child = succeedWidget;
        break;
    }
    return child;
  }
}
