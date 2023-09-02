import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:vbaseproject/core/init/core_localize.dart';

@immutable
final class ApplicationInit {
  ApplicationInit();

  final CoreLocalize localize = CoreLocalize();

  /// The start function is a future that does not return any
  /// value and can be awaited.
  Future<void> start() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  }
}
