import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xx_vendor/xx_ui/base/base_model.dart';

abstract class BaseViewModel<W extends Widget, M extends BaseModel>
    extends GetxController {


  W widget;

  M model;

  BaseViewModel({required this.widget, required this.model});
}
