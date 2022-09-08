

import 'package:flutter/cupertino.dart';
import 'package:xx_vendor/xx_ui/shimmer/shimmer.dart';
import 'package:xx_vendor/xx_ui/vvm_get/xx_get_builder.dart';


import '../../xx_util/xx_util.dart';
import 'base_view_model.dart';



abstract class BaseStateLessWidget<VM extends BaseViewModel>
    extends StatelessWidget {
  const BaseStateLessWidget({Key? key}) : super(key: key);

  VM createViewModel();

  Widget widgetBuilder(BuildContext context, VM vm);

  Object? initControllerId();

  String? initControllerTag();

  @override
  Widget build(BuildContext context) {
    VM viewModel = createViewModel();
    return XXGetBuilder<VM>(
      controller: viewModel,
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
