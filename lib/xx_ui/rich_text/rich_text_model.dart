import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextModel {
  bool isText;
  Widget? widget;
  String text;
  TextStyle? style;
  GestureRecognizer? recognizer;

  RichTextModel({
    this.isText = true,
    this.widget,
    this.text = "",
    this.style,
    this.recognizer,
  });
}
