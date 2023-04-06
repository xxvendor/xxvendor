import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
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
    return Platform.isAndroid
        ? await requestPermissions(permissionList: [
            Permission.storage,
            Permission.camera,
            Permission.microphone,
            Permission.photos,
          ])
        : true;
  }

  static Future<bool> requestLocationPermissions() async {
    return Platform.isAndroid
        ? await requestPermissions(permissionList: [
            Permission.location,
            Permission.locationAlways,
            Permission.locationWhenInUse,
          ])
        : true;
  }

  static Future<bool> requestPhoneStatusPermissions() async {
    return Platform.isAndroid
        ? await requestPermissions(permissionList: [
            Permission.phone,
          ])
        : true;
  }
}
