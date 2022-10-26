import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xx_vendor/xx_ui/xx_ui.dart';


enum SendValidateStatus {
  idle,
  success,
  failed,
}

class ValidateCodeInputTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final GestureTapCallback onSendValidateCodeTap;
  final SendValidateStatus sendValidateStatus;

  const ValidateCodeInputTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.hintText = "请输入验证码",
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    required this.onSendValidateCodeTap,
    required this.sendValidateStatus,
  }) : super(key: key);

  @override
  State<ValidateCodeInputTextField> createState() =>
      _ValidateCodeInputTextFieldState();
}

class _ValidateCodeInputTextFieldState
    extends State<ValidateCodeInputTextField> {
  Timer? timer;
  int duration = 60;
  late StreamController<bool> focusStreamController;
  late StreamController<bool> valueStreamController;
  late StreamController<String> validateCodeStatusStreamController;
  late StreamController<bool> canTapStatusStreamController;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!timer.isActive) {
        if (!validateCodeStatusStreamController.isClosed) {
          validateCodeStatusStreamController.add("获取验证码");
        }

        if (!canTapStatusStreamController.isClosed) {
          canTapStatusStreamController.add(true);
        }
      } else {
        if (duration - timer.tick == 0) {
          cancelTimer();
          if (!validateCodeStatusStreamController.isClosed) {
            validateCodeStatusStreamController.add("获取验证码");
          }

          if (!canTapStatusStreamController.isClosed) {
            canTapStatusStreamController.add(true);
          }
        } else {
          if (!validateCodeStatusStreamController.isClosed) {
            validateCodeStatusStreamController.add("${duration - timer.tick}s");
          }

          if (!canTapStatusStreamController.isClosed) {
            canTapStatusStreamController.add(false);
          }
        }
      }
    });
  }

  cancelTimer() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
      timer = null;
    }
  }

  @override
  void initState() {
    super.initState();
    focusStreamController = StreamController.broadcast();
    valueStreamController = StreamController.broadcast();
    validateCodeStatusStreamController = StreamController.broadcast();
    canTapStatusStreamController = StreamController.broadcast();

    widget.focusNode.addListener(() {
      bool hasFocus = false;
      if (widget.focusNode.hasFocus) {
        hasFocus = true;
      } else {
        hasFocus = false;
      }
      focusStreamController.add(hasFocus);
    });

    widget.controller.addListener(() {
      bool hasText = false;
      if (widget.controller.text.isNotEmpty) {
        hasText = true;
      } else {
        hasText = false;
      }
      valueStreamController.add(hasText);
    });
  }

  getSendStateStr() {
    switch (widget.sendValidateStatus) {
      case SendValidateStatus.idle:
        validateCodeStatusStreamController.add("获取验证码");
        canTapStatusStreamController.add(true);
        break;
      case SendValidateStatus.success:
        startTimer();
        break;
      case SendValidateStatus.failed:
        validateCodeStatusStreamController.add("发送失败");
        canTapStatusStreamController.add(true);
        break;
    }
  }

  @override
  void dispose() {
    cancelTimer();
    focusStreamController.close();
    valueStreamController.close();
    valueStreamController.close();
    canTapStatusStreamController.close();
    widget.controller.dispose();
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getSendStateStr();
    return XXTextField(
        maxLines: 1,
        controller: widget.controller,
        filled: true,
        isCollapsed: true,
        keyboardType: TextInputType.number,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical:13),
        filledColor: const Color(0xffF7FAFA),
        hintText: widget.hintText ?? "请输入验证码",
        hintStyle: const TextStyle(
          color: Color(0xFFB4B8B7),
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.transparent)),
        enableBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.transparent)),
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
        inputFormatters: widget.inputFormatters ??
            [
              LengthLimitingTextInputFormatter(6),
              FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
            ],
        autoFocus: false,
        showCursor: true,
        cursorColor: Colors.orange,
        suffixIconConstraints: const BoxConstraints(maxWidth: 110, minWidth: 110),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder<bool>(
                stream: canTapStatusStreamController.stream,
                initialData: true,
                builder: (context, tapSnapShot) {
                  return StreamBuilder<String>(
                    stream: validateCodeStatusStreamController.stream,
                    initialData: "获取验证码",
                    builder: (context, snapShot) {
                      return XXInkWell(
                        color: Colors.transparent,
                        onTap: (tapSnapShot.data != null && tapSnapShot.data!)
                            ? () {
                                widget.onSendValidateCodeTap();
                              }
                            : null,
                        child: Container(
                          alignment: Alignment.center,
                          width: 90,
                          child: Text(
                            snapShot.data ?? "获取验证码",
                            style: const TextStyle(
                              color: Color(0xFF29CCB7),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: "PingFang SC",
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
            const SizedBox(
              width: 20,
            )
          ],
        ));
  }
}
