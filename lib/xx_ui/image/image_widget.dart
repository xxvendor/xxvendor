import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

import '../shape/shape.dart';
import 'image_style.dart';

export 'image_style.dart';

class XXImage extends StatelessWidget {
  final ImageStyle? imageStyle;
  final BoxShape? boxShape;
  final BorderRadius? borderRadius;
  final String imagePath;
  final BoxFit? fit;
  final Color? color;
  final double? width;
  final double? height;
  final double? size;
  final int? maxWidth;
  final int? maxHeight;
  final Widget? placeholderBuilder;
  final Widget? errorBuilder;

  const XXImage(
      {Key? key,
      this.boxShape,
      this.borderRadius,
      this.imageStyle = ImageStyle.assets,
      required this.imagePath,
      this.fit = BoxFit.contain,
      this.width,
      this.height,
      this.maxWidth,
      this.maxHeight,
      this.size,
      this.placeholderBuilder,
      this.errorBuilder,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget;
    switch (imageStyle) {
      case ImageStyle.file:
        widget = imageWidget(fileImageWidget());
        break;
      case ImageStyle.assets:
        widget = imageWidget(assetsImageWidget());
        break;
      case ImageStyle.network:
        widget = imageWidget(networkImageWidget());
        break;
      default:
        widget = imageWidget(networkImageWidget());
        break;
    }
    return widget;
  }

  ImageProvider networkImageWidget() {
    return CachedNetworkImageProvider(imagePath,
        maxHeight: maxHeight, maxWidth: maxWidth);
  }

  ImageProvider fileImageWidget() {
    return FileImage(
      File(
        imagePath,
      ),
    );
  }

  ImageProvider assetsImageWidget() {
    return AssetImage(imagePath);
  }

  Widget imageWidget(ImageProvider imageProvider) {
    return XXShape(
      borderRadius: borderRadius,
      boxShape: boxShape,
      child: OctoImage(
        width: (size == 0 || size == null) ? width : size,
        height: (size == 0 || size == null) ? height : size,
        color: color,
        image: imageProvider,
        //progressIndicatorBuilder与placeholderBuilder，2选1
        placeholderBuilder: (context) {
          return placeholderBuilder ?? const SizedBox();
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return errorBuilder ?? Container();
        },
        fit: fit,
      ),
    );
  }
}
