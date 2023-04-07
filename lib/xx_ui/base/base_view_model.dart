import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xx_vendor/xx_ui/base/base_model.dart';

abstract class BaseViewModel<V extends Widget, M extends BaseModel>
    extends GetxController {
  M model;

  V widget;

  BaseViewModel(this.widget, this.model);
}
