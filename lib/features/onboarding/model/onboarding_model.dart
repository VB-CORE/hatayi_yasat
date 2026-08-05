import 'package:flutter/material.dart';

final class OnboardingModel {
  const OnboardingModel({
    required this.category,
    required this.title,
    required this.desc,
    required this.chips,
    required this.color,
  });

  final String category;
  final String title;
  final String desc;
  final List<String> chips;
  final Color color;
}
