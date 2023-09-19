import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octo_image/octo_image.dart';

class XXImage extends StatelessWidget {
  final String imagePath;
  final BoxFit? fit;
  final Uint8List? uint8List;
  final Color? color;
  final double? width;
  final double? height;
  final double? size;
  final int? maxWidth;
  final int? maxHeight;
  final Widget? placeholderBuilder;
  final Widget? errorBuilder;

  const XXImage({
    Key? key,
    this.imagePath="",
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.size,
    this.placeholderBuilder,
    this.errorBuilder,
    this.color,
    this.uint8List,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (uint8List != null) {
      widget = thumbDataImageWidget();
    } else {
      if (imagePath.startsWith("https://") || imagePath.startsWith("http://")) {
        //networkImage
        widget = networkImageWidget(enableSvg: imagePath.endsWith(".svg"));
      } else if (imagePath.startsWith("assets/")) {
        //assetsImage
        widget = assetsImageWidget(enableSvg: imagePath.endsWith(".svg"));
      } else {
        //文件图片
        widget = fileImageWidget(enableSvg: imagePath.endsWith(".svg"));
      }
    }

    return widget;
  }

  Widget networkImageWidget({required bool enableSvg}) {
    return enableSvg
        ? SvgPicture.network(
            imagePath,
            color: color,
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            placeholderBuilder: (context) {
              return placeholderBuilder ??
                  SizedBox(
                    width: width,
                    height: height,
                  );
            },
          )
        : octoImageWidget(CachedNetworkImageProvider(imagePath,
            maxHeight: maxHeight, maxWidth: maxWidth));
  }

  Widget fileImageWidget({required bool enableSvg}) {
    return enableSvg
        ? SvgPicture.file(
            File(
              imagePath,
            ),
            color: color,
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            placeholderBuilder: (context) {
              return placeholderBuilder ??
                  Container(
                    width: width,
                    height: height,
                    color: const Color(0xfff4f4f4),
                  );
            },
          )
        : octoImageWidget(FileImage(
            File(
              imagePath,
            ),
          ));
  }

  Widget assetsImageWidget({required bool enableSvg}) {
    return enableSvg
        ? SvgPicture.asset(
            imagePath,
            color: color,
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            placeholderBuilder: (context) {
              return placeholderBuilder ??
                  SizedBox(
                    width: width,
                    height: height,
                  );
            },
          )
        : octoImageWidget(AssetImage(imagePath));
  }

  Widget thumbDataImageWidget() {
    return octoImageWidget(MemoryImage(uint8List!));
  }

  Widget octoImageWidget(ImageProvider imageProvider) {
    return OctoImage(
      width: (size == 0 || size == null) ? width : size,
      height: (size == 0 || size == null) ? height : size,
      color: color,
      image: imageProvider,
      //progressIndicatorBuilder与placeholderBuilder，2选1
      placeholderBuilder: (context) {
        return placeholderBuilder ??
            (imagePath.startsWith("https://") || imagePath.startsWith("http://")
                ? Container(
                    width: width,
                    height: height,
                    color: const Color(0xffE8EAEF),
                  )
                : SizedBox(
                    width: width,
                    height: height,
                  ));
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return errorBuilder ??
            Container(
              width: width,
              height: height,
              color: const Color(0xfff4f4f4),
            );
      },
      fit: fit,
    );
  }
}
