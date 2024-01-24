import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

final class ProjectNavigation {
  ProjectNavigation(this.context);

  final BuildContext context;
  void replaceToWidget(Widget child) {
    context.route.navigation.pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => child,
      ),
    );
  }

  void pushToWidget(Widget child) {
    context.route.navigateToPage(child);
  }
}
