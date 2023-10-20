import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/news_module/news_details/mixin/news_details_mixin.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/sliver/home_appbar_sliver.dart';

class NewsDetailsView extends StatefulWidget {
  const NewsDetailsView({required this.newsModel, super.key});
  final NewsModel newsModel;

  @override
  State<NewsDetailsView> createState() => _NewsDetailsViewState();
}

class _NewsDetailsViewState extends State<NewsDetailsView>
    with NewsDetailsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: listenNotification,
        child: CustomScrollView(
          slivers: [
            ValueListenableBuilder<bool>(
              valueListenable: isPinnedNotifier,
              builder: (context, value, child) {
                return HomeAppBarSliver.fromNews(
                  isPinned: value,
                  model: newsModel,
                );
              },
            ),
            _SliverDetail(model: newsModel),
          ],
        ),
      ),
    );
  }
}

class _SliverDetail extends StatelessWidget {
  const _SliverDetail({
    required this.model,
  });

  final NewsModel model;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        _NewsTitle(model: model),
        _NewsContent(model: model),
      ]),
    );
  }
}

class _NewsTitle extends StatelessWidget {
  const _NewsTitle({
    required this.model,
  });

  final NewsModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.allLow() + const PagePadding.onlyTop(),
      child: SelectableText(
        model.title ?? '',
        style: context.general.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: ColorCommon(context).whiteAndBlackForTheme,
        ),
      ),
    );
  }
}

class _NewsContent extends StatelessWidget {
  const _NewsContent({
    required this.model,
  });

  final NewsModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.allLow(),
      child: SelectableText(
        model.content ?? '',
        textAlign: TextAlign.justify,
        style: context.general.textTheme.bodyLarge?.copyWith(
          color: ColorCommon(context).whiteAndBlackForTheme,
        ),
      ),
    );
  }
}
