import 'package:flutter/widgets.dart';

// Contract for the conditionally imported io/web implementations.
// ignore: one_member_abstracts
abstract interface class WebPageOpener {
  Future<void> open(BuildContext context, String url);
}
