import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomSingleChildScroll extends StatelessWidget {
  const CustomSingleChildScroll({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.general.keyboardPadding),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: child,
      ),
    );
  }
}
