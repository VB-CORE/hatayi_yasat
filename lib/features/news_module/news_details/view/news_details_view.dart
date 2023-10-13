import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

class NewsDetailsView extends StatefulWidget {
  const NewsDetailsView({required this.newsModel, super.key});
  final NewsModel newsModel;

  @override
  State<NewsDetailsView> createState() => _NewsDetailsViewState();
}

class _NewsDetailsViewState extends State<NewsDetailsView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
