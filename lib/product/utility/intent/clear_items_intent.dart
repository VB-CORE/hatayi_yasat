import 'package:flutter/material.dart';

class ClearItemsIntent extends Intent {
  const ClearItemsIntent();
}

class ClearItemsAction extends Action<ClearItemsIntent> {
  @override
  void invoke(covariant ClearItemsIntent intent) {}
}
