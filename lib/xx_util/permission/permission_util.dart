import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

export 'package:permission_handler/permission_handler.dart';

class XXPermissionUtil {
  static Future<bool> requestPermissions(
      {required List<Permission> permissionList}) async {
    bool granted = false;
    Map<Permission, PermissionStatus> statuses = await permissionList.request();
    if (!statuses.containsValue(PermissionStatus.denied) &&
        !statuses.containsValue(PermissionStatus.permanentlyDenied) &&
        !statuses.containsValue(PermissionStatus.restricted)) {
      granted = true;
    }
    return granted;
  }

  static Future<bool> openSetting() async {
    return await openAppSettings();
  }

  static Future<bool> requestStoragePermissions() async {
    return Platform.isAndroid
        ? await requestPermissions(permissionList: [
            Permission.storage,
          ])
        : true;
  }

  static Future<bool> requestCameraPermissions() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    return  ps.isAuth;
  }



}
