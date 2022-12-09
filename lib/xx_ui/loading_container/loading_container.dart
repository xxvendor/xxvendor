import 'dart:async';

import 'package:flutter/material.dart';

import '../../xx_vendor.dart';

enum LoadingStatus { loading, success, failed }

typedef SuccessWidget = Widget Function(dynamic data);
typedef OnLoading = Future<Resp> Function();
typedef OnLoadingFinished = Function();

class XXLoadingContainer extends StatefulWidget {
  final SuccessWidget successWidget;
  final Widget failedWidget;
  final Widget loadingWidget;
  final OnLoading onLoading;
  final bool forceRefresh;
  final OnLoadingFinished? onLoadingFinished;

  const XXLoadingContainer({
    Key? key,
    required this.successWidget,
    this.failedWidget = const SizedBox(),
    this.loadingWidget = const SizedBox(),
    required this.onLoading,
    this.forceRefresh = false,
    this.onLoadingFinished,
  }) : super(key: key);

  @override
  State<XXLoadingContainer> createState() => _XXLoadingContainerState();
}

class _XXLoadingContainerState extends State<XXLoadingContainer> with AfterLayoutMixin{
  late LoadingContainerController loadingContainerController;
  String loadingContainerControllerTag =
      DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    loadingContainerController =
        Get.put<LoadingContainerController>(LoadingContainerController());
  }

  @override
  Widget build(BuildContext context) {

    if (widget.forceRefresh) {
      loadingContainerController.loading(widget.onLoading);
    }

    Widget child(LoadingStatus loadingStatus, dynamic data) {
      Widget childWidget = const SizedBox();
      switch (loadingStatus) {
        case LoadingStatus.loading:
          childWidget = widget.loadingWidget;
          break;
        case LoadingStatus.success:
          childWidget = widget.successWidget(data);
          break;
        case LoadingStatus.failed:
          childWidget = XXInkWell(
              onTap: () {
                loadingContainerController.loading(widget.onLoading);
              },
              child: widget.failedWidget);
          break;
      }
      return widget;
    }

    return GetBuilder<LoadingContainerController>(
        tag: loadingContainerControllerTag,
        builder: (controller) {
          if (controller.isLoadingFinished) {
            widget.onLoadingFinished;
          }
          return child(controller.loadingStatus, controller.data);
        });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    loadingContainerController.loading(widget.onLoading);

  }
}

class LoadingContainerController extends GetxController {
  LoadingStatus mLoadingStatus = LoadingStatus.loading;

  dynamic mData;

  dynamic get data => mData;

  LoadingStatus get loadingStatus => mLoadingStatus;
  bool mIsLoadingFinished = false;

  bool get isLoadingFinished => mIsLoadingFinished;

  loading(OnLoading onLoading) async {
    Resp resp = await onLoading();

    if (resp.success) {
      mData = resp.data;
      mLoadingStatus = LoadingStatus.success;
    } else {
      mLoadingStatus = LoadingStatus.failed;
    }
    mIsLoadingFinished = true;
    update();
  }
}
