import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../xx_vendor.dart';

abstract class BaseState<W extends StatefulWidget, VM extends BaseViewModel>
    extends State<W>
    with
        AfterLayoutMixin,
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin {
  VM? viewModel;

  VM createViewModel();

  afterVMInit(VM vm);

  afterFirstLayoutBuild(BuildContext context, VM vm);

  Widget widgetBuild(BuildContext context, VM vm);

  bool keepAlive();

  readyToDispose();

  @override
  void initState() {
    super.initState();
    viewModel ??= createViewModel();
    afterVMInit(viewModel!);
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

  @override
  bool get wantKeepAlive => keepAlive();

  @override
  void dispose() {
    readyToDispose();
    super.dispose();
  }
}
