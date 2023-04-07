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



}
