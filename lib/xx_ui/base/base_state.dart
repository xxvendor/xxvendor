import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../xx_util/dialog/dialog_util.dart';
import '../../xx_vendor.dart';

abstract class BaseState<W extends StatefulWidget, VM extends BaseViewModel>
    extends State<W>
    with
        AfterLayoutMixin,
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin {
  VM? viewModel;

  VM createViewModel();

  afterFirstLayoutBuild(BuildContext context, VM vm) {}

  Widget widgetBuild(BuildContext context, VM vm);

  @override
  void initState() {
    super.initState();
    viewModel ??= createViewModel();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    afterFirstLayoutBuild(context, viewModel!);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widgetBuild(context, viewModel!);
  }


  Future showCenterDialog(
      {required BuildContext context,
        required String title,
        String? content,
        String? cancelText,
        String? confirmText}) async {
    Map<String, dynamic> arguments = {};
    arguments["title"] = title;
    arguments["cancelText"] = cancelText;
    arguments["confirmText"] = confirmText;
    return await DialogUtil.showCenterDialog(
        context: context,
        title: title,
        content: content,
        cancelText: cancelText,
        confirmText: confirmText);
  }

  Future showCenterTipDialog({
    required BuildContext context,
    required String title,
    String? cancelText,
    String? confirmText,
  }) async {
    Map<String, dynamic> arguments = {};
    arguments["title"] = title;
    arguments["confirmText"] = confirmText;
    return await DialogUtil.showCenterTipDialog(
        context: context,
        title: title,
        cancelText: cancelText,
        confirmText: confirmText);
  }

  Future showBottomSelectDialog(
      {required BuildContext context,
        required Widget child,
        bool? showSafeArea = false}) async {
    Map<String, dynamic> arguments = {};
    arguments["child"] = child;
    arguments["showSafeArea"] = showSafeArea;

    return await DialogUtil.showBottomSelectDialog(
      context: context,
      child: child,
      showSafeArea: showSafeArea,
    );
  }

  Future showBottomDialog(
      {required BuildContext context,
        required Widget child,
        bool? showSafeArea = false,
        double? maxHeight}) async {
    Map<String, dynamic> arguments = {};
    arguments["child"] = child;
    arguments["showSafeArea"] = showSafeArea;
    arguments["maxHeight"] = maxHeight;

    return await DialogUtil.showBottomDialog(
        context: context,
        child: child,
        showSafeArea: showSafeArea,
        maxHeight: maxHeight);
  }

}
