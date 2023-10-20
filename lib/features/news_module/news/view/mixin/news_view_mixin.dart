import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/news_module/news/view/news_view.dart';

mixin NewsViewMixin on State<NewsView> {
  final CustomService _customService = FirebaseService();

  CustomService get customService => _customService;

  CollectionReference<NewsModel?> newsCollectionReference() {
    return _customService.collectionReference(
      CollectionPaths.news,
      NewsModel(),
    );
  }
}
