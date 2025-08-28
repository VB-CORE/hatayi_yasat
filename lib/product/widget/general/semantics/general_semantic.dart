import 'package:flutter/material.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic_keys.dart';

final class GeneralSemantic extends StatelessWidget {
  const GeneralSemantic({
    required this.child,
    required this.semanticKey,
    super.key,
  });
  final Widget child;
  final GeneralSemanticKeys semanticKey;
  @override
  Widget build(BuildContext context) {
    return Semantics(identifier: semanticKey.key, child: child);
  }
}
