import 'package:flutter/material.dart';

mixin LoadingNotifier<T extends StatefulWidget> on State<T> {
  final _loadingNotifier = ValueNotifier<bool>(false);

  ValueNotifier<bool> get loadingNotifier => _loadingNotifier;

  void showLoading() {
    _loadingNotifier.value = true;
  }

  void hideLoading() {
    _loadingNotifier.value = false;
  }
}
