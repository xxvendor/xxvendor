class XXMedia {
  ///视频缩略图图片路径
  ///Video thumbnail image path
  String? thumbPath;

  ///视频路径或图片路径
  ///Video path or image path
  String? path;

  /// 文件大小
  double? size;

  XXMedia({
    this.path,
    this.thumbPath,
    this.size,
  });
}