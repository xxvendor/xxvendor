import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../xx_util/color/color_util.dart';
import '../../../xx_util/image_picker/image_picker_util.dart';
import '../../xx_ui.dart';

export 'package:images_picker/images_picker.dart';

class XXImagePicker extends StatelessWidget {
  final String? galleryTitle;
  final TextStyle? galleryTextStyle;
  final String? cameraTitle;
  final TextStyle? cameraTextStyle;
  final String? cancelTitle;
  final TextStyle? cancelTextStyle;

  const XXImagePicker(
      {Key? key,
      this.galleryTitle,
      this.cameraTitle,
      this.cancelTitle,
      this.galleryTextStyle,
      this.cameraTextStyle,
      this.cancelTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: XXInkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container())),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                XXInkWell(
                  onTap: () {
                    Navigator.of(context).pop("camera");
                  },
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  inkShape: InkShape.roundedRectangle,
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    child: Text(
                      cameraTitle ?? "拍照",
                      style: TextStyle(
                        color: rgba(13, 17, 16, 1),
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                XXInkWell(
                  onTap: () {
                    Navigator.of(context).pop("gallery");
                  },
                  color: Colors.white,
                  inkShape: InkShape.roundedRectangle,
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    child: Text(
                      galleryTitle ?? "从相册上传",
                      style: TextStyle(
                        color: rgba(13, 17, 16, 1),
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 10,
                  color: const Color(0xffEDF0EF),
                ),
                XXInkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  inkShape: InkShape.roundedRectangle,
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    child: Text(
                      cancelTitle ?? "取消",
                      style: TextStyle(
                        color: rgba(13, 17, 16, 1),
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 34,
          )
        ]));
  }

  static Future<List<Media>?> show({
    String? galleryTitle,
    TextStyle? galleryTextStyle,
    String? cameraTitle,
    TextStyle? cameraTextStyle,
    String? cancelTitle,
    TextStyle? cancelTextStyle,
    required Function onNoPermissionCallback,
    required BuildContext context,
    PickType? pickType,
    int? count,
    bool? gif,
    int? maxTime,
    CropOption? cropOpt,
    int? maxSize,
    double? quality,
  }) async {
    List<Media>? list;
    var result = await showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 12),
              child: XXImagePicker(
                galleryTextStyle: galleryTextStyle,
                galleryTitle: galleryTitle,
                cameraTextStyle: cameraTextStyle,
                cameraTitle: cancelTitle,
                cancelTextStyle: cancelTextStyle,
                cancelTitle: cancelTitle,
              ));
        });
    if (result != null) {
      if (result == "camera") {
        list = await XXMediaPickerUtil.pickMediaByCamera(
            onNoPermissionCallback: onNoPermissionCallback,
            pickType: pickType ?? PickType.image,
            maxTime: maxTime ?? 120,
            cropOpt: cropOpt,
            maxSize: maxSize,
            quality: quality);
      } else if (result == "gallery") {
        list = await XXMediaPickerUtil.pickMediaByGallery(
            pickType: pickType ?? PickType.image,
            count: count ?? 1,
            gif: gif ?? true,
            maxTime: maxTime ?? 120,
            cropOpt: cropOpt,
            maxSize: maxSize,
            quality: quality,
            onNoPermissionCallback: onNoPermissionCallback);
      }
    }

    return list;
  }
}
