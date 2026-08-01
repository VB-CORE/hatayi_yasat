import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/features/details/view/news_detail_view.dart';
import 'package:lifeclient/features/main/news_jobs/model/news_feed_model.dart';
import 'package:lifeclient/product/utility/constants/index.dart';

mixin NewsDetailViewMixin on ConsumerState<NewsDetailView> {
  late final NewsFeedModel news;

  @override
  void initState() {
    super.initState();
    news = widget.news;
  }

  Future<void> goBackAction() async {
    context.pop();
  }

  void shareNews() {
    if (news.body.ext.isNullOrEmpty) return;
    final bodyBuilder = StringBuffer(news.title ?? AppConstants.appName)
      ..write('\n\n')
      ..write(news.body);
    bodyBuilder.toString().ext.share();
  }
}
