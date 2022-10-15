import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XXGetBuilder<T extends GetxController> extends StatelessWidget {
  final Widget Function(T controller) builder;
  final T controller;
  final Object? id;
  final String? tag;

  const XXGetBuilder(
      {Key? key,
      required this.builder,
      this.id,
      this.tag,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(init: controller, id: id, tag: tag, builder: builder);
  }
}
