import 'package:flutter/cupertino.dart';

import '../../xx_util/dialog/dialog_util.dart';
import 'base_view_model.dart';

abstract class BaseStatelessWidget<VM extends BaseViewModel>
    extends StatelessWidget {
  const BaseStatelessWidget({Key? key}) : super(key: key);

  VM createViewModel();

  Widget widgetBuild(BuildContext context, VM vm);

  @override
  Widget build(BuildContext context) {
    VM viewModel = createViewModel();
    return widgetBuild(context, viewModel);
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
