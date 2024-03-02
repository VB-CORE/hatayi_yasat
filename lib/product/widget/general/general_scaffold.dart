import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

/// Scaffold with padding for all project
final class GeneralScaffold extends Scaffold {
  GeneralScaffold({
    required Widget body,
    super.appBar,
    super.key,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.backgroundColor,
  }) : super(
          extendBody: true,
          body: Padding(
            padding: const PagePadding.horizontal16Symmetric(),
            child: body,
          ),
        );
}
