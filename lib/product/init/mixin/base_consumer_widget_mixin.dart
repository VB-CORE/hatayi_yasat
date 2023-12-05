import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

mixin BaseConsumerWidgetMixin on ConsumerWidget {
  ColorScheme colorScheme(BuildContext context) => context.general.colorScheme;
}
