import 'package:images_picker/images_picker.dart';
import 'package:xx_vendor/xx_util/permission/permission_util.dart';

class XXImagePickerUtil {
  static Future<Media?> pickImageByGallery(
      {required Function onNoPermissionCallback}) async {
    bool granted = await XXPermissionUtil.requestCameraPermissions();
    Media? media;
    if (granted) {
      List<Media>? list = await ImagesPicker.pick(
        count: 1,
        pickType: PickType.image,
      );
      if (list != null && list.isNotEmpty) {
        media = list[0];
      }
    } else {
      onNoPermissionCallback();
    }

    return media;
  }

  static Future<Media?> pickImageByCamera(
      {required Function onNoPermissionCallback}) async {
    bool granted = await XXPermissionUtil.requestCameraPermissions();
    Media? media;
    if (granted) {
      List<Media>? list = await ImagesPicker.openCamera(
        pickType: PickType.image,
      );
      if (list != null && list.isNotEmpty) {
        media = list[0];
      }
    } else {
      onNoPermissionCallback();
    }
    return media;
  }
}
