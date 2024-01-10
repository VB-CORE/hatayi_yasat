import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/details/view/news_detail_view.dart';

mixin NewsDetailViewMixin on ConsumerState<NewsDetailView> {
  late final NewsModel news;

  @override
  void initState() {
    super.initState();
    news = widget.news;
  }

  Future<void> goBackAction() async {
    context.pop();
  }
}
