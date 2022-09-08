

import 'package:get/get.dart';

abstract class BaseViewModel extends GetxController {
  bool mShowShimmerStatus = false;

  bool get showShimmerStatus => mShowShimmerStatus;

  changeShowShimmerStatus({required status}) {
    mShowShimmerStatus = status;
    update();
  }

  BaseViewModel({bool? status = false}) {
    mShowShimmerStatus = status ?? false;
  }
}
