import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xx_vendor/xx_ui/base/base.dart';
import 'package:xx_vendor/xx_ui/base/base_model.dart';

class MvvmPage extends BaseStatelessWidget<MvvmViewModel> {
  const MvvmPage({Key? key}) : super(key: key);

  @override
  MvvmViewModel createViewModel() {
    MvvmViewModel mvvmViewModel =
        Get.put<MvvmViewModel>(MvvmViewModel(MvvmModel()));
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
                    controller.addCount();
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
        );
      }),
    );
  }
}

class MvvmModel extends BaseModel {
  int mCount = 0;

  int get count => mCount;

  addCount() {
    mCount = mCount + 1;
  }
}

class MvvmViewModel extends BaseViewModel<MvvmModel> {
  MvvmViewModel(super.model);

  int get count => model.count;

  addCount() {
    model.addCount();
    update();
  }
}
