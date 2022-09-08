import 'dart:async';




import 'package:flutter/cupertino.dart';
import 'package:xx_vendor/xx_ui/shimmer/shimmer.dart';


import '../../xx_vendor.dart';
import 'xx_get_builder.dart';




abstract class BaseStateFulWidget extends StatefulWidget {
  const BaseStateFulWidget({Key? key}) : super(key: key);
}

abstract class BaseState<W extends StatefulWidget, VM extends BaseViewModel>
    extends State<W> with AfterLayoutMixin {
  VM? viewModel;

  VM createViewModel();

  afterVMInit(VM vm);

  afterFirstLayoutBuild(BuildContext context, VM vm);

  Widget widgetBuilder(BuildContext context, VM vm);

  Object? initControllerId();

  String? initControllerTag();

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
    return XXGetBuilder<VM>(
      controller: viewModel!,
      id: initControllerId(),
      tag: initControllerTag(),
      builder: (controller) {
        return controller.showShimmerStatus
            ? Container(
                width: getScreenWidth(),
                height: getScreenHeight(),
                alignment: Alignment.center,
                child: XXShimmer(
                  child: Text(
                    "X X X X",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: font(28),
                    ),
                  ),
                ),
              )
            : widgetBuilder(context, controller);
      },
    );
  }
}
