import 'package:images_picker/images_picker.dart';
import 'package:xx_vendor/xx_util/permission/permission_util.dart';

class XXMediaPickerUtil {
  static Future<List<Media>?> pickMediaByGallery({
    required Function onNoPermissionCallback,
    PickType? pickType,
    int? count,
    bool? gif,
    int? maxTime,
    CropOption? cropOpt,
    int? maxSize,
    double? quality,
  }) async {
    bool granted = await XXPermissionUtil.requestCameraPermissions();
    List<Media>? list;
    if (granted) {
      list = await ImagesPicker.pick(
          pickType: pickType ?? PickType.image,
          count: count ?? 1,
          gif: gif ?? true,
          maxTime: maxTime ?? 120,
          cropOpt: cropOpt,
          maxSize: maxSize,
          quality: quality);
    } else {
      onNoPermissionCallback();
    }
    return list;
  }

  static Future<List<Media>?> pickMediaByCamera({
    required Function onNoPermissionCallback,
    PickType? pickType,
    int? maxTime,
    CropOption? cropOpt,
    int? maxSize,
    double? quality,
  }) async {
    bool granted = await XXPermissionUtil.requestCameraPermissions();
    List<Media>? list;
    if (granted) {
      list = await ImagesPicker.openCamera(
          pickType: pickType ?? PickType.image,
          maxTime: maxTime ?? 120,
          maxSize: maxSize,
          cropOpt: cropOpt,
          quality: quality);
    } else {
      onNoPermissionCallback();
    }
    return list;
  }
}
