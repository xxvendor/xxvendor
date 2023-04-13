import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xx_vendor/xx_ui/base/base.dart';
import 'package:xx_vendor/xx_ui/base/base_model.dart';
import 'package:xx_vendor/xx_util/dialog/dialog_util.dart';

class MvvmPage extends BaseStatelessWidget<MvvmViewModel> {
  const MvvmPage({Key? key}) : super(key: key);

  @override
  MvvmViewModel createViewModel() {
    MvvmViewModel mvvmViewModel =
        Get.put<MvvmViewModel>(MvvmViewModel(widget: this, model: MvvmModel()));
    return mvvmViewModel;
  }

  @override
  Widget widgetBuild(BuildContext context, MvvmViewModel vm) {
    return Scaffold(
      body: GetBuilder<MvvmViewModel>(builder: (controller) {
        return Center(
          child: Column(
            children: [
              Text(
                controller.count.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              IconButton(
                  onPressed: () {
                    controller.addCount(context);
                  },
                  icon: const Icon(Icons.add)),
            ],
          ),
        );
      }),
    );
  }

  printLog(String data) {
    print(data);
  }

  showCenterTipDialog({required BuildContext context, required String title}) {
    DialogUtil.showCenterTipDialog(context: context, title: title);
  }
}

class MvvmModel extends BaseModel {
  int addCount(int rawCount) {
    return rawCount + 1;
  }
}

class MvvmViewModel extends BaseViewModel<MvvmPage, MvvmModel> {
  MvvmViewModel({required super.widget, required super.model});

  int mCount = 0;

  int get count => mCount;

  addCount(BuildContext context) {
    mCount = model.addCount(mCount);
    update();
    widget.printLog(count.toString());

    if (count == 5) {
      widget.showCenterTipDialog(context: context, title: "$count");
    }
  }
}
