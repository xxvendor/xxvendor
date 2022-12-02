

import 'package:flutter/material.dart';

import '../../xx_vendor.dart';



enum LoadingStatus { loading, success, failed }

typedef SuccessWidget = Widget Function(dynamic data);
typedef OnLoading = Future<Resp> Function();

class XXLoadingContainer extends StatelessWidget {
  final SuccessWidget successWidget;
  final Widget failedWidget;
  final Widget loadingWidget;
  final OnLoading onLoading;

  const XXLoadingContainer({
    Key? key,
    required this.successWidget,
    this.failedWidget = const SizedBox(),
    this.loadingWidget = const SizedBox(),
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String loadingContainerControllerTag =
        DateTime.now().millisecondsSinceEpoch.toString();
    LoadingContainerController loadingContainerController =
        Get.put<LoadingContainerController>(LoadingContainerController());

    loadingContainerController.loading(onLoading);

    Widget child(LoadingStatus loadingStatus, dynamic data) {
      Widget widget = const SizedBox();
      switch (loadingStatus) {
        case LoadingStatus.loading:
          widget = loadingWidget;
          break;
        case LoadingStatus.success:
          widget = successWidget(data);
          break;
        case LoadingStatus.failed:
          widget = XXInkWell(
              onTap: () {
                loadingContainerController.loading(onLoading);
              },
              child: failedWidget);
          break;
      }
      return widget;
    }

    return GetBuilder<LoadingContainerController>(
        tag: loadingContainerControllerTag,
        builder: (controller) {
          return child(controller.loadingStatus, controller.data);
        });
  }
}

class LoadingContainerController extends GetxController {
  LoadingStatus mLoadingStatus = LoadingStatus.loading;

  dynamic mData;

  dynamic get data => mData;

  LoadingStatus get loadingStatus => mLoadingStatus;

  loading(OnLoading onLoading) async {
    Resp resp = await onLoading();

    if (resp.success) {
      mData = resp.data;
      mLoadingStatus = LoadingStatus.success;
    } else {
      mLoadingStatus = LoadingStatus.failed;
    }
    update();
  }
}
