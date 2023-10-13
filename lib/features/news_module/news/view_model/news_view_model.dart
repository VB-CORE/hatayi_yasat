import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/news_module/news/model/news_empty_model.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

class NewsViewModel extends StateNotifier<NewsState> {
  NewsViewModel({
    required ProductProvider productProvider,
    required CustomService customService,
  })  : _productProvider = productProvider,
        _customService = customService,
        super(const NewsState());

  final ProductProvider _productProvider;
  final CustomService _customService;

  Future<void> fetchNewsItemsAndSave() async {
    state = state.copyWith(isServiceRequestSending: true);

    final allNewsItems = await _customService.getList<NewsModel>(
      model: NewsEmptyModel.empty,
      path: CollectionPaths.news,
    );

    _productProvider.saveNews(allNewsItems);
    state = state.copyWith(
      isServiceRequestSending: false,
      newsItems: allNewsItems,
    );
  }
}

@immutable
class NewsState extends Equatable {
  const NewsState({
    this.isServiceRequestSending = false,
    this.newsItems = const [],
  });

  final bool isServiceRequestSending;
  final List<NewsModel> newsItems;

  bool get isEnabled => !isServiceRequestSending && newsItems.isNotEmpty;

  @override
  List<Object> get props => [isServiceRequestSending, newsItems];

  NewsState copyWith({
    bool? isServiceRequestSending,
    List<NewsModel>? newsItems,
  }) {
    return NewsState(
      isServiceRequestSending:
          isServiceRequestSending ?? this.isServiceRequestSending,
      newsItems: newsItems ?? this.newsItems,
    );
  }
}
