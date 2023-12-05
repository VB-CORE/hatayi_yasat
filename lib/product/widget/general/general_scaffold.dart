import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

/// Scaffold with padding for all project
final class GeneralScaffold extends Scaffold {
  GeneralScaffold({
    required Widget body,
    super.appBar,
    super.key,
  }) : super(
          body: Padding(
            padding: const PagePadding.horizontal16Symmetric(),
            child: body,
          ),
        );
}
