import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/widget/builder/web_shell.dart';

final class AppBuilder {
  AppBuilder._();

  static Widget build(BuildContext context, Widget? child) {
    final content = child ?? const SizedBox();
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: kIsWeb ? WebShell(child: content) : content,
    );
  }
}
