import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/news_module/news/view/mixin/news_view_mixin.dart';
import 'package:vbaseproject/features/news_module/news_details/news_details_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/package/shimmer/news_shimmer_list.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/size/widget_size.dart';
import 'package:vbaseproject/product/widget/card/news_card.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';

class NewsView extends ConsumerStatefulWidget {
  const NewsView({super.key});

  @override
  ConsumerState<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends ConsumerState<NewsView>
    with AutomaticKeepAliveClientMixin, NewsViewMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => fetchNewItemsWithRefresh(),
        child: CustomScrollView(
          slivers: [
            _PageBody(
              onRefresh: () async => fetchNewItemsWithRefresh(),
              items: items,
              isRequestSending: isRequestSending,
            ),
          ],
        ),
      ),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody({
    required this.items,
    required this.isRequestSending,
    required this.onRefresh,
  });
  final VoidCallback onRefresh;
  final List<NewsModel> items;
  final bool isRequestSending;
  @override
  Widget build(BuildContext context) {
    if (isRequestSending) {
      return const SliverFillRemaining(
        child: Padding(
          padding: PagePadding.onlyTop(),
          child: NewsShimmerList(),
        ),
      );
    }

    if (items.isEmpty) {
      return SliverFillRemaining(
        child: NotFoundLottie(
          title: LocaleKeys.notFound_news.tr(),
          onRefresh: onRefresh,
        ),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return NewsCard(
              item: items[index],
              onTap: () {
                context.route
                    .navigateToPage(NewsDetailsView(newsModel: items[index]));
              },
            );
          },
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: WidgetSizes.spacingXxl12,
          ),
        ),
      ],
    );
  }
}
