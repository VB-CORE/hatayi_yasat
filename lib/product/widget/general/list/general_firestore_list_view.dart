import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/shimmer/general_shimmer.dart';
import 'package:vbaseproject/product/utility/decorations/custom_shimmer_height.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';

typedef FireStoregeneralBuilder<T> = Widget Function(
  BuildContext context,
  T model,
);

@immutable
final class GeneralFirestoreListView<T> extends StatelessWidget {
  const GeneralFirestoreListView({
    required this.query,
    required this.itemBuilder,
    required this.onRetry,
    this.shrinkWrap = false,
    super.key,
  });

  final bool shrinkWrap;

  /// That's firebase query for any child
  /// Example: newsCollection _customService.collectionReference(CollectionPaths.news,NewsModel());
  final Query<T?> query;

  /// That's builder for any child
  final FireStoregeneralBuilder<T> itemBuilder;

  /// When data is fetching is fail and you want to retry it you can use this callback
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<T?>(
      query: query,
      shrinkWrap: shrinkWrap,
      physics: const ClampingScrollPhysics(),
      loadingBuilder: (_) =>
          const GeneralShimmer(height: CustomShimmerHeight.small),
      emptyBuilder: (_) => NotFoundLottie(
        title: LocaleKeys.notFound_news.tr(),
        onRefresh: onRetry,
      ),
      itemBuilder: (context, doc) {
        final model = doc.data();
        if (model == null) return const SizedBox.shrink();
        return itemBuilder.call(context, model);
      },
    );
  }
}
