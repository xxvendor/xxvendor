import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xx_vendor/xx_ui/shape/shape.dart';

import '../../xx_ui/xx_ui.dart';

class DialogUtil {
  static Future showCenterDialog(
      {required BuildContext context,
      required String title,
      String? content,
      String? cancelText,
      String? confirmText}) async {
    return await showCupertinoDialog(
        context: context,
        builder: (_) {
          return Material(
            color: Colors.transparent,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(child: SizedBox()),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 290,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xff8E8D8C),
                              fontSize: 15,
                              height: 22 / 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        content == null || content.isEmpty
                            ? const SizedBox()
                            : Container(
                                alignment: Alignment.topCenter,
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 8),
                                child: Text(
                                  content,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xff12121A),
                                    fontSize: 15,
                                    height: 22 / 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 22,
                        ),
                        XXShape(
                          boxShape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          child: Container(
                              width: 290,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      child: XXInkWell(
                                    color: Colors.white,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 44,
                                      alignment: Alignment.center,
                                      child: Text(
                                        cancelText ?? "取消",
                                        style: const TextStyle(
                                          color: Color(0xff12121A),
                                          fontSize: 15,
                                          height: 21 / 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: XXInkWell(
                                    color: Colors.white,
                                    onTap: () {
                                      Navigator.of(context).pop("confirm");
                                    },
                                    child: Container(
                                      height: 44,
                                      alignment: Alignment.center,
                                      child: Text(
                                        confirmText ?? "确定",
                                        style: const TextStyle(
                                          color: Color(0xffFF661A),
                                          fontSize: 15,
                                          height: 21 / 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          );
        });
  }

  static Future showCenterTipDialog({
    required BuildContext context,
    required String title,
    String? cancelText,
    String? confirmText,
  }) async {
    return await showCupertinoDialog(
        context: context,
        builder: (_) {
          return Material(
            color: Colors.transparent,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(child: SizedBox()),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 290,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 29,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xff666666),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        XXShape(
                          boxShape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          child: Container(
                              width: 290,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: XXInkWell(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                                color: Colors.white,
                                onTap: () {
                                  Navigator.of(context).pop("confirm");
                                },
                                child: Container(
                                  width: 290,
                                  height: 44,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    confirmText ?? "确定",
                                    style: const TextStyle(
                                      color: Color(0xffF76A2B),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          );
        });
  }

  static Future showBottomSelectDialog(
      {required BuildContext context,
      required Widget child,
      bool? showSafeArea = false}) async {
    return await showCupertinoDialog(
        context: context,
        builder: (_) {
          return Material(
            color: Colors.transparent,
            child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                        child: XXInkWell(
                            color: Colors.transparent,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container())),
                    Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        child: child ?? const SizedBox()),
                    Container(
                      height: 10,
                      color: const Color(0xfff7f7f7),
                      width: MediaQuery.of(context).size.width,
                    ),
                    XXInkWell(
                      color: Colors.white,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            alignment: Alignment.center,
                            child: const Text(
                              "取消",
                              style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          showSafeArea ?? false
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .padding
                                          .bottom),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  static Future showBottomDialog(
      {required BuildContext context,
      required Widget child,
      bool? showSafeArea = false,
      double? maxHeight}) async {
    return await showCupertinoDialog(
        context: context,
        builder: (_) {
          return Material(
            color: Colors.transparent,
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  Expanded(
                      child: XXInkWell(
                          color: Colors.transparent,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container())),
                  Container(
                      height: maxHeight ?? 284,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: child ?? const SizedBox()),
                  showSafeArea ?? false
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).padding.bottom),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        });
  }
}
