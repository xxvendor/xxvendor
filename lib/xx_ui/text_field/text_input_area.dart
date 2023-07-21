
import 'package:flutter/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:xx_vendor/xx_ui/text_field/text_field.dart';
import 'package:xx_vendor/xx_util/screen/screen_util.dart';

class XXTextInputArea extends StatefulWidget {
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final String? hintText;
  final String? text;
  final Color? color;
  final int maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final Border? border;
  final BorderRadius? borderRadius;
  final double? distance;
  final TextStyle? counterTextStyle;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final int? maxLines;

  const XXTextInputArea(
      {Key? key,
      this.width,
      this.height,
      this.textStyle,
      this.hintTextStyle,
      this.maxLength = 300,
      this.color,
      this.contentPadding,
      this.hintText,
      this.border,
      this.borderRadius,
      this.distance,
      this.counterTextStyle,
      required this.onChanged,
      required this.focusNode,
      this.maxLines = 6,
      this.text})
      : super(key: key);

  @override
  State<XXTextInputArea> createState() => _XXTextInputAreaState();
}

class _XXTextInputAreaState extends State<XXTextInputArea> {
  int length = 0;

  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    if (!GetUtils.isNullOrBlank(widget.text)!) {
      textEditingController.text = widget.text!;
      length = widget.text!.length;
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? getScreenWidth(),
      height: widget.height ?? 140,
      decoration: BoxDecoration(
          border: widget.border ??
              Border.all(color: const Color(0xffc4c4c4), width: 0.5),
          borderRadius: widget.borderRadius ??
              const BorderRadius.all(
                Radius.circular(2),
              ),
          color: widget.color),
      child: XXTextField(
        controller: textEditingController,
        contentPadding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 10,
        ),
        focusNode: widget.focusNode,
        onChanged: (value) {
          widget.onChanged(value);
        },
        style: widget.textStyle ??
            const TextStyle(
                color: Color(0xff333333),
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.47),
        hintStyle: widget.hintTextStyle ??
            const TextStyle(
                color: Color(0xffC5C5C5),
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.47),
        hintText: widget.hintText ?? "请详细描述您遇到的问题，建议附上截图，帮助我们更快定位您的问题",
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        buildCounter: (BuildContext context,
            {required int currentLength,
            required int? maxLength,
            required bool isFocused}) {
          return Container(
            height: 18,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(bottom: 6.0),
            transform: Matrix4.translationValues(0, -8, 0),
            child: Text(
              "$currentLength/$maxLength",
              style: TextStyle(
                color: currentLength >= widget.maxLength
                    ? Colors.red
                    : const Color(0xff666666),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        },
        inputFormatters: [
          NotFirstNullRegexFormatter(),
          FilteringTextInputFormatter(RegExp(r"\n"), allow: false),
        ],
      ),
    );
  }
}

class NotFirstNullRegexFormatter extends TextInputFormatter {
  /// 正则匹配第一个输入字符不能为空格
  static const String regex = r'^(\S){1}';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return TextEditingValue.empty;
    }

    if (!RegExp(regex).hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}
