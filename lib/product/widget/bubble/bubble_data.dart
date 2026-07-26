import 'package:flutter/material.dart';

final class BubbleData {
  BubbleData({
    required this.key,
    required this.title,
    this.color = Colors.black,
    this.imageUrl,
    this.onTap,
  });

  final String key;
  final String title;
  final Color color;
  final String? imageUrl;
  final VoidCallback? onTap;
}
