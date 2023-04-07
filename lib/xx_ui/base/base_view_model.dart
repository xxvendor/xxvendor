import 'package:get/get.dart';
import 'package:xx_vendor/xx_ui/base/base_model.dart';

abstract class BaseViewModel<T extends BaseModel> extends GetxController {
  T model;

  BaseViewModel(this.model);

}
