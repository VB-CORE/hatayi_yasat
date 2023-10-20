import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/news_module/news/view/mixin/news_view_mixin.dart';
import 'package:vbaseproject/features/news_module/news_details/news_details_view.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/shimmer/news_shimmer_list.dart';
import 'package:vbaseproject/product/widget/card/news_card.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> with NewsViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirestoreListView<NewsModel?>(
        query: newsCollectionReference(),
        loadingBuilder: (_) => const NewsShimmerList(),
        emptyBuilder: (_) => NotFoundLottie(
          title: LocaleKeys.notFound_news.tr(),
          onRefresh: () {},
        ),
        itemBuilder: (context, doc) {
          final model = doc.data();
          if (model == null) return const SizedBox.shrink();
          return NewsCard(
            item: model,
            onTap: () {
              context.route.navigateToPage(NewsDetailsView(newsModel: model));
            },
          );
        },
      ),
    );
  }
}
