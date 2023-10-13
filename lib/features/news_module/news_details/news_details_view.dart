import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/news_module/news_details/mixin/news_details_mixin.dart';
import 'package:vbaseproject/product/items/colors_custom.dart';
import 'package:vbaseproject/product/utility/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/size/widget_size.dart';

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
                return _SliverAppBar(
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
        style: context.general.textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: ColorsCustom.black,
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
        style: context.general.textTheme.bodyLarge!.copyWith(
          color: ColorsCustom.black,
        ),
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar({
    required this.isPinned,
    required this.model,
  });

  final bool isPinned;
  final NewsModel model;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: WidgetSizes.spacingXxlL14,
      pinned: true,
      leading: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              context.general.colorScheme.background.withOpacity(0.5),
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: context.general.colorScheme.background,
        ),
      ),
      actionsIconTheme: IconThemeData(
        color: context.general.colorScheme.onSurface,
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: isPinned
            ? Container(
                color: isPinned ? null : ColorsCustom.black.withOpacity(0.5),
                width: isPinned ? null : context.sized.width,
                child: Padding(
                  padding: const PagePadding.onlyLeft(),
                  child: Text(
                    model.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.general.textTheme.titleLarge?.copyWith(
                      color: isPinned
                          ? context.general.colorScheme.onSurface
                          : context.general.colorScheme.onSecondary,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        titlePadding: isPinned ? null : EdgeInsets.zero,
        centerTitle: false,
        background: Hero(
          tag: ValueKey(model.documentId),
          child: CustomNetworkImage(
            imageUrl: model.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
