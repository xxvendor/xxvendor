import 'package:flutter/material.dart';

import 'rich_text_model.dart';

export 'rich_text_model.dart';

class XXRichText extends StatelessWidget {
  final List<RichTextModel> richTextList;

  const XXRichText({Key? key, required this.richTextList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> list = [];
    for (var item in richTextList) {
      if (item.isText) {
        list.add(TextSpan(
          text: item.text,
          style: item.style,
          recognizer: item.recognizer,
        ));
      } else {
        list.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: item.widget ?? const SizedBox(),
        ));
      }
    }

    return RichText(
      text: TextSpan(
        text: "",
        children: list,
      ),
    );
  }
}
